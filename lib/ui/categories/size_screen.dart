import 'package:flutter/material.dart';

class SizeScreen extends StatelessWidget {
  const SizeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context);
    final double width = screenSize.size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text("Bedeni"),
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [
            buildCategoryTile(context, "32", Icons.checkroom_outlined, width),
            buildCategoryTile(context, "34", Icons.shopping_bag_rounded, width),
            buildCategoryTile(context, "36", Icons.shopping_bag_rounded, width),
            buildCategoryTile(context, "38", Icons.shopping_bag_rounded, width),
            buildCategoryTile(context, "40", Icons.shopping_bag_rounded, width),
            buildCategoryTile(context, "42", Icons.shopping_bag_rounded, width),
            buildCategoryTile(context, "44", Icons.shopping_bag_rounded, width),
            buildCategoryTile(context, "46", Icons.shopping_bag_rounded, width),
            buildCategoryTile(context, "48", Icons.shopping_bag_rounded, width),
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