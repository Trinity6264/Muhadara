import 'package:objectbox/objectbox.dart';

@Entity()
class SearchModel {
  int? id;
  String? searchText;
  SearchModel({
    this.id = 0,
    this.searchText,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'searchText': searchText,
    };
  }

  factory SearchModel.fromMap(Map<String, dynamic> map) {
    return SearchModel(
      id: map['id']?.toInt(),
      searchText: map['searchText'],
    );
  }
}
