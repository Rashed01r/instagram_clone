import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:instagram/screens/addPostScreen.dart';
import 'package:instagram/screens/favoritePage.dart';
import 'package:instagram/screens/homePage.dart';
import 'package:instagram/screens/profile_screen.dart';
import 'package:instagram/screens/searchPage.dart';

List<Widget> screens = [
  const HomePage(),
  const SearchPage(),
  const AddPostScreen(),
  const FavoritePage(),
  ProfileScreen(uid: FirebaseAuth.instance.currentUser!.uid),
];
