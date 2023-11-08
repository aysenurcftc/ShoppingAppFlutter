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
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  Future passwordReset() async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: emailController.text.trim());
      showDialog(context: context, builder: (context){
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20), // Kenar yarıçapını ayarlayın
          ),
          content: Text("Password reset link sent! Check your email"),
        );
      });

    } on FirebaseAuthException catch (e) {
      print(e);
      showDialog(context: context, builder: (context){
        return AlertDialog(
          content: Text(e.message.toString()),
        );
      });
    }
  }

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
                      padding: const EdgeInsets.only(top: 200,bottom: 60),
                      child: const Text("Şifremi Unuttum",
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),


                    Padding(
                      padding: const EdgeInsets.only(left: 20,right: 20,bottom: 20),
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
                          Size(300, 50),
                        ),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      onPressed: (){

                      },
                      child: const Text("Şifremi Sıfırla",style: TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                      ),),
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
