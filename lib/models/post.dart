import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  final String username;
  final String uid;
  final String description;
  final String postId;
  final detePublished;
  final String postUrl;
  final String profImage;
  final likes;

  const Post({
    required this.username,
    required this.uid,
    required this.detePublished,
    required this.postId,
    required this.postUrl,
    required this.profImage,
    required this.description,
    required this.likes,
  });

  Map<String, dynamic> tojson() => {
        "username": username,
        "uid": uid,
        "description": description,
        "postId": postId,
        "profImage": profImage,
        "postUrl": postUrl,
        "detePublished": detePublished,
        "likes": likes,
      };

  static Post fromSnap(DocumentSnapshot snap) {
    var snapShot = snap.data() as Map<String, dynamic>;

    return Post(
      username: snapShot['username'],
      uid: snapShot["uid"],
      description: snapShot["description"],
      postId: snapShot["postId"],
      profImage: snapShot["profImage"],
      postUrl: snapShot["postUrl"],
      detePublished: snapShot["detePublished"],
      likes: snapShot["likes"],
    );
  }
}
