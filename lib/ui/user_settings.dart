import 'package:flutter/material.dart';
import 'package:senior_project/ui/user_info_update.dart';
import 'package:senior_project/ui/user_password_update.dart';

class UserSettingsScreen extends StatelessWidget {
  const UserSettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context);
    final double width = screenSize.size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text("Kullanıcı Ayarları"),
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [
            buildCategoryTile(context, "Kullanıcı Bilgilerim", Icons.person_2, width,UserInfoUpdate()),
            //buildCategoryTile(context, "Adres Bilgilerim", Icons.home, width,UserInfoUpdate()),
            buildCategoryTile(context, "E-Posta değişikliği",Icons.mail, width,UserInfoUpdate()),
            buildCategoryTile(context, "Şifre değişikliği",Icons.password, width,UserPasswordUpdate()),
          ],
        ),
      ),
    );
  }

  Widget buildCategoryTile(BuildContext context, String title, IconData icon, double width, Widget destinationScreen) {
    return Padding(
      padding: const EdgeInsets.only(top: 5),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => destinationScreen),
          );
        },
        child: Container(
          color: Colors.white,
          width: width,
          child: ListTile(
            leading: Icon(icon),
            title: Row(
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: Colors.grey.shade600,
                  ),
                ),
                Spacer(),
                Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.grey.shade600,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}