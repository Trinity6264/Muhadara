import 'dart:io';

import 'package:muhadara/app/app.locator.dart';
import 'package:muhadara/app/app.router.dart';
import 'package:muhadara/model/post_content_model.dart';
import 'package:muhadara/services/cloud_store_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class HomeSubViewModel extends BaseViewModel {
  final service = locator<CloudStoreService>();
  final _navService = locator<NavigationService>();
  bool isNotFound = false;
  static const endPoint = 'lecturerName';
  static const trending = 'lectureTitle';
  static const newRelease = 'postedAt';

  List<PostContentModel>? recommendedData = [];
  List<PostContentModel>? trendingData = [];
  List<PostContentModel>? newRealeseData = [];

  Future<void> fecthAll(int index) async {
    try {
      setBusy(true);
      if (index == 0) {
        // recommended
        recommendedData = await service.getPost(endPoint);
      } else if (index == 1) {
        trendingData = await service.getPost(trending);
      } else {
        newRealeseData = await service.getPost(newRelease);
      }
      setBusy(false);
    } on SocketException catch (e) {
      isNotFound = false;
      notifyListeners();
    }
  }

  void toAllViews(int index) {
    print(recommendedData!.length);
    _navService.navigateTo(Routes.viewAllView,
        arguments: ViewAllViewArguments(
          content: recommendedData,
        ));
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
