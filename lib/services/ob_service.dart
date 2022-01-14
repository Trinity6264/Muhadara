import 'package:muhadara/model/search_model.dart';
import 'package:muhadara/objectbox.g.dart';
import 'package:objectbox/objectbox.dart';
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
}
