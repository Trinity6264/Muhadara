import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:muhadara/model/post_content_model.dart';
import 'package:muhadara/shared/collor_pallet.dart';
import 'package:muhadara/view_models/view_all_view_model.dart';
import 'package:muhadara/views/widgets/shimmer_effect.dart';
import 'package:stacked/stacked.dart';

class ViewAllView extends StatelessWidget {
  final List<PostContentModel>? content;
  const ViewAllView({
    Key? key,
    this.content,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return ViewModelBuilder<ViewAllViewModel>.reactive(
      viewModelBuilder: () => ViewAllViewModel(),
      builder: (context, model, child) {
        return Scaffold(
          backgroundColor: Colors.greenAccent[100],
          appBar: AppBar(
            title: const Text('View All'),
            automaticallyImplyLeading: false,
            elevation: 0.0,
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'All Lectures',
                  style: TextStyle(
                    color: primaryColor,
                    fontSize: 20.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Expanded(
                child: ListView.separated(
                  shrinkWrap: true,
                  separatorBuilder: (context, index) => const Divider(),
                  itemCount: content?.length ?? 1,
                  itemBuilder: (context, index) {
                    final data = content?[index];
                    return ListTile(
                      leading: ClipRRect(
                        clipBehavior: Clip.hardEdge,
                        borderRadius: BorderRadius.circular(10.0),
                        child: CachedNetworkImage(
                          imageUrl: data!.imageurl.toString(),
                          useOldImageOnUrlChange: true,
                          placeholder: (context, index) {
                            return imageContainer();
                          },
                          errorWidget: (context, url, error) {
                            return Image.asset('images/noimage.jpg');
                          },
                          fit: BoxFit.cover,
                          height: _size.height * 0.1,
                          width: _size.width * 0.2,
                        ),
                      ),
                      title: Text(
                        data.lecturerName.toString(),
                        style: const TextStyle(
                          color: primaryColor,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      subtitle: Text(
                        data.lectureTitle.toString(),
                        style: const TextStyle(
                          color: primaryColor,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      trailing: IconButton(
                        onPressed: () {
                          showDownLoadBanner(model, context, data);
                          model
                              .openFiless(
                            data.audioUrl!,
                            data.imageurl!,
                            DateTime.now().millisecondsSinceEpoch.toString(),
                            data.lectureTitle.toString(),
                            data.lecturerName.toString(),
                          )
                              .onError((error, stackTrace) {
                            model.downloadFailed(error.toString());
                            hideDownLoadBanner(context);
                          }).whenComplete(() {
                            hideDownLoadBanner(context);
                            model.downLoadPositionStream?.close();
                          });
                        },
                        icon: const Icon(
                          Icons.download_for_offline_outlined,
                          color: primaryColor,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void hideDownLoadBanner(BuildContext context) {
    ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
  }

  void showDownLoadBanner(
      ViewAllViewModel model, BuildContext context, PostContentModel data) {
    ScaffoldMessenger.of(context).showMaterialBanner(
      MaterialBanner(
        backgroundColor: primaryColor,
        content: Text('Downloading ${data.lectureTitle}',
            style: const TextStyle(color: secColor)),
        forceActionsBelow: true,
        leading: StreamBuilder<double>(
            stream: model.downLoadPositionStream?.stream.asBroadcastStream(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                model.downloadFailed('Download Failed!');
                hideDownLoadBanner(context);
                model.downLoadPositionStream?.close();
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              }
              return CircularProgressIndicator.adaptive(
                value: snapshot.data,
              );
            }),
        actions: [
          TextButton(
            onPressed: () {
              hideDownLoadBanner(context);
            },
            child: const Text('Dismiss', style: TextStyle(color: secColor)),
          )
        ],
      ),
    );
  }
}
