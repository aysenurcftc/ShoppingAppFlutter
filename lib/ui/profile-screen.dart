import 'package:flutter/material.dart';
import 'package:senior_project/service/auth.dart';

class ProfileScreen extends StatelessWidget {

  TextEditingController _searchController = TextEditingController();

  void _startSearch() {
    String query = _searchController.text;
  }

  AuthService authservice = AuthService();


  @override
  Widget build(BuildContext context) {

    var screenSize = MediaQuery.of(context);
    final double height = screenSize.size.height;
    final double width = screenSize.size.width;


    return Scaffold(
        body: Column(
          children: [
            Container(
              color: Colors.white,
              height: 120,
              width: width,
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20,top: 8,bottom: 5),
                        child: Image.asset("img/profile.jpg",
                          width: 80,
                          height: 80,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Text("KullanıcıAdı",
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ],
                  ),

                  Spacer(),
                  Text("Sayfama git",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.underline,
                    color: Colors.grey.shade600,

                  ),),
                  Padding(
                    padding: const EdgeInsets.only(left:10,right: 10),
                    child: Icon(Icons.arrow_forward_ios,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(top: 15),
              child: Container(
                color: Colors.white,
                width: width,
                child: ListTile(
                  leading: Icon(Icons.checkroom_outlined),
                  title: Row(
                    children: [
                      Text("Ürünlerim",
                        style: TextStyle(
                          color: Colors.grey.shade600,
                        ),),
                      Spacer(),
                      Icon(Icons.arrow_forward_ios,
                        color: Colors.grey.shade600,),
                    ],
                  ),
                ),
              ),
            ),

            Container(
              color: Colors.white,
              width: width,
              child: ListTile(
                leading: Icon(Icons.shopping_bag_outlined),
                title: Row(
                  children: [
                    Text("Siparişlerim",
                      style: TextStyle(
                        color: Colors.grey.shade600,
                      ),),
                    Spacer(),
                    Icon(Icons.arrow_forward_ios,
                      color: Colors.grey.shade600,),
                  ],
                ),
              ),
            ),

            Container(
              color: Colors.white,
              width: width,
              child: ListTile(
                leading: Icon(Icons.discount_outlined),
                title: Row(
                  children: [
                    Text("Kuponlarım",
                      style: TextStyle(
                        color: Colors.grey.shade600,
                      ),),
                    Spacer(),
                    Icon(Icons.arrow_forward_ios,
                      color: Colors.grey.shade600,),
                  ],
                ),
              ),
            ),

            Container(
              color: Colors.white,
              width: width,
              child: ListTile(
                leading: Icon(Icons.favorite_border_rounded),
                title: Row(
                  children: [
                    Text("Favorilerim",
                      style: TextStyle(
                        color: Colors.grey.shade600,
                      ),),
                    Spacer(),
                    Icon(Icons.arrow_forward_ios,
                      color: Colors.grey.shade600,),
                  ],
                ),
              ),
            ),

            Container(
              color: Colors.white,
              width: width,
              child: ListTile(
                leading: Icon(Icons.wallet),
                title: Row(
                  children: [
                    Text("Cüzdanım",
                      style: TextStyle(
                        color: Colors.grey.shade600,
                      ),),
                    Spacer(),
                    Icon(Icons.arrow_forward_ios,
                      color: Colors.grey.shade600,),
                  ],
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Container(
                color: Colors.white,
                width: width,
                child: ListTile(
                  leading: Icon(Icons.settings),
                  title: Row(
                    children: [
                      Text("Ayarlar",
                        style: TextStyle(
                          color: Colors.grey.shade600,
                        ),),
                      Spacer(),
                      Icon(Icons.arrow_forward_ios,
                        color: Colors.grey.shade600,),
                    ],
                  ),
                ),
              ),
            ),


            Container(
              color: Colors.white,
              width: width,
              child: GestureDetector(
                onTap: (){
                  authservice.signOut(context);
                },
                child: ListTile(
                  leading: Icon(Icons.arrow_back_outlined),
                  title: Row(
                    children: [
                      Text("Çıkış Yap",
                        style: TextStyle(
                          color: Colors.grey.shade600,
                        ),),
                      Spacer(),
                      Icon(Icons.arrow_forward_ios,
                        color: Colors.grey.shade600,),
                    ],
                  ),
                ),
              ),
            ),


          ],
        )
    );
  }
}
