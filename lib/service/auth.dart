

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:senior_project/ui/bottomnav-screen.dart';
import 'package:senior_project/ui/login/login-screen.dart';






class AuthService {
  final userCollection = FirebaseFirestore.instance.collection("users");
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;


  /*
  // get user details
  Future<model.User> getUserDetails() async {
    User currentUser = auth.currentUser!;

    DocumentSnapshot documentSnapshot = await  _firestore.collection('users').doc(currentUser.uid).get();
    return model.User.fromSnap(documentSnapshot);
  }*/


  Future<void> signUp(BuildContext context, {
    required String name,
    required String surname,
    required String userName,
    required String email,
    required String phoneNumber,
    required String password,
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

          await userCollection.doc(user.uid).set({
            'userName': userName,
            'email': email,
            'name': name,
            'surname': surname,
            'phone': phoneNumber,
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
  }

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
  }

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
          title: Text('Sign Out'),
          content: Text('Are you sure you want to sign out?'),
          actions: <Widget>[
            TextButton(
              child: Text('No'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text(
                'Yes',
                style: TextStyle(
                  color: Colors.red,
                ),
              ),
              onPressed: () async {
                try {
                  await auth.signOut();
                  Fluttertoast.showToast(
                    msg: "Signed out",
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
/*
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:senior_project/ui/bottomnav-screen.dart';
import 'package:senior_project/ui/login/login-screen.dart';


class AuthService{

  final userCollection = FirebaseFirestore.instance.collection("users");
  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> signUp(BuildContext context, {required String name, required String surname,
    required String userName, required String email,required String phoneNumber, required String password}) async {

    final navigator = Navigator.of(context);

    try {
      final UserCredential userCredential = await auth.createUserWithEmailAndPassword(email: email,
          password: password);

      if (userCredential.user != null) {
        final currentUser = auth.currentUser;

        if (currentUser != null) {
          final user = currentUser;

          await userCollection.doc(user.uid).set({
            'userName': userName,
            'email': email,
            'name' : name,
            'surname': surname,
            'phone' : phoneNumber
          });
        }

        Fluttertoast.showToast(msg: "Registration successful", toastLength: Toast.LENGTH_LONG);

        navigator.push(MaterialPageRoute(builder: (context) => LoginScreen()));
      }
    } on FirebaseAuthException catch (e) {
      Fluttertoast.showToast(msg: e.message!, toastLength: Toast.LENGTH_LONG);
    }
  }



  Future<User?> signIn(BuildContext context ,{required String email, required String password}) async {

    final navigator = Navigator.of(context);
    try{
      final UserCredential userCredential = await auth.signInWithEmailAndPassword(email: email, password: password);


      if(userCredential.user != null){

        navigator.pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => Home()),
              (Route<dynamic> route) => false,
        );
      }

      return userCredential.user;
    }
    on FirebaseAuthException catch(e){
      Fluttertoast.showToast(msg: e.message!,toastLength: Toast.LENGTH_LONG); //kullanıcıya gelen hatayı gosteririz
    }

  }

  Future<UserCredential> signInWithGoogle() async {

    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();


    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

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
          title: Text('Sign Out'),
          content: Text('Are you sure you want to sign out?'),
          actions: <Widget>[
            TextButton(
              child: Text('No'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Yes',
                style: TextStyle(
                  color: Colors.red,
                ),),
              onPressed: () async {
                try {

                  await auth.signOut();
                  Fluttertoast.showToast(
                    msg: "Signed out",
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
*/