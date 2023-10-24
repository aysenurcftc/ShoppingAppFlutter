

import 'package:flutter/material.dart';
import 'package:senior_project/ui/bottomnav-screen.dart';
import 'package:senior_project/ui/login/forgotpass-screen.dart';
import 'package:senior_project/ui/login/register-screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  var emailController = TextEditingController();
  var passwordController = TextEditingController();


  var obscureText = true;


  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
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
                    const SizedBox(height: 100,),
                    const Padding(
                      padding: EdgeInsets.only(bottom: 20),
                      child: Text("Giriş Yap",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 30,
                        ),
                      ),
                    ),
                    const Icon(Icons.lock_outline_rounded,
                      size: 50,),

                    Container(
                      child: Padding(
                        padding: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height * 0.1,
                            right: 35,
                            left: 35
                        ),
                        child: Column(
                          children: [
                            TextField(
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
                            const SizedBox(height: 30,),
                            TextField(
                              controller: passwordController,
                              obscureText: obscureText,
                              decoration: InputDecoration(
                                  suffixIcon: GestureDetector(
                                    child: obscureText ? Icon(Icons.key_off) : Icon(Icons.key),
                                    onTap: (){
                                      setState(() {
                                        obscureText = !obscureText;
                                      });
                                    },
                                  ),
                                  fillColor: Colors.transparent,
                                  filled: true,
                                  hintText: "Şifre",
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  )
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 60,),
                    Center(
                      child: Column(
                        children: [
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
                              child: Text("Giriş Yap")
                          ),
                          SizedBox(height: 20,),

                          GestureDetector(
                            onTap: (){
                              Navigator.push(context,MaterialPageRoute(builder: (context) => Home()));
                            },
                            child: const Text("Üye Olmadan Devam Et",
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.black,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),

                          SizedBox(height: 20,),

                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text("Üye Değil Misin? ",
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: Colors.black,
                                    ),),
                                  GestureDetector(
                                    onTap: (){
                                      Navigator.push(context,MaterialPageRoute(builder: (context) => RegisterScreen()));
                                    },
                                    child: const Text("Üye Ol",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                        color: Colors.black,
                                        decoration: TextDecoration.underline,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 20,),

                              GestureDetector(
                                onTap: (){
                                  Navigator.push(context,MaterialPageRoute(builder: (context) => ForgotPassScreen()));
                                },
                                child: const Text("Şifremi Unuttum?",style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.black,
                                  decoration: TextDecoration.underline,
                                ),
                                ),
                              ),




                            ],
                          ),
                        ],
                      ),
                    )
                  ]
              ),
            ),
          ),
        ),
      ),
    );
  }
}
