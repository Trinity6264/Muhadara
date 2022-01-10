import 'package:firebase_auth/firebase_auth.dart';
import 'package:muhadara/app/app.locator.dart';
import 'package:muhadara/model/user_model.dart';
import 'package:muhadara/services/cloud_store_service.dart';

class FirebaseService {
  static final _auth = FirebaseAuth.instance;
  final _firestore = locator<CloudStoreService>();
  // Sign Up
  Future signUp(
      {required String name,
      required String email,
      required String password}) async {
    try {
      var _user = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await _user.user?.updateDisplayName(name);
      final userModel = UserModel(
        id: _user.user!.uid,
        userName: name,
        userEmail: email,
      );
      await _firestore.addNewuser(userModel);
      return _user.user != null;
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  Future loginWithEmailAndPassword({
    required String email,
    required String pass,
  }) async {
    try {
      var _user = await _auth.signInWithEmailAndPassword(
        email: email,
        password: pass,
      );
      return _user.user != null;
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  // check id user logged in\
  Future<bool> isLoggedIn() async {
    var user = _auth.currentUser;
    return user != null;
  }

  String? get displayName => _auth.currentUser?.displayName ?? 'New User';
  String? get uid => _auth.currentUser?.uid;
}
