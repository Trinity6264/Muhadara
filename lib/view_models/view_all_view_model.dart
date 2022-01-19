import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:muhadara/app/app.locator.dart';
import 'package:muhadara/services/file_download_service.dart';
import 'package:muhadara/services/ob_service.dart';
import 'package:muhadara/shared/collor_pallet.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class ViewAllViewModel extends BaseViewModel {
  final _snackService = locator<SnackbarService>();
  final _obService = locator<ObService>();
  final _fileDownloadService = locator<FileDownloadService>();
  double downLoadPosition = 0.0;
  bool isDownloading = false;

  StreamController<double>? downLoadPositionStream = StreamController();

  void downloadFailed(String message) {
    _snackService.registerSnackbarConfig(SnackbarConfig(
      messageColor: secColor,
    ));
    _snackService.showSnackbar(message: message);
  }

  void dispo() {
    downLoadPositionStream?.close();
  }

  FutureOr<File?> downLoad(String url, String filename, int index) async {
    try {
      if (Platform.isAndroid) {
        setBusy(true);
        if (await _fileDownloadService.requestPermit(Permission.storage)) {
          var status = await Permission.storage.isGranted;
          if (status) {
            String folder = index == 0
                ? await _fileDownloadService.createFolder('Audio')
                : await _fileDownloadService.createFolder('Artwork');
            final file = File('$folder/$filename');
            final response = await Dio().get(url,

                options: Options(
                  responseType: ResponseType.bytes,
                  followRedirects: false,
                  receiveTimeout: 0,
                ), onReceiveProgress: (received, total) {
              setBusy(false);
              if (total != -1) {
                downLoadPosition = received / total * 100 / 100;
                downLoadPositionStream?.add(downLoadPosition);
                notifyListeners();
              }
            }).whenComplete(() {
              downLoadPositionStream?.close();
            });
            final raf = file.openSync(mode: FileMode.write);
            raf.writeFromSync(response.data);
            await raf.close();
            _snackService.showSnackbar(
              message: 'Download successfully',
            );
            return file;
          }
        }
        setBusy(false);
      }
    } on FileSystemException catch (e) {
      debugPrint(e.path);
      debugPrint(e.osError.toString());
      debugPrint(e.message.toString());
      return null;
    }
  }

  Future<void> openFiless(
    String audioUrl,
    String imageUrl,
    String filename,
    String lectureTitle,
    String lecturerName,
  ) async {
    final audioFile = await downLoad(audioUrl, filename, 0);
    final artWorkFile = await downLoad(imageUrl, filename, 1);
    if (audioFile == null || artWorkFile == null) return;
    _obService.insertDownloadData(
      audioPath: audioFile.path,
      imagePath: artWorkFile.path,
      lectureTitle: lectureTitle,
      lecturerName: lecturerName,
      savedAt: DateTime.now(),
    );
    _snackService.showSnackbar(message: 'Downloaded successfully');
    print('File in ${artWorkFile.path}');
    // OpenFile.open(artWorkFile.path);
  }
}
