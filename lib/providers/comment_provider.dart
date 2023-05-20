import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:instagram/resources/fireStoreMethod.dart';

class CommentProvider extends ChangeNotifier {
  TextEditingController commentController = TextEditingController();
  int commnetLength = 0;

// refresh comments UI

  refreshComments(
    dynamic postId,
    String comment,
    String username,
    String uid,
    String imageUrl,
  ) async {
    await FireStoreMethod().postComment(
      postId,
      commentController.text,
      username,
      uid,
      imageUrl,
    );
    commentController.text = "";
    notifyListeners();
  }

  @override
  void dispose() {
    super.dispose();
    commentController.dispose();
  }

  gitComment(String postId) async {
    try {
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('posts')
          .doc(postId)
          .collection('comments')
          .get();

      commnetLength = snapshot.docs.length;
    } catch (e) {
      print(e.toString());
    }
  }
}
