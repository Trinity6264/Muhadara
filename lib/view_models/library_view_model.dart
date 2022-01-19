import 'dart:io';

import 'package:muhadara/app/app.locator.dart';
import 'package:muhadara/app/app.router.dart';
import 'package:muhadara/model/offline_download_model.dart';
import 'package:muhadara/services/ob_service.dart';
import 'package:muhadara/shared/collor_pallet.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class LibraryViewModel extends StreamViewModel<List<OfflineDownloadModel>> {
  final _obService = locator<ObService>();
  final _navService = locator<NavigationService>();
  final _snackService = locator<SnackbarService>();
  final _dialogService = locator<DialogService>();
  @override
  // TODO: implement stream
  Stream<List<OfflineDownloadModel>> get stream => _obService.fetchDownLoads;
  void toPlayer({
    required String audioUrl,
    required String imageurl,
    required String lectureTitle,
    required String lecturerName,
    required DateTime postedAt,
    required int index,
  }) {
    _navService.navigateTo(
      Routes.audioPlayerView,
      arguments: AudioPlayerViewArguments(
        index: index,
        audioUrl: audioUrl,
        imageurl: imageurl,
        lectureTitle: lectureTitle,
        lecturerName: lecturerName,
        postedAt: postedAt,
      ),
    );
  }

  void downloadFailed(String message) {
    _snackService.registerSnackbarConfig(SnackbarConfig(
      messageColor: secColor,
      maxWidth: 100,
    ));
    _snackService.showSnackbar(message: message);
  }

  void deleteItem(int id) async {
    final response = await _dialogService.showConfirmationDialog(
      cancelTitle: 'No',
      confirmationTitle: 'Yes',
      description: 'Do you want to Delete this file?',
      dialogPlatform: Platform.isAndroid
          ? DialogPlatform.Material
          : DialogPlatform.Cupertino,
    );
    if (response!.confirmed == true) {
      await _obService.deleteFile(id).then((value) {
        downloadFailed('File deleted');
      });
    }
  }
}
