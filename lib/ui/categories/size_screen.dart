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
            buildCategoryTile(context, "32", Icons.add, width),
            buildCategoryTile(context, "34", Icons.add, width),
            buildCategoryTile(context, "36", Icons.add, width),
            buildCategoryTile(context, "38", Icons.add, width),
            buildCategoryTile(context, "40", Icons.add, width),
            buildCategoryTile(context, "42", Icons.add, width),
            buildCategoryTile(context, "44", Icons.add, width),
            buildCategoryTile(context, "46", Icons.add, width),
            buildCategoryTile(context, "48", Icons.add, width),
            buildCategoryTile(context, "Diğer", Icons.add, width),

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