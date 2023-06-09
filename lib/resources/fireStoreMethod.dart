import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instagram/models/post.dart';
import 'package:instagram/resources/storegFirebase.dart';
import 'package:uuid/uuid.dart';

class FireStoreMethod {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  //  upload post
  Future<String> uploadPost(
    String desc,
    Uint8List file,
    String uid,
    String username,
    String profImage,
  ) async {
    String res = "some error upload post";

    try {
      String photoUrl =
          await StorgeFB().uploadImageToStorge('posts', file, true);
      String postId = const Uuid().v1();
      Post post = Post(
        username: username,
        uid: uid,
        detePublished: DateTime.now(),
        postId: postId,
        postUrl: photoUrl,
        profImage: profImage,
        description: desc,
        likes: [],
      );
      _firestore.collection("posts").doc(postId).set(post.tojson());
      res = "success";
    } catch (e) {
      res = e.toString();
    }
    return res;
  }

  // Updating Likes

  Future<void> likePosts(String postId, String uid, List likes) async {
    try {
      if (likes.contains(uid)) {
        await _firestore.collection("posts").doc(postId).update({
          "likes": FieldValue.arrayRemove([uid])
        });
      } else {
        await _firestore.collection("posts").doc(postId).update({
          "likes": FieldValue.arrayUnion([uid])
        });
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<String> postComment(String postId, String text, String name,
      String uid, String profileImage) async {
    String res = "Some error occurred";

    String commentId = const Uuid().v1();

    try {
      if (text.isNotEmpty) {
        await _firestore
            .collection("posts")
            .doc(postId)
            .collection("comments")
            .doc(commentId)
            .set({
          'profileImage': profileImage,
          'name': name,
          'uid': uid,
          'text': text,
          'commentId': commentId,
          'datePublished': DateTime.now(),
        });
      } else {
        print("text is empty");
      }
    } catch (e) {
      print(e.toString());
    }
    return res;
  }

  // deleting post

  Future<void> deletePost(String postId) async {
    try {
      await _firestore.collection("posts").doc(postId).delete();
    } catch (e) {
      print(e.toString());
    }
  }

  // following profile fun

  Future<void> followUser(
    String uid,
    String followId,
  ) async {
    try {
      DocumentSnapshot snap =
          await _firestore.collection('users').doc(uid).get();
      List following = (snap.data()! as dynamic)['following'];

      if (following.contains(followId)) {
        await _firestore.collection('users').doc(followId).update({
          'followers': FieldValue.arrayRemove([uid])
        });
        await _firestore.collection('users').doc(uid).update({
          'following': FieldValue.arrayRemove([followId])
        });
      } else {
        await _firestore.collection('users').doc(followId).update({
          'followers': FieldValue.arrayUnion([uid])
        });
        await _firestore.collection('users').doc(uid).update({
          'following': FieldValue.arrayUnion([followId])
        });
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
