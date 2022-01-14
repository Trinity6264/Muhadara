import 'package:muhadara/app/app.locator.dart';
import 'package:muhadara/app/app.router.dart';
import 'package:muhadara/model/post_content_model.dart';
import 'package:muhadara/model/search_model.dart';
import 'package:muhadara/services/cloud_store_service.dart';
import 'package:muhadara/services/ob_service.dart';
import 'package:muhadara/shared/collor_pallet.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class SearchViewModel extends StreamViewModel<List<SearchModel>> {
  final _store = locator<CloudStoreService>();
  final _snackBar = locator<SnackbarService>();
  final _obService = locator<ObService>();
  final _navService = locator<NavigationService>();

  List<PostContentModel> cloudStoreList = [];
  List<SearchModel?> storeList = [];

  Future<List<PostContentModel>?> fetchPost(String searchText) async {
    setBusy(true);
    final data = await _store.getSearch(searchText);
    setBusy(false);
    if (data.isEmpty) {
      _snackBar.registerSnackbarConfig(SnackbarConfig(messageColor: secColor));
      _snackBar.showSnackbar(message: 'No data found');
    }
    ;
    cloudStoreList = data;
    return data;
  }

  // insert data
  void addData(String searchText) {
    _obService.insertData(searchText);
  }

  void toPlayer(PostContentModel postContent) {
    _navService.navigateTo(
      Routes.audioPlayerView,
      arguments: AudioPlayerViewArguments(content: postContent, index: 0),
    );
  }

  @override
  // TODO: implement stream
  Stream<List<SearchModel>> get stream => _obService.fetchAllSearchText;
}
