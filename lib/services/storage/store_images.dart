import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';

class StorageServices {
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<String> uploadImage({
    required noteImage,
    required courseId,
  }) async {
    try {
      Reference ref = _storage
          .ref()
          .child("note-images")
          .child("$courseId/${DateTime.now()}");
      UploadTask task =
          ref.putFile(noteImage, SettableMetadata(contentType: "image/jpeg"));
      TaskSnapshot snapshot = await task;
      String downloadUrl = await snapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      debugPrint(e.toString());
      return "";
    }
  }
}
