import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';

class FirestorageDb {
  static final FirebaseStorage _firebaseFirestorage = FirebaseStorage.instance;

  static uploadImage(
      String uid, String folderName, String fileName, File imageFile) async {
    var snapshot = await _firebaseFirestorage
        .ref()
        .child('${folderName}/${fileName}')
        .putFile(
            imageFile,
            SettableMetadata(customMetadata: {
              'user_uid': '${uid}',
            }));
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }
}
