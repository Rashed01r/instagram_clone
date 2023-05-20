import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instagram/models/user.dart';
import 'package:instagram/resources/authUsers.dart';
import 'package:instagram/resources/fireStoreMethod.dart';
import 'package:instagram/screens/loginScreen.dart';

class UserDataProvider extends ChangeNotifier {
  final AuthUsers _authUsers = AuthUsers();
  var userData = {};
  int postLength = 0;
  int followers = 0;
  int following = 0;
  bool isFolowwing = false;
  bool isLoadingProfile = false;
  bool isLoadingUser = false;

  UserApp? user;
  UserApp get getUser => user!;

  //  refresh user data
  Future<void> refreshUser() async {
    isLoadingUser = true;
    notifyListeners();
    try {
      UserApp _user = await _authUsers.getUserDetalis();
      user = _user;
      notifyListeners();
    } catch (e) {
      print(e.toString());
    }
    isLoadingUser = false;
    notifyListeners();
  }

  // get user data and post length

  getDataUser(String uid) async {
    isLoadingProfile = true;
    notifyListeners();
    try {
      var userSnap =
          await FirebaseFirestore.instance.collection("users").doc(uid).get();

      var postSnap = await FirebaseFirestore.instance
          .collection('posts')
          .where('uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .get();
      userData = userSnap.data()!;
      postLength = postSnap.docs.length;
      followers = userSnap.data()!['followers'].length;
      following = userSnap.data()!['following'].length;
      isFolowwing = userSnap
          .data()!['followers']
          .contains(FirebaseAuth.instance.currentUser!.uid);
      notifyListeners();
    } catch (e) {
      print(e.toString());
    }
    isLoadingProfile = false;
    notifyListeners();
  }

  // increase followers count

  increasefollowers() {
    FireStoreMethod().followUser(
      FirebaseAuth.instance.currentUser!.uid,
      userData['uid'],
    );
    isFolowwing = true;
    followers++;
    notifyListeners();
  }

  // increase followers count

  decreasefollowers() {
    FireStoreMethod().followUser(
      FirebaseAuth.instance.currentUser!.uid,
      userData['uid'],
    );
    isFolowwing = false;
    followers--;
    notifyListeners();
  }

  // sign out user

  signOut(BuildContext context) {
    AuthUsers().signOut();
    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (context) => LoginScreen(),
    ));
  }
}
