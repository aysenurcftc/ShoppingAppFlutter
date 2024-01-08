
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:senior_project/providers/user_provider.dart';


class UserInfoUpdate extends StatefulWidget {

  @override
  State<UserInfoUpdate> createState() => _UserInfoUpdateState();
}

class _UserInfoUpdateState extends State<UserInfoUpdate> {
  FirebaseAuth auth = FirebaseAuth.instance;
  bool isDataChanged = false;


  @override
  void initState() {
    // TODO: implement initState
    getUserInfoFromFirebase();
  }

  TextEditingController nameController = TextEditingController();

  TextEditingController surnameController = TextEditingController();

  TextEditingController usernameController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  void dispose(){
    nameController.dispose();
    surnameController.dispose();
    usernameController.dispose();
    emailController.dispose();
    super.dispose();
  }

  void getUserInfoFromFirebase() async {
    User? user = auth.currentUser;

    if (user != null) {
      DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
          .collection("users")
          .doc(user.uid)
          .get();

      Map<String, dynamic>? userData = userSnapshot.data() as Map<String, dynamic>?;

      if (userData != null) {
        setState(() {
          nameController.text = userData['name'] ?? '';
          surnameController.text = userData['surname'] ?? '';
          usernameController.text = userData['userName'] ?? '';
          emailController.text = userData['email'] ?? '';
        });
      }
    }
  }

  Future<void > updateUserInfoInFirebase() async {
    User? user = auth.currentUser;

    if (user != null) {
      try {
        await FirebaseFirestore.instance.collection("users").doc(user.uid).update({
          'name': nameController.text,
          'surname': surnameController.text,
          'userName': usernameController.text,
          // 'email' alanını güncellemiyoruz, çünkü bu alan değiştirilemez (enabled: false)
        });
        Provider.of<UserProvider>(context, listen: false).updateUser(usernameController.text);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Kullanıcı bilgileri güncellendi.'),
          ),
        );
      } catch (error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Hata: $error'),
          ),
        );
      }
    }
  }


  void onDataChanged() {
    setState(() {
      isDataChanged = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Kullanıcı Bilgilerim"),
        leading: GestureDetector(
          onTap: (){
            Navigator.pop(context);
          },
            child: Icon(Icons.arrow_back)),
        actions: [
          Icon(Icons.more_vert),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 30,left: 20,right: 20),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: nameController,
                    onChanged: (value){
                      onDataChanged();
                    },
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
                    onChanged: (value){
                      onDataChanged();
                    },
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
              controller: usernameController,
              onChanged: (value){
                onDataChanged();
              },
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
              enabled: false,
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
                onPressed: isDataChanged ? () => updateUserInfoInFirebase() : null,
                child: Text("Güncelle")
            ),
          ],
        ),
      ),
    );
  }
}

