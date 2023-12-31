import 'package:flutter/material.dart';

class ChildCategories extends StatelessWidget {
  const ChildCategories({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context);
    final double width = screenSize.size.width;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            buildCategoryTile(context, "Tüm Ürünler", Icons.apps_outlined, width),
            buildCategoryTile(context, "Kız Çocuk", Icons.checkroom_outlined, width),
            buildCategoryTile(context, "Erkek Çocuk", Icons.shopping_bag_rounded, width),
            buildCategoryTile(context, "Oyuncak", Icons.diamond_outlined, width),
            buildCategoryTile(context, "Bebek", Icons.directions_run, width),
            buildCategoryTile(context, "Diğer", Icons.scatter_plot, width),
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
