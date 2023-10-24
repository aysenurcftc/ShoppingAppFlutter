import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';


class ForgotPassScreen extends StatefulWidget {
  const ForgotPassScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPassScreen> createState() => _ForgotPassScreenState();
}

class _ForgotPassScreenState extends State<ForgotPassScreen> {

  var emailController = TextEditingController();



  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("img/login-bg/new.jpg"),
            fit: BoxFit.cover,
          )
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: Container(
            child: Center(
              child: Column(
                  children: [

                    Padding(
                      padding: const EdgeInsets.only(top: 200,bottom: 10),
                      child: const Text("Şifremi Unuttum",
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),),
                    ),




                    Padding(
                      padding: const EdgeInsets.only(left: 20,right: 20,bottom: 30),
                      child: TextField(
                        controller: emailController,
                        decoration: InputDecoration(
                            suffixIcon: Icon(Icons.mail),
                            fillColor: Colors.transparent,
                            filled: true,
                            hintText: "E-Posta",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            )
                        ),
                      ),
                    ),

                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(Colors.pinkAccent.shade100),
                        fixedSize: MaterialStateProperty.all<Size>(
                          Size(200, 50),
                        ),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      onPressed: (){

                      },
                      child: const Text("Şifremi Sıfırla"),
                    ),

                  ]
              ),
            ),
          ),
        ),
      ),
    );
  }
}
