

import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:senior_project/ui/bottomnav-screen.dart';

class EmailVerificationScreen extends StatefulWidget {
  const EmailVerificationScreen({super.key});

  @override
  State<EmailVerificationScreen> createState() => _EmailVerificationScreenState();
  
}


class _EmailVerificationScreenState extends State<EmailVerificationScreen> {

  final auth = FirebaseAuth.instance;
  late User user;
  late Timer timer;

  @override
  void initState() {
    super.initState();
    user = auth.currentUser!;
    user.sendEmailVerification();

    timer = Timer.periodic(Duration(seconds: 5), (timer) {
      checkEmailVerified();

    });

  }

  Future<dynamic> checkEmailVerified() async {
    user = auth.currentUser!;
    await user.reload();
    if(user.emailVerified){
      timer.cancel();
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Home()));
      return user.emailVerified;
    }
    return false;
  }





  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 300),
          child: Column(

            children: [
               Center(
                child: Text(
                  "Hesabınızı doğrulamak ve etkinleştirmek için e-postanızı kontrol edin.",
                  textAlign: TextAlign.center,
                ),
              ),
              Container(
                width: 200,
                  height: 200,
                  child: Image.asset("img/verify.png"))
            ],
          ),
        ),
      ),
    );
  }
}

