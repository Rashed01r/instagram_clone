import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram/resources/fireStoreMethod.dart';

class PostProvider extends ChangeNotifier {
  Uint8List? file;
  bool isLoading = false;

  selectImage(ImageSource source) async {
    final ImagePicker imagePicker = ImagePicker();
    XFile? file = await imagePicker.pickImage(source: source);

    if (file != null) {
      return file.readAsBytes();
    }
    notifyListeners();
  }

  // select image and show dialog add_post_screen
  selectImageDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          title: const Text("Create a post"),
          children: [
            SimpleDialogOption(
              padding: EdgeInsets.all(20),
              child: Text("Take a phato"),
              onPressed: () async {
                Navigator.of(context).pop();
                Uint8List _file = await selectImage(
                  ImageSource.camera,
                );
                file = _file;
                notifyListeners();
              },
            ),
            SimpleDialogOption(
              padding: EdgeInsets.all(20),
              child: Text("Take a gallery"),
              onPressed: () async {
                Navigator.of(context).pop();
                Uint8List _file = await selectImage(
                  ImageSource.gallery,
                );
                file = _file;
                notifyListeners();
              },
            ),
            SimpleDialogOption(
              padding: EdgeInsets.all(20),
              child: Text("Cansel"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void postImage(
    String uid,
    String username,
    String profileImage,
    String desc,
    BuildContext context,
  ) async {
    isLoading = true;

    notifyListeners();
    try {
      String res = await FireStoreMethod().uploadPost(
        desc,
        file!,
        uid,
        username,
        profileImage,
      );
      if (res == "success") {
        isLoading = false;
        file = null;
        notifyListeners();

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("posted"),
          ),
        );
      } else {
        isLoading = false;
        notifyListeners();

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(res),
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
        ),
      );
      notifyListeners();
    }
  }

  
}
