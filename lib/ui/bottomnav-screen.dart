
import 'package:flutter/material.dart';
import 'package:senior_project/ui/add-product-screen.dart';
import 'package:senior_project/ui/categories_secreen.dart';
import 'package:senior_project/ui/home-screen.dart';
import 'package:senior_project/ui/notification_screen.dart';
import 'package:senior_project/ui/profile-screen.dart';

import '../widgets/bottomnavbar.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  int currentIndex = 0;

  final List<Widget> pages = [
      HomeScreen(),
      CategoriesScreen(),
      AddProductScreen(),
      NotificationScreen(),
      ProfileScreen(),
  ];

  TextEditingController _searchController = TextEditingController();

  void _startSearch() {
    String query = _searchController.text;
  }

  @override
  Widget build(BuildContext context) {

    var screenSize = MediaQuery.of(context);
    final double height = screenSize.size.height;
    final double width = screenSize.size.width;


    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey.shade50,
        title: Row(
          children: [
            SizedBox(
              height: height / 20,
              width: width / 2 + 50,
              child: TextField(
                controller: _searchController,
                style: TextStyle(fontSize: 13.0),
                decoration: InputDecoration(
                  hintText: 'Arama',
                  contentPadding: EdgeInsets.only(top: 5, bottom: 5),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(color: Colors.grey.shade400),
                  ),
                  prefixIcon: Icon(
                    Icons.search,
                    size: 25.0,
                    color: Colors.grey.shade600,
                  ),
                ),
                onSubmitted: (_) => _startSearch(),
              ),
            ),

            IconButton(
              onPressed: () {

              },
              icon: Icon(
                Icons.favorite_border_rounded,
                size: 25.0,
                color: Colors.grey.shade600,
              ),
            ),
            IconButton(
              onPressed: () {

              },
              icon: Icon(
                Icons.shopping_bag_outlined,
                size: 25.0,
                color: Colors.grey.shade600,
              ),
            ),
          ],
        ),

      ),
      body:IndexedStack(
        index: currentIndex,
        children: pages,
      ),
      bottomNavigationBar: BottomNavigationBarWidget(
        currentIndex: currentIndex,
        onTap: (int index){
          setState(() {
            currentIndex = index;
          });
        },
      ),
    );
  }
}
