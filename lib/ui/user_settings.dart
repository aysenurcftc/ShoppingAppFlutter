import 'package:flutter/material.dart';

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
            buildCategoryTile(context, "Profil Ayarları", Icons.settings, width),
            buildCategoryTile(context, "Şifremi Değiştir", Icons.settings, width),
            buildCategoryTile(context, "Kayıtlı Bilgilerim", Icons.settings, width),
            buildCategoryTile(context, "Bildirim Ayarları",Icons.settings, width),
          ],
        ),
      ),
    );
  }

  Widget buildCategoryTile(BuildContext context, String title, IconData icon, double width) {
    return Padding(
      padding: const EdgeInsets.only(top: 5),
      child: GestureDetector(
        onTap: () {
          Navigator.pop(context, title);
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