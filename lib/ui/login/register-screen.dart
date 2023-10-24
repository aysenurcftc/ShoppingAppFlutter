
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:senior_project/ui/login/login-screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {

  var userNameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var passwordAgainController = TextEditingController();



  var obscureText = true;



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
                    const Padding(
                      padding: EdgeInsets.only(top: 74,bottom: 20),
                      child: Text("Üye Ol",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 35,
                        ),
                      ),
                    ),

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
                              controller: userNameController,
                              decoration: InputDecoration(
                                  suffixIcon: Icon(Icons.person),
                                  fillColor: Colors.transparent,
                                  filled: true,
                                  hintText: "Kullanıcı Adı",
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),

                                  )
                              ),
                            ),
                            const SizedBox(height: 20,),
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
                            const SizedBox(height: 20,),
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
                            const SizedBox(height: 20,),
                            TextField(
                              controller: passwordAgainController,
                              obscureText: obscureText,
                              decoration: InputDecoration(
                                  suffixIcon:  GestureDetector(
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
                    const SizedBox(height: 20,),
                    Center(
                      child: Column(
                        children: [
                          ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all<Color>(Colors.pinkAccent.shade100),
                                fixedSize: MaterialStateProperty.all<Size>(
                                  const Size(200, 50),
                                ),
                                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                              onPressed: (){

                              },
                              child: Text("Üye Ol")
                          ),
                          SizedBox(height: 20,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text("Zaten Hesabın Var Mı?",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.black,
                                    ),),
                                  GestureDetector(
                                    onTap: (){
                                      Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));
                                    },
                                    child: const Text("Giriş",
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
