import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

class StorgeFB {
  final FirebaseStorage firebaseStorage = FirebaseStorage.instance;
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  // add image firebase

  Future<String> uploadImageToStorge(
      String folderName, Uint8List file, bool isPost) async {
    Reference ref = firebaseStorage
        .ref()
        .child(folderName)
        .child(firebaseAuth.currentUser!.uid);
    if (isPost) {
      String id = const Uuid().v1();
      ref = ref.child(id);
    }
    UploadTask uploadTask = ref.putData(file);

    TaskSnapshot taskSnapshot = await uploadTask;
    String downloadUrl = await taskSnapshot.ref.getDownloadURL();

    return downloadUrl;
  }
}