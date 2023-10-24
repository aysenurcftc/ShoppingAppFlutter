import 'package:flutter/material.dart';
import 'package:senior_project/ui/categories/child-categories.dart';
import 'package:senior_project/ui/categories/man_categories.dart';
import 'package:senior_project/ui/categories/women_categories.dart';


class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.grey.shade50,
          bottom: const TabBar(
            indicatorColor: Colors.pinkAccent,
            labelColor: Colors.pinkAccent,
            tabs: [
              Tab(text: "Kadın",),
              Tab(text: "Erkek",),
              Tab(text: "Çocuk",),
            ],
          ),
          ),
        ),
      body:  const TabBarView(
    children: [
        WomenCategories(),
        ManCategories(),
        ChildCategories(),
      ],
      ),
        ),
    );
  }
}
