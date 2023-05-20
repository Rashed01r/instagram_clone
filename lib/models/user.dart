import 'package:cloud_firestore/cloud_firestore.dart';

class UserApp {
  final String username;
  final String uid;
  final String bio;
  final String email;
  final List followers;
  final List following;
  final String imageUrl;

  const UserApp({
    required this.username,
    required this.uid,
    required this.imageUrl,
    required this.email,
    required this.followers,
    required this.following,
    required this.bio,
  });

  Map<String, dynamic> tojson() => {
        "username": username,
        "uid": uid,
        "imageUrl": imageUrl,
        "email": email,
        "followers": followers,
        "following": following,
        "bio": bio,
      };

  static UserApp fromSnap(DocumentSnapshot snap) {
    var snapShot = snap.data() as Map<String, dynamic>;

    return UserApp(
      username: snapShot["username"],
      uid: snapShot["uid"],
      imageUrl: snapShot["imageUrl"],
      email: snapShot["email"],
      followers: snapShot["followers"],
      following: snapShot["following"],
      bio: snapShot["bio"],
    );
  }
}
