import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:muhadara/model/post_content_model.dart';
import 'package:muhadara/model/user_model.dart';

class CloudStoreService {
  final _user = FirebaseFirestore.instance.collection('Users');
  final _post = FirebaseFirestore.instance.collection('Content');

  // add new user
  Future addNewuser(UserModel userModel) async {
    return _user.doc(userModel.id).set(userModel.toMap());
  }

  // add new content
  Future addNewContent(PostContentModel postContent) async {
    return _post.add(postContent.toMap());
  }

  // reading content from firestore
  Future<List<PostContentModel>> getPost(String field) async {
    try {
      var postDocs =
          await _post.orderBy(field, descending: true).limit(20).get();
      if (postDocs.docs.isNotEmpty) {
        return postDocs.docs
            .map((e) => PostContentModel.fromMap(e.data()))
            .toList();
      }
    } on FirebaseException catch (e) {}
    return [];
  }
}
