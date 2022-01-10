
import 'package:muhadara/app/app.locator.dart';
import 'package:muhadara/app/app.router.dart';
import 'package:muhadara/model/post_content_model.dart';
import 'package:muhadara/model/user_model.dart';
import 'package:muhadara/services/cloud_store_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class TrendingViewModel extends BaseViewModel {  
    final service = locator<CloudStoreService>();
     final _navService = locator<NavigationService>();
    static const endPoint = 'lectureTitle';

  List<PostContentModel>? data;

  Future<List<PostContentModel>?> fecthAll() async {
    setBusy(true);
    data = await service.getPost(endPoint);
    setBusy(false);
    return data;
  }

  void toPlayer(PostContentModel postContent) {
    _navService.navigateTo(Routes.audioPlayerView,
        arguments: AudioPlayerViewArguments(content: postContent, index: 0));
  }
}
