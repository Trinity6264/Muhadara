import 'dart:io';

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'package:muhadara/model/post_content_model.dart';
import 'package:muhadara/shared/collor_pallet.dart';
import 'package:muhadara/view_models/audio_player_view_model.dart';

class AudioPlayerView extends StatelessWidget {
  final String? audioUrl;
  final String? imageurl;
  final String? lectureTitle;
  final String? lecturerName;
  final DateTime? postedAt;
  final int? index;
  const AudioPlayerView({
    Key? key,
    this.audioUrl,
    this.imageurl,
    this.lectureTitle,
    this.lecturerName,
    this.postedAt,
    this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget buildTimer(Duration duration) {
      String twoDigits(int n) => n.toString().padLeft(2, '0');
      final minutes = twoDigits(duration.inMinutes.remainder(60));
      final seconds = twoDigits(duration.inSeconds.remainder(60));
      return Text(
        '$minutes: $seconds',
        style: const TextStyle(color: primaryColor),
      );
    }

    return ViewModelBuilder<AudioPlayerViewModel>.reactive(
      onModelReady: (model) => model.initAudioPlayer(audioUrl.toString()),
      builder:
          (BuildContext context, AudioPlayerViewModel model, Widget? child) {
        Size size = MediaQuery.of(context).size;
        return Scaffold(
          backgroundColor: secColor,
          appBar: AppBar(
            backgroundColor: secColor,
            elevation: 0.0,
            centerTitle: true,
            title: const Text(
              'Playing Now',
              style: TextStyle(
                color: primaryColor,
                fontSize: 17.0,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(40.0, 20.0, 40.0, 20.0),
                child: Card(
                  color: Colors.transparent,
                  elevation: 15.0,
                  shadowColor: Colors.indigo,
                  child: index == 1
                      ? Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                              fit: BoxFit.fill,
                              image: FileImage(File(
                                imageurl?.toString() ?? 'images/noimage.jpg',
                              )),
                            ),
                          ),
                          height: size.height * 0.4,
                          width: size.width * 1.4,
                        )
                      : Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                              fit: BoxFit.fill,
                              image: NetworkImage(
                                imageurl?.toString() ?? 'images/noimage.jpg',
                              ),
                            ),
                          ),
                          height: size.height * 0.4,
                          width: size.width * 1.4,
                        ),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: size.width - 110,
                child: Text(
                  lectureTitle.toString(),
                  softWrap: true,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.fade,
                  style: const TextStyle(
                    color: primaryColor,
                    fontWeight: FontWeight.w700,
                    wordSpacing: 1.5,
                    letterSpacing: 1.0,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: size.width - 140,
                child: Text(
                  lecturerName.toString(),
                  softWrap: true,
                  overflow: TextOverflow.fade,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: darkColor,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1.0,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10.0, 8.0, 10.0, 5.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () => model.mute(),
                      icon: Icon(
                        model.isMute
                            ? Icons.volume_mute
                            : Icons.volume_down_outlined,
                      ),
                    ),
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            model.repeatBtn();
                          },
                          icon: Icon(!model.isRepeat
                              ? Icons.repeat
                              : Icons.repeat_one_rounded),
                        ),
                        IconButton(
                          onPressed: () {
                            model.downloadFile(
                                audioUrl.toString(), lecturerName.toString());
                          },
                          icon: const Icon(Icons.download),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(15.0, 8.0, 15.0, 2.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    buildTimer(model.position),
                    buildTimer(model.duration),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(1.0, 1.0, 1.0, 10.0),
                child: Slider(
                  value: model.position.inSeconds.toDouble(),
                  min: 0.0,
                  max: model.duration.inSeconds.toDouble(),
                  activeColor: primaryColor,
                  inactiveColor: primaryColor,
                  onChanged: (value) {
                    model.changeToSecond(value.toInt());
                  },
                ),
              ),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: () {
                        model.slowBtn();
                      },
                      icon: const Icon(Icons.skip_previous_outlined),
                    ),
                    model.initialised
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : IconButton(
                            onPressed: () =>
                                model.playingState(audioUrl.toString()),
                            icon: Icon(
                              model.isPlaying ? Icons.pause : Icons.play_arrow,
                            )),
                    IconButton(
                      onPressed: () {
                        model.fastBtn();
                      },
                      icon: const Icon(Icons.skip_next_outlined),
                    ),
                  ],
                ),
              ),
              model.isDownloading
                  ? Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: LinearProgressIndicator(
                        minHeight: 6.0,
                        value: model.progressIndicato,
                      ),
                    )
                  : const SizedBox.shrink(),
            ],
          ),
        );
      },
      viewModelBuilder: () => AudioPlayerViewModel(),
    );
  }
}
