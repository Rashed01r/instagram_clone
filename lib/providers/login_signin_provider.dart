import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram/resources/authUsers.dart';
import 'package:instagram/responsive/mobileScreenLayout.dart';
import 'package:instagram/responsive/responsiveLayoutScreen.dart';
import 'package:instagram/responsive/webScreenLayout.dart';

class LoginSigninProvider extends ChangeNotifier {
  bool isLoading = false;
  Uint8List? image;

  // select image profile sign up
  selectImage(ImageSource source) async {
    final ImagePicker imagePicker = ImagePicker();
    XFile? file = await imagePicker.pickImage(source: source);

    if (file != null) {
      return file.readAsBytes();
    }
    notifyListeners();
  }

  // upload image sign up

  void pickImage() async {
    Uint8List im = await selectImage(ImageSource.gallery);
    image = im;
    notifyListeners();
  }

  // fun sign up and verification fields
  void signUp(
      {required String email,
      required String username,
      required String password,
      required String bio,
      required Uint8List file,
      required BuildContext context}) async {
    isLoading = true;
    notifyListeners();
    String res = await AuthUsers().signUpUser(
      email: email,
      username: username,
      password: password,
      bio: bio,
      file: image!,
    );
    notifyListeners();
    isLoading = false;

    if (res != "success") {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("$res"),
        ),
      );
    } else {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) {
            return const ResponsiveLayout(
              webScreenLayout: WebScreenLayout(),
              mobileScreenLayout: MobileScreenLayout(),
            );
          },
        ),
      );
    }
  }

  // login user and verification fields

  void loginUser(
      {required String email,
      required String password,
      required BuildContext context}) async {
    isLoading = true;
    notifyListeners();
    String res = await AuthUsers().loginUser(email: email, password: password);

    if (res == "success") {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Logged in successfully"),
        ),
      );
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) {
            return const ResponsiveLayout(
              webScreenLayout: WebScreenLayout(),
              mobileScreenLayout: MobileScreenLayout(),
            );
          },
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("$res"),
        ),
      );
    }
    notifyListeners();
    isLoading = false;
  }
}
