import 'package:flutter/material.dart';
import 'package:senior_project/service/auth.dart';

class UserPasswordUpdate extends StatefulWidget {



  UserPasswordUpdate({super.key});

  @override
  State<UserPasswordUpdate> createState() => _UserPasswordUpdateState();
}

class _UserPasswordUpdateState extends State<UserPasswordUpdate> {
  TextEditingController mevcutSifre = TextEditingController();

  TextEditingController yeniSifre = TextEditingController();

  TextEditingController tekrarYeniSifre = TextEditingController();

  var obscureTextMevcut = true;

  var  obscureTextYeni = true;

  var  obscureTextTekrarYeni = true;

  void dispose(){
    mevcutSifre.dispose();
    yeniSifre.dispose();
    tekrarYeniSifre.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Şifre Değişikliği"),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 30,left: 20,right: 20),
        child: Column(
          children: [
            TextField(
              controller: mevcutSifre,
              obscureText: obscureTextMevcut,
              decoration: InputDecoration(
                  suffixIcon: GestureDetector(
                      child: obscureTextMevcut ? Icon(Icons.visibility_off) : Icon(Icons.visibility),
                    onTap: () {
                      setState(() {
                        obscureTextMevcut = !obscureTextMevcut;
                      });
                    }

                  ),
                  fillColor: Colors.transparent,
                  filled: true,
                  hintText: "Mevcut Şifre",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  )
              ),
            ),
            const SizedBox(height: 15,),
            TextField(
              controller: yeniSifre,
              obscureText: obscureTextYeni,
              decoration: InputDecoration(
                  suffixIcon: GestureDetector(
                      child: obscureTextYeni ? Icon(Icons.visibility_off) : Icon(Icons.visibility),
                    onTap: (){
                        setState(() {
                          obscureTextYeni = !obscureTextYeni;
                        });
                    },
                  ),

                  fillColor: Colors.transparent,
                  filled: true,
                  hintText: "Yeni Şifre",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  )
              ),
            ),
            const SizedBox(height: 15,),
            TextField(
              controller: tekrarYeniSifre,
              obscureText: obscureTextTekrarYeni,
              decoration: InputDecoration(
                  suffixIcon: GestureDetector(
                      child: obscureTextTekrarYeni ? Icon(Icons.visibility_off) : Icon(Icons.visibility),
                  onTap: (){
                        setState(() {
                          obscureTextTekrarYeni = !obscureTextTekrarYeni;
                        });
                  },
                  ),
                  fillColor: Colors.transparent,
                  filled: true,
                  hintText: "Tekrar Yeni Şifre",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  )
              ),
            ),
            const SizedBox(height: 15,),
            Card(
              color: Colors.pink.shade50,
              child: ListTile(
                title: Text("Şifreniz en az 7 karakter ve en fazla 64 krakter olmalı, harf ve rakam içermelidir"),
              ),
            ),

            const SizedBox(height: 20,),
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
                onPressed: () async {
                  String currentPassword = mevcutSifre.text;
                String newPassword = yeniSifre.text;

                  // Call the method to update the password
                  bool passwordUpdateResult = await AuthService().updatePassword(currentPassword, newPassword);

                  if (passwordUpdateResult) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Şifre güncellendi'),
                        duration: Duration(seconds: 2),
                      ),
                    );
                    // Clear the text controllers
                    mevcutSifre.clear();
                    yeniSifre.clear();
                    tekrarYeniSifre.clear();
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Mevcut şifre doğru değil veya şifre güncelleme hatası'),
                        duration: Duration(seconds: 2),
                      ),
                    );
                  }
                },
                child: Text("Güncelle")
            ),


          ],
        ),
      ),

    );
  }
}
