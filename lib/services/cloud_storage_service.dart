import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class CloudStorageService {
  String? artWork;
  String? audioPath;
  double currentPercentage = 0;
  // upload image
  Future<String?> upLoadPic(File image) async {
    final _fileName = DateTime.now().millisecondsSinceEpoch.toString();
    Reference reference =
        FirebaseStorage.instance.ref('image').child(_fileName);
    UploadTask uploadTask = reference.putFile(image);
    TaskSnapshot snapshot = await uploadTask.whenComplete(() => null);
     artWork = await snapshot.ref.getDownloadURL();
    return artWork;
  }

  // upload audio
   UploadTask? upLoadAudio(File audio)  {
    try {
      final _fileName = DateTime.now().millisecondsSinceEpoch.toString();
    final reference = FirebaseStorage.instance.ref('audio').child(_fileName);
     return  reference.putFile(audio);
    } on FirebaseException catch (e) {
      return null;
    }
  }
}
