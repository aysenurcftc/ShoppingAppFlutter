

import 'package:cloud_firestore/cloud_firestore.dart';

class Users {
  final String username;
  final String uid;
  final String photoUrl;
  final String email;
  final String name;
  final String surname;
  final List followers;
  final List following;

  const Users(
      {required this.username,
        required this.uid,
        required this.photoUrl,
        required this.email,
        required this.name,
        required this.surname,
        required this.followers,
        required this.following});

  static Users fromSnap(DocumentSnapshot snap) {

    var snapshot = snap.data() as Map<String, dynamic>;

    return Users(
      username: snapshot["username"],
      uid: snapshot["uid"],
      email: snapshot["email"],
      photoUrl: snapshot["photoUrl"],
      name: snapshot["name"],
      surname: snapshot["surname"],
      followers: snapshot["followers"],
      following: snapshot["following"],
    );
  }

  Map<String, dynamic> toJson() => {
    "username": username,
    "uid": uid,
    "email": email,
    "photoUrl": photoUrl,
    "name": name,
    "surname": surname,
    "followers": followers,
    "following": following,
  };
}