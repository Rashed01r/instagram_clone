import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:instagram/models/user.dart';
import 'package:instagram/resources/storegFirebase.dart';

class AuthUsers {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  //  sign up user
  Future<String> signUpUser({
    required String email,
    required String username,
    required String password,
    required String bio,
    required Uint8List file,
  }) async {
    String res = "some error occourred";
    try {
      if (email.isNotEmpty ||
          username.isNotEmpty ||
          password.isNotEmpty ||
          bio.isNotEmpty ||
          file != null) {
        // register user
        UserCredential credential =
            await firebaseAuth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        String imageUrl =
            await StorgeFB().uploadImageToStorge("profilePics", file, false);

        UserApp user = UserApp(
          username: username,
          uid: credential.user!.uid,
          imageUrl: imageUrl,
          email: email,
          followers: [],
          following: [],
          bio: bio,
        );
        // add user to database
        await firebaseFirestore
            .collection("users")
            .doc(credential.user!.uid)
            .set(
              user.tojson(),
            );

        res = "success";
      }
    } catch (e) {
      res = e.toString();
    }
    return res;
  }

  // login user

  Future<String> loginUser(
      {required String email, required String password}) async {
    String res = "some error";

    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        await firebaseAuth.signInWithEmailAndPassword(
            email: email, password: password);
        res = "success";
      } else {
        print("please enter all fields");
      }
    } catch (e) {
      res = e.toString();
    }
    return res;
  }

  Future<UserApp> getUserDetalis() async {
    var currentUser = firebaseAuth.currentUser!;

    DocumentSnapshot documentSnapshot =
        await firebaseFirestore.collection("users").doc(currentUser.uid).get();

    return UserApp.fromSnap(documentSnapshot);
  }

  // sign out user

  Future<void> signOut() async {
    await firebaseAuth.signOut();
  }
}
