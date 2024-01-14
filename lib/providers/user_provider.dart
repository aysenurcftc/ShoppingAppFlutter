


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:senior_project/models/users.dart';
import 'package:senior_project/service/product_service.dart';



class  UserProvider with ChangeNotifier {


  Users _user = const Users(
    username: 'null',
    uid: 'null',
    email: 'null',
    photoUrl: 'null',
    name: 'null',
    surname: 'null',
    followers: [],
    following: [],
  );

  //Users? _user;

  ProductService _authMethods = ProductService();

  Users get getUser => _user;

  Future<void> fetchUser() async {
    try {
      var userData = await _authMethods.getUserData();

      if (userData is Users) {
        _user = userData;
      } else {
        print("getUserData metodundan beklenen tür Users değil. Alınan tür: ${userData.runtimeType}");
      }

      notifyListeners();
    } catch (e) {
      print("Error fetching user data: $e");
    }
  }




}