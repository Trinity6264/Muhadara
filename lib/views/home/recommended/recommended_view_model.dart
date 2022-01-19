import 'dart:io';

import 'package:muhadara/app/app.locator.dart';
import 'package:muhadara/app/app.router.dart';
import 'package:muhadara/model/post_content_model.dart';
import 'package:muhadara/services/cloud_store_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class RecommendedViewModel extends BaseViewModel {
  final service = locator<CloudStoreService>();
  final _navService = locator<NavigationService>();
  bool isNotFound = false;

  static const endPoint = 'lecturerName';

  List<PostContentModel>? data;

  Future<List<PostContentModel>?> fecthAll() async {
    try {
      setBusy(true);
      data = await service.getPost(endPoint);
      setBusy(false);
      return data;
    } on SocketException catch (e) {
      isNotFound = true;
      notifyListeners();
    }
    return data;
  }

  void toPlayer({
    required String audioUrl,
    required String imageurl,
    required String lectureTitle,
    required String lecturerName,
    required DateTime postedAt,
  }) {
    _navService.navigateTo(
      Routes.audioPlayerView,
      arguments: AudioPlayerViewArguments(
        index: 0,
        audioUrl: audioUrl,
        imageurl: imageurl,
        lectureTitle: lectureTitle,
        lecturerName: lecturerName,
        postedAt: postedAt,
      ),
    );
  }
}
