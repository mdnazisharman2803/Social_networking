import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String email;
  final String uid;
  final String imageUrl;
  final String username;
  final String about;
  final List followers;
  final List following;

  const User(
      {required this.username,
      required this.uid,
      required this.imageUrl,
      required this.email,
      required this.about,
      required this.followers,
      required this.following});

  static User fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return User(
      username: snapshot["username"],
      uid: snapshot["uid"],
      email: snapshot["email"],
      imageUrl: snapshot["imageUrl"],
      about: snapshot["about"],
      followers: snapshot["followers"],
      following: snapshot["following"],
    );
  }

  Map<String, dynamic> toJson() => {
        "username": username,
        "uid": uid,
        "email": email,
        "imageUrl": imageUrl,
        "about": about,
        "followers": followers,
        "following": following,
      };
}
