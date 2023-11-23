import 'package:flutter/material.dart';

class WomenCategories extends StatelessWidget {
  const WomenCategories({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context);
    final double width = screenSize.size.width;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            buildCategoryTile(context, "Tüm Ürünler", Icons.apps_outlined, width),
            buildCategoryTile(context, "Giyim", Icons.checkroom_outlined, width),
            buildCategoryTile(context, "Çanta", Icons.shopping_bag_rounded, width),
            buildCategoryTile(context, "Aksesuar", Icons.diamond_outlined, width),
            buildCategoryTile(context, "Ayakkabı", Icons.directions_run, width),
            buildCategoryTile(context, "Kozmetik", Icons.scatter_plot, width),
            buildCategoryTile(context, "Diğer", Icons.apps_outlined, width),
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
