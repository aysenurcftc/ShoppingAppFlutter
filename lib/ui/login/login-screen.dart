

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:senior_project/service/auth.dart';
import 'package:senior_project/ui/bottomnav-screen.dart';
import 'package:senior_project/ui/login/email_verification_screen.dart';
import 'package:senior_project/ui/login/forgotpass-screen.dart';
import 'package:senior_project/ui/login/register-screen.dart';
import 'package:senior_project/utils/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  bool _isLoading = false;

  bool rememberMe = false;



  var obscureText = true;

  @override
  void initState() {
    super.initState();
    retrieveRememberMeState();
  }

  AuthService authservice = AuthService();

  Future<void> signInWithGoogle() async {
    try {
      await authservice.signInWithGoogle();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Home()),
      );
    } catch (e) {
      print(e);

    }
  }

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();

  }


  void loginUser() async {
    setState(() {
      _isLoading = true;
    });

    String res = await AuthService().loginUser(
      email: emailController.text,
      password: passwordController.text,
    );

    if (res == 'success') {
      // Beni Hatırla seçeneğini sakla
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setBool('rememberMe', rememberMe);

      if (rememberMe) {
        // Eğer hatırla seçeneği işaretliyse, e-posta ve şifreyi kaydet
        prefs.setString('email', emailController.text);
        prefs.setString('password', passwordController.text);
      } else {
        // Eğer hatırla seçeneği işaretli değilse önceki bilgileri temizle
        prefs.remove('email');
        prefs.remove('password');
      }

      Navigator.of(context as BuildContext).pushReplacement(
        MaterialPageRoute(builder: (context) => Home()),
      );
    } else {
      showSnackBar(context as BuildContext, res);
    }

    setState(() {
      _isLoading = false;
    });
  }

  void retrieveRememberMeState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      rememberMe = prefs.getBool('rememberMe') ?? false;
      if (rememberMe) {
        emailController.text = prefs.getString('email') ?? '';
        passwordController.text = prefs.getString('password') ?? '';
      }
    });
  }
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
                            right: 20,
                            left: 20
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
                    const SizedBox(height: 12,),


                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          children: [
                            Checkbox(value: rememberMe, onChanged: (value) {
                              setState(() {
                                rememberMe = value ?? false;
                              });
                            }),
                            Text("Beni Hatırla"),
                          ],
                        ),
                        TextButton(onPressed: (){
                          Navigator.push(context,MaterialPageRoute(builder: (context) => ForgotPassScreen()));
                        }, child: Text("Şifremi unuttum",style: TextStyle(
                          fontSize: 13,
                          color: Colors.black,
                          decoration: TextDecoration.underline,
                        ),
                        ),
                        ),
                      ],
                    ),


                    Center(
                      child: Column(
                        children: [
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
                                loginUser();
                              },
                              child: _isLoading ? Center(child: CircularProgressIndicator(color: Colors.black,),) : const Text("Giriş Yap",
                              style: TextStyle(
                                color: Colors.black,
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

                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(color: Colors.grey), borderRadius: BorderRadius.circular(100)
                                      ),
                                      child: IconButton(
                                        onPressed: (){
                                          signInWithGoogle();
                                        },
                                        icon: Image(
                                          width: 30,
                                          height: 30,
                                          image: AssetImage("img/logos/google-icon.png"),
                                        ),
                                      ),
                                    )
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
