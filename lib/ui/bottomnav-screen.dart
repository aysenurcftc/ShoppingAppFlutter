
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:senior_project/ui/add-product-screen.dart';
import 'package:senior_project/ui/categories/categories_secreen.dart';
import 'package:senior_project/ui/home-screen.dart';
import 'package:senior_project/ui/notification_screen.dart';
import 'package:senior_project/ui/profile-screen.dart';
import 'package:senior_project/ui/shopping_basket_screen.dart';

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
      ProfileScreen(uid:FirebaseAuth.instance.currentUser!.uid ,),
      //ProfileGeneral(uid:,),
  ];

  final TextEditingController searchEditingController = TextEditingController();
  bool isShowUsers = false;

  @override
  void dispose() {
    super.dispose();
    searchEditingController.dispose();
  }


  @override
  Widget build(BuildContext context) {

    var screenSize = MediaQuery.of(context);
    final double height = screenSize.size.height;
    final double width = screenSize.size.width;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.grey.shade50,
        title: Row(
          children: [
            SizedBox(
              height: height / 20,
              width: width / 2 + 65,
              child: TextField(
                controller: searchEditingController,
                style: TextStyle(fontSize: 13.0),
                decoration: InputDecoration(
                  hintText: 'Ürün Arama',
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
                onSubmitted: (_) {
                  setState(() {
                    isShowUsers = true;
                  });
                },
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
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ShoppingBasketScreen()),
                );
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
      body: isShowUsers ? FutureBuilder(
        future: FirebaseFirestore.instance.collection("products")
            //.where("title", isEqualTo: searchEditingController.text)
            .where("title", isEqualTo: searchEditingController.text)
            .get(),
        builder: (context, snapshot){
          if(!snapshot.hasData){
            return const Center (
              child: CircularProgressIndicator(),
            );
          }
          return  GridView.builder(
            shrinkWrap: true,
            physics: BouncingScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 15,
              mainAxisSpacing: 15,
              mainAxisExtent: 290.0,
            ),
            itemCount: (snapshot.data! as dynamic).docs.length,
            itemBuilder: (context, index) {
              DocumentSnapshot snap = (snapshot.data! as dynamic).docs[index];
              return Padding(
                padding: EdgeInsets.only(left: 5),
                child: Container(
                  width: 140,
                  height: 200,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        spreadRadius: 3,
                        blurRadius: 5,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Stack(
                        children: [
                          Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.network(
                                  (snapshot.data! as dynamic).docs[index]['image'],
                                  width: double.infinity,
                                  height: 200,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8, left: 6),
                        child: Text(
                          (snapshot.data! as dynamic).docs[index]['title'],
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 15),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10, bottom: 5, left: 6),
                        child: Text(
                          "${(snapshot.data! as dynamic).docs[index]['price']} ₺",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ) : IndexedStack(
        index: currentIndex,
        children: pages,
      ),
      bottomNavigationBar: BottomNavigationBarWidget(
        currentIndex: currentIndex,
        onTap: (int index){
          setState(() {
            currentIndex = index;
            isShowUsers = false;
          });
        },
      ),
    );
  }
}
