import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:muhadara/app/app.locator.dart';
import 'package:muhadara/shared/collor_pallet.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class ViewAllViewModel extends BaseViewModel {
  final _snackService = locator<SnackbarService>();

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

  Future<File?> downLoad(String url, String filename) async {
    try {
      if (Platform.isAndroid) {
        if (await _requestPermit(Permission.storage)) {
          var status = await Permission.storage.isGranted;
          if (status) {
            Directory? appStorage = await getExternalStorageDirectory();
            debugPrint(appStorage?.path);
            String newPth = '';
            List<String> pathList = appStorage!.path.split('/');
            for (int i = 1; i < pathList.length; i++) {
              String folder = pathList[i];
              if (folder != 'files') {
                newPth += "/" + folder;
              } else {
                break;
              }
              // newPth = newPth + '/TnT';
              appStorage = await Directory(newPth).create();
              // print("Play" + appStorage.toString());
            }
            final file = File('${appStorage!.path}/$filename');
            final response = await Dio().get(url,
                options: Options(
                  responseType: ResponseType.bytes,
                  followRedirects: false,
                  receiveTimeout: 0,
                ), onReceiveProgress: (received, total) {
              if (total != -1) {
                debugPrint((received / total * 100).toStringAsFixed(0) + "%");
              }
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
      }
    } on FileSystemException catch (e) {
      debugPrint(e.path);
      debugPrint(e.osError.toString());
      debugPrint(e.message.toString());
      return null;
    }
  }

  Future<void> openFiless(String url, String filename) async {
    final file = await downLoad(url, filename);
    if (file == null) return;
    print('File in ${file.path}');
    OpenFile.open(file.path);
  }
}
