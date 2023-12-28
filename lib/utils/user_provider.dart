import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserProvider with ChangeNotifier {
  FirebaseAuth auth = FirebaseAuth.instance;
  String _username = "Kullanıcı Adı";

  String get username => _username;

  UserProvider() {
    // Başlangıçta kullanıcı adını Firebase'den al
    _initializeUsername();
  }

  Future<void> _initializeUsername() async {
    await getUserName();
    notifyListeners();
  }

  Future<void> getUserName() async {
    User? user = auth.currentUser;

    if (user != null) {
      DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
          .collection("users")
          .doc(user.uid)
          .get();

      Map<String, dynamic>? userData = userSnapshot.data() as Map<String, dynamic>?;

      if (userData != null) {
        _username = userData['userName'] ?? '';
      }
    }
  }

  void updateUser(String newUsername) {
    _username = newUsername;
    notifyListeners();
  }
}