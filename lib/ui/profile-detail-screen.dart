import 'package:flutter/material.dart';
import 'package:senior_project/ui/profil-general.dart';
import 'package:senior_project/ui/sale-product-screen.dart';


class ProfileDetailScreen extends StatelessWidget {
  const ProfileDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    var screenSize = MediaQuery.of(context);
    final double height = screenSize.size.height;
    final double width = screenSize.size.width;


    return DefaultTabController(
      length: 2,
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
                Tab(text: "Ürünlerim",),
                Tab(text: "Anasayfam",),
              ],
            ),
          ),
        ),
          body: TabBarView(
              children: [
                ProfileGeneral(),
                SaleProductScreen(),
              ],
            ),
        ),
    );
  }
}