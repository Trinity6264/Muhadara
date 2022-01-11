import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:muhadara/app/app.locator.dart';
import 'package:muhadara/shared/collor_pallet.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class AudioPlayerViewModel extends BaseViewModel {
  final _snackBar = locator<SnackbarService>();
  bool isPlaying = false;
  bool isMute = false;
  bool isRepeat = false;
  double progressIndicato = 0.0;
  Dio? _dio;
  Duration duration = const Duration();
  Duration position = const Duration();
  AudioPlayer? _audioPlayer;
  PlayerState? playerState;

  void initAudioPlayer(String url) async {
    _dio = Dio();
    setBusy(true);

    _audioPlayer = AudioPlayer(mode: PlayerMode.MEDIA_PLAYER, playerId: '');
    int? playing = await _audioPlayer?.play(url);
    if (playing == 1 && _audioPlayer?.state == PlayerState.PLAYING) {
      isPlaying = true;
      _audioPlayer?.setPlaybackRate(rate);
      setBusy(false);
      notifyListeners();
    } else {
      setBusy(false);
      await _audioPlayer?.stop();
      _snackBar.registerSnackbarConfig(SnackbarConfig(messageColor: secColor));
      _snackBar.showSnackbar(message: 'Could not play song');
    }
    _audioPlayer?.onAudioPositionChanged.listen((pos) {
      position = pos;
      notifyListeners();
    });
    _audioPlayer?.onDurationChanged.listen((dur) {
      duration = dur;
      notifyListeners();
    });

    _audioPlayer?.onPlayerCompletion.listen((event) {
      position = const Duration(seconds: 0, minutes: 0);
      isPlaying = false;
      notifyListeners();
    });
  }

  void playingState(String url) {
    if (isPlaying == false) {
      _audioPlayer?.play(url);
      isPlaying = true;
    } else {
      _audioPlayer?.pause();
      isPlaying = false;
    }
    notifyListeners();
  }

  void stop() {
    _audioPlayer?.stop();
    isPlaying = false;
    notifyListeners();
  }

  void mute() {
    isMute = !isMute;
    if (isMute) {
      _audioPlayer?.setVolume(0);
    } else {
      _audioPlayer?.setVolume(1);
    }
    notifyListeners();
  }

  void changeToSecond(int second) {
    Duration _duration = Duration(seconds: second);
    _audioPlayer?.seek(_duration);
    notifyListeners();
  }

// todo: to download files

  bool isDownloading = false;

  Future<bool?> savedFile(String url, String fileName) async {
    Directory? _diretory;
    try {
      if (Platform.isAndroid) {
        if (await _requestPermit(Permission.storage)) {
          _diretory = await getExternalStorageDirectory();
          String newPth = '';
          print(_diretory);
          List<String>? folders = _diretory?.path.split('/');
          for (int i = 1; i < folders!.length; i++) {
            String folder = folders[i];
            if (folder != 'Android') {
              newPth += "/" + folder;
            } else {
              break;
            }
            newPth = newPth + '/muhadara';
            _diretory = Directory(newPth);
            print("Play" + _diretory.toString());
          }
        } else {
          // todo show snackBar that the user denied permission
          _snackBar.showSnackbar(message: 'Permission denied');
        }
      } else {}
      if (!await _diretory!.exists()) {
        await _diretory.create(recursive: true);
      }
      if (await _diretory.exists()) {
        File savedFile = File(_diretory.path + '/$fileName');
        await _dio?.download(url, savedFile,
            onReceiveProgress: (received, total) {
          if (total != -1) {
            debugPrint((received / total * 100).toStringAsFixed(0) + "%");
          }
        });
      }
    } catch (e) {
      print(e);
    }
    return true;
  }

  Future<bool> _requestPermit(Permission permission) async {
    if (await permission.isGranted) {
      return true;
    } else {
      var result = await permission.request();
      if (result.isGranted) {
        return true;
      } else {
        return false;
      }
    }
  }

  Future<void> downloadFile(String url, String fileName) async {
    isDownloading = true;
    bool? downloaded = await savedFile(url, fileName);
    if (downloaded!) {
      print('File downloaded');
    } else {
      print('Problem saving File');
    }
    isDownloading = false;
    notifyListeners();
  }

  double rate = 1.0;
  void slowBtn() {
    if (isPlaying) {
      if (rate == 0.5) return;
      rate -= 0.5;
      _audioPlayer?.setPlaybackRate(rate);
      _snackBar.registerSnackbarConfig(SnackbarConfig(messageColor: secColor));
      _snackBar.showSnackbar(
        message: 'Speed Frequency: $rate',
        duration: const Duration(seconds: 1),
      );
    }
  }

  void fastBtn() {
    if (isPlaying) {
      if (rate == 2.0) return;
      rate += 0.5;
      _audioPlayer?.setPlaybackRate(rate);
      _snackBar.registerSnackbarConfig(SnackbarConfig(messageColor: secColor));
      _snackBar.showSnackbar(
        message: 'Speed Frequency: $rate',
        duration: const Duration(seconds: 1),
      );
    }
  }

  void repeatBtn() {
    isRepeat = !isRepeat;
    if (isRepeat) {
      _audioPlayer?.setReleaseMode(ReleaseMode.LOOP);
    } else {
      _audioPlayer?.setReleaseMode(ReleaseMode.STOP);
    }
    notifyListeners();
  }
}
