

import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:senior_project/resources/storage_methods.dart';
import 'package:senior_project/ui/bottomnav-screen.dart';
import 'package:senior_project/ui/login/login-screen.dart';



class AuthService {
  final userCollection = FirebaseFirestore.instance.collection("users");

  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;


  Future<String?> getCurrentUserId() async {
    try {
      User? user = auth.currentUser;
      if (user != null) {
        return user.uid;
      } else {
        // Kullanıcı oturum açmamışsa null dönebilirsiniz.
        return null;
      }
    } catch (e) {
      print("Kullanıcı kimliği alınırken hata oluştu: $e");
      return null;
    }
  }




  Future<Map<String, dynamic>?> getCurrentUser() async {
    try {
      User? user = auth.currentUser;

      if (user != null) {
        DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
            .collection("users")
            .doc(user.uid)
            .get();

        Map<String, dynamic>? userData = userSnapshot.data() as Map<String, dynamic>?;

        return userData;
      } else {
        // User not signed in
        return null;
      }
    } catch (e) {
      print("Error while getting user data: $e");
      return null;
    }
  }


  Future<bool> updatePassword(String currentPassword, String newPassword) async {
    try {
      // Get the current user
      User? currentUser = auth.currentUser;

      if (currentUser != null) {
        AuthCredential credential =
        EmailAuthProvider.credential(email: currentUser.email!, password: currentPassword);
        await currentUser.reauthenticateWithCredential(credential);
        // Update the password
        await currentUser.updatePassword(newPassword);
        return true; // Password update successful
      } else {
        print('User is not logged in');
        return false; // User is not logged in
      }
    } on FirebaseAuthException catch (e) {
      print('Error updating password: $e');
      return false; // Password update failed
    }
  }




  Future<String?> getCurrentUsername() async {
    try {
      User? user = auth.currentUser;
      if (user != null) {
        DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
            .collection("users")
            .doc(user.uid)
            .get();

        Map<String, dynamic>? userData = userSnapshot.data() as Map<String, dynamic>?;

        return userData?['userName'];
      } else {
        // Kullanıcı oturum açmamışsa null dönebilirsiniz.
        return null;
      }
    } catch (e) {
      print("Kullanıcı adı alınırken hata oluştu: $e");
      return null;
    }
  }



  /*
  Future<void> signUp(BuildContext context, {
    required String name,
    required String surname,
    required String userName,
    required String email,
    required String phoneNumber,
    required String password,
    required Uint8List file,
  }) async {
    final navigator = Navigator.of(context);

    try {
      final UserCredential userCredential = await auth
          .createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (userCredential.user != null) {
        final currentUser = auth.currentUser;

        if (currentUser != null) {
          final user = currentUser;

          String photoUrl = await StorageMethods().uploadImageToStorage('profilePics', file, false);

          await userCollection.doc(user.uid).set({
            'userName': userName,
            'email': email,
            'name': name,
            'surname': surname,
            'phone': phoneNumber,
            'like' : [],
            'followers' : [],
            'following' : [],
            'photoUrl': photoUrl,
          });

        }

        Fluttertoast.showToast(
          msg: "Registration successful",
          toastLength: Toast.LENGTH_LONG,
        );

        navigator.push(MaterialPageRoute(builder: (context) => LoginScreen()));
      }
    } on FirebaseAuthException catch (e) {
      Fluttertoast.showToast(msg: e.message!, toastLength: Toast.LENGTH_LONG);
    }
  }*/



  Future<String> signupUser ({
    required String name,
    required String surname,
    required String userName,
    required String email,
    required String password,
    required Uint8List file,

  }) async{

    String res = "Some error occured!";
    try{

      if (Firebase.apps.isEmpty) {
        await Firebase.initializeApp();
      }

      if(email.isNotEmpty || password.isNotEmpty || userName.isNotEmpty || name.isNotEmpty || surname.isNotEmpty || file != null){

        //register user
        UserCredential cred = await auth.createUserWithEmailAndPassword(email: email, password: password);
        print(cred.user!.uid);

        String photoUrl = await StorageMethods().uploadImageToStorage("profilePics", file, false);

        //add user to database
        await _firestore.collection("users").doc(cred.user!.uid).set({
          'name' : name,
          'surname' : surname,
          'username' : userName,
          'uid' : cred.user!.uid,
          'email' : email,
          'followers' : [],
          'following' : [],
          'photoUrl' : photoUrl,
        });

        res = "success";
      }
    }
    catch(err){
      print('Hata yakalandı: $err');
      res = err.toString();
    }
    return res;
  }



  //login in user

  Future<String> loginUser({
    required String email,
    required String password,
  }) async {
    String res = "Some error occured!";

    try{
      if(email.isNotEmpty || password.isNotEmpty){
        await auth.signInWithEmailAndPassword(email: email, password: password);
        res = "success";

      }
      else{
        res = "Please enter all the fields";
      }

    }
    catch(err){
      res = err.toString();
    }
    return res;

  }







  /*
  Future<User?> signIn(BuildContext context,
      {required String email, required String password}) async {
    final navigator = Navigator.of(context);

    try {
      final UserCredential userCredential = await auth
          .signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (userCredential.user != null) {
        navigator.pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => Home()),
              (Route<dynamic> route) => false,
        );
      }

      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      Fluttertoast.showToast(msg: e.message!, toastLength: Toast.LENGTH_LONG);
    }
  }*/

  Future<UserCredential> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    final GoogleSignInAuthentication? googleAuth = await googleUser
        ?.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    return await FirebaseAuth.instance.signInWithCredential(credential);
  }




  Future<void> signOut(BuildContext context) async {
    final navigator = Navigator.of(context);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Çıkış Yap'),
          content: Text('Çıkış yapmak istediğinizden emin misiniz?'),
          actions: <Widget>[
            TextButton(
              child: Text('Hayır'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text(
                'Evet',
                style: TextStyle(
                  color: Colors.red,
                ),
              ),
              onPressed: () async {
                try {
                  await auth.signOut();
                  Fluttertoast.showToast(
                    msg: "Çıkış yapıldı",
                    toastLength: Toast.LENGTH_LONG,
                  );
                  navigator.pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                        (Route<dynamic> route) => false,
                  );
                } catch (e) {
                  print(e);
                }
              },
            ),
          ],
        );
      },
    );
  }

}