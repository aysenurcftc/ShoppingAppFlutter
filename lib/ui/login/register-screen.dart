
import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:senior_project/service/auth.dart';
import 'package:senior_project/ui/login/email_verification_screen.dart';
import 'package:senior_project/ui/login/login-screen.dart';
import 'package:senior_project/utils/utils.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {

  var nameController = TextEditingController();
  var surnameController = TextEditingController();
  var userNameController = TextEditingController();
  var phoneController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  Uint8List? _image;

  bool _isLoading = false;

  var obscureText = true;

  AuthService authservice = AuthService();

  final verified = EmailVerificationScreen();


  selectImage() async {
    Uint8List im = await pickImage(ImageSource.gallery);
    // set state because we need to display the image we selected on the circle avatar
    setState(() {
      _image = im;
    });
  }


  @override
  void dispose() {
    super.dispose();
    userNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    phoneController.dispose();
    nameController.dispose();
    surnameController.dispose();
  }

  void signUpUser() async {
    setState(() {
      _isLoading = true;
    });

    // signup user using our authmethodds
    String res = await AuthService().signupUser(
      name: nameController.text,
        email: emailController.text,
        password: passwordController.text,
        username: userNameController.text,
        surname: surnameController.text,
        file: _image!);

    // if string returned is sucess, user has been created
    if (res == "success") {
      setState(() {
        _isLoading = false;
      });


      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => EmailVerificationScreen(),
      ));
      // navigate to the home screen

      setState(() {
        _isLoading = false;
      });
      // show the error
      if (context.mounted) {
        showSnackBar(context, res);
      }
      clearTextFields();
    }
  }

  void clearTextFields() {
    nameController.clear();
    surnameController.clear();
    userNameController.clear();
    emailController.clear();
    passwordController.clear();
    phoneController.clear();
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
        body: Container(
          child: Center(
            child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 60,bottom: 10),
                    child: Text("Üye Ol",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 25,
                      ),
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.only(
                        top: 20,
                        right: 20,
                        left: 20,
                      bottom: 30
                    ),
                    child: Column(
                      children: [
                    Stack(
                      children: [
                        _image != null
                            ? CircleAvatar(
                          radius: 64,
                          backgroundImage: MemoryImage(_image!),
                          backgroundColor: Colors.red,
                        )
                            : const CircleAvatar(
                          radius: 64,
                          backgroundImage: NetworkImage(
                              'https://i.stack.imgur.com/l60Hf.png'),
                          backgroundColor: Colors.red,
                        ),
                        Positioned(
                          bottom: -10,
                          left: 80,
                          child: IconButton(
                            onPressed: selectImage,
                            icon: const Icon(Icons.add_a_photo),
                          ),
                        ),
                           ]
                        ),
                           ]
                      ),
                  ),

                        SizedBox(width: 20),

                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: TextField(
                                      controller: nameController,
                                      decoration: InputDecoration(
                                          suffixIcon: Icon(Icons.person_outline),
                                          fillColor: Colors.transparent,
                                          filled: true,
                                          hintText: "Ad",
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(10),

                                          )
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 20),
                                  Expanded(
                                    child: TextField(
                                      controller: surnameController,
                                      decoration: InputDecoration(
                                          suffixIcon: Icon(Icons.person_outline_outlined),
                                          fillColor: Colors.transparent,
                                          filled: true,
                                          hintText: "Soyad",
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(10),

                                          )
                                      ),
                                    ),
                                  ),

                                ],
                              ),
                              const SizedBox(height: 10,),
                              TextField(
                                controller: userNameController,
                                decoration: InputDecoration(
                                    suffixIcon: Icon(Icons.person_outline),
                                    fillColor: Colors.transparent,
                                    filled: true,
                                    hintText: "Kullanıcı Adı",
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),

                                    )
                                ),
                              ),

                              const SizedBox(height: 10,),
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

                              const SizedBox(height: 10,),
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
                              const SizedBox(height: 10,),
                            ],
                          ),
                        ),




            const SizedBox(height: 20),
                  Center(
                  child: Column(
                    children: [
                      ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(Colors.pinkAccent.shade100),
                            fixedSize: MaterialStateProperty.all<Size>(
                              const Size(300, 50),
                            ),
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                          onPressed: (){
                            signUpUser();
                            //registerWithEmailAndPassword();
                          },
                          child: _isLoading ? Center(child: CircularProgressIndicator(
                            color: Colors.black,
                          ),) :  Text("Üye Ol")
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

                      SizedBox(height: 20,),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey), borderRadius: BorderRadius.circular(100)
                            ),
                            child: IconButton(
                              onPressed: (){
                                authservice.signInWithGoogle();
                              },
                              icon: Image(
                                width: 30,
                                height: 30,
                                image: AssetImage("img/logos/google-icon.png"),
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                                    ),

                                 ]
                              ),
                            ),

                ),
              ),


    );
  }
}
