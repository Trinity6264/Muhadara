import 'package:muhadara/model/offline_download_model.dart';
import 'package:muhadara/model/search_model.dart';
import 'package:muhadara/objectbox.g.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class ObService {
  Store? _store;

  Future initStore() async {
    await getApplicationDocumentsDirectory().then((dir) {
      _store = Store(
        getObjectBoxModel(),
        directory: join(dir.path, 'searchcollections'),
      );
    });
  }

  // insert data

  int? insertData(String searchText) {
    final userData = SearchModel(searchText: searchText);
    final response = _store?.box<SearchModel>();
    final data = response?.put(userData, mode: PutMode.put);
    return data;
  }

  List<SearchModel>? fetchData() {
    final response = _store?.box<SearchModel>();
    final data = response?.getAll();
    return data;
  }

  void dispose() {
    _store?.close();
  }

  // fetch all customers
  Stream<List<SearchModel>> get fetchAllSearchText => _store!
      .box<SearchModel>()
      .query()
      .watch(triggerImmediately: true)
      .map((event) => event.find());

  // todo for downloads
  // insert data

  int? insertDownloadData({
    required String audioPath,
    required String imagePath,
    required String lecturerName,
    required String lectureTitle,
    required DateTime savedAt,
  }) {
    final downLoadData = OfflineDownloadModel(
      audioPath: audioPath,
      imagePath: imagePath,
      lectureTitle: lectureTitle,
      lecturerName: lecturerName,
      savedAt: savedAt,
    );
    final response = _store?.box<OfflineDownloadModel>();
    final data = response?.put(downLoadData, mode: PutMode.insert);
    return data;
  }

  Stream<List<OfflineDownloadModel>> get fetchDownLoads => _store!
      .box<OfflineDownloadModel>()
      .query()
      .watch(triggerImmediately: true)
      .map((event) => event.find());
  // DELETE DOWNLOAD
  Future<bool?> deleteFile(int id) async {
    final data = _store?.box<OfflineDownloadModel>();
    final response = data?.remove(id);
    return response;
  }
}
