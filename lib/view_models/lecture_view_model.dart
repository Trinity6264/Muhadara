import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:muhadara/app/app.locator.dart';
import 'package:muhadara/model/post_content_model.dart';
import 'package:muhadara/services/cloud_storage_service.dart';
import 'package:muhadara/services/cloud_store_service.dart';
import 'package:muhadara/services/file_selected_service.dart';
import 'package:muhadara/shared/collor_pallet.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class LectureViewModel extends BaseViewModel {
  final _snack = locator<SnackbarService>();
  final _audio = locator<FileSelectService>();
  final _store = locator<CloudStoreService>();
  final _storage = locator<CloudStorageService>();
  File? _imageSelect;
  File? get imageSelect => _imageSelect;
  File? _audioSelect;
  File? get audioSelect => _audioSelect;
  UploadTask? task;

//  get image from internal or external path
  Future<void> getImage() async {
    var tempImage = await _audio.pickImage();
    if (tempImage != null) {
      _imageSelect = File(tempImage.files.single.path.toString());
      notifyListeners();
    }
  }

//  get audio from internal or external path
  Future<void> getAudio() async {
    var tempAudio = await _audio.pickAudio();
    if (tempAudio != null) {
      _audioSelect = File(tempAudio.files.single.path.toString());
      notifyListeners();
    }
  }

// upload files to firebase storage and get the path link then store them on firestore
  static const errorMessage = 'One or more fields is empty';
  Future<void> uploadContent(String lectureText, String lecturerText) async {
    if (_audioSelect == null ||
        _imageSelect == null ||
        lectureText.trim().isEmpty ||
        lecturerText.trim().isEmpty) {
      _snack.registerSnackbarConfig(
        SnackbarConfig(
          messageColor: secColor,
        ),
      );
      _snack.showSnackbar(message: errorMessage);
    } else {
      setBusy(true);
      task = _storage.upLoadAudio(audioSelect!);
      final snapshot = await task!.whenComplete(() {});
      final urlDownload = await snapshot.ref.getDownloadURL();
      await _storage.upLoadPic(imageSelect!);
      final model = PostContentModel(
        audioUrl: urlDownload,
        imageurl: _storage.artWork,
        lectureTitle: lectureText.trim(),
        lecturerName: lecturerText.trim(),
        postedAt: DateTime.now(),
      );
      await _store.addNewContent(model).whenComplete(() {
        _snack.registerSnackbarConfig(
          SnackbarConfig(
            messageColor: secColor,
          ),
        );
        _snack.showSnackbar(message: 'Uploaded successfully');
      });
      setBusy(false);
      task = null;
      _imageSelect = null;
      _audioSelect = null;
      notifyListeners();
    }
  }
}
