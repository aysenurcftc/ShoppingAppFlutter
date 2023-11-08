
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:senior_project/service/auth.dart';
import 'package:senior_project/ui/login/login-screen.dart';

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

  var obscureText = true;

  AuthService authservice = AuthService();


  Future<void> registerWithEmailAndPassword() async {

    if (userNameController.text.isEmpty ||
        emailController.text.isEmpty ||
        passwordController.text.isEmpty ||
        nameController.text.isEmpty ||
        surnameController.text.isEmpty ||
        phoneController.text.isEmpty ) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            title: Row(
              children: [
                Icon(Icons.cancel, color: Colors.red),
                Text("Please fill in all fields",
                  style: TextStyle(
                      fontSize: 15
                  ),),
              ],
            ),
          );
        },
      );
      return;
    }

    try {
      authservice.signUp(
        context,
        name: nameController.text,
        surname: surnameController.text,
        userName: userNameController.text,
        phoneNumber: phoneController.text,
        email: emailController.text,
        password: passwordController.text,
      );



    } on FirebaseAuthException catch(e){
      showDialog(context: context, builder: (context){
        return AlertDialog(
          content: Text(e.message.toString()),
        );
      });
    }
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
                      padding: EdgeInsets.only(top: 60,bottom: 10),
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
                            top: MediaQuery.of(context).size.height * 0.05,
                            right: 20,
                            left: 20,
                        ),
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
                                SizedBox(width: 10),
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
                              controller: phoneController,
                              decoration: InputDecoration(
                                  suffixIcon: Icon(Icons.phone),
                                  fillColor: Colors.transparent,
                                  filled: true,
                                  hintText: "Telefon",
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
                    ),
                    const SizedBox(height: 20,),
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
                                registerWithEmailAndPassword();
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
