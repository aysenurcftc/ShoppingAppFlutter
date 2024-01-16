import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:senior_project/providers/user_provider.dart';
import 'package:senior_project/service/auth.dart';
import 'package:senior_project/ui/myWallet.dart';
import 'package:senior_project/ui/my_coupon.dart';
import 'package:senior_project/ui/my_orders.dart';
import 'package:senior_project/ui/profile-detail-screen.dart';
import 'package:senior_project/ui/user_settings.dart';


class ProfileScreen extends StatefulWidget {

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  TextEditingController _searchController = TextEditingController();


  void _startSearch() {
    String query = _searchController.text;
  }

  AuthService authService = AuthService();
  late Future<String?> username;
  late Future<String?> uid;
  late UserProvider userProvider;

  @override
  void initState() {
    super.initState();
    username = authService.getCurrentUsername();
    userProvider = Provider.of<UserProvider>(context, listen: false);
    userProvider.fetchUser();

  }


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
              height: 150,
              width: width,
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20,top: 8,bottom: 5),
                        child: Consumer<UserProvider>(
                          builder: (context, value, widget) {
                            return Container(
                              width: 100,
                              height: 100,
                              child: CircleAvatar(
                                backgroundImage: NetworkImage(
                                  value.getUser?.photoUrl ?? "https://i.pinimg.com/736x/8b/25/91/8b259121597545e2739974384c18a8e6.jpg",
                                ),
                              ),
                            );
                          },
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.only(left: 50, top: 8),
                        child: Consumer<UserProvider>(
                          builder: (BuildContext context, UserProvider value, Widget? child) {
                            return Text(
                              value.getUser?.name ?? "Kullanıcı",
                              style: TextStyle(
                                color: Colors.grey.shade600,
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),

                  Spacer(),
                  GestureDetector(
                    onTap: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ProfileDetailScreen()),
                      );
                    },
                    child: Text("Sayfama git",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline,
                      color: Colors.grey.shade600,
                    ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left:10,right: 10),
                    child: Icon(Icons.arrow_forward_ios,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            ),

            Flexible(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: GestureDetector(
                        onTap: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => ProfileDetailScreen()),
                          );
                        },
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
                    ),
              
                    GestureDetector(
                      onTap: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) =>  MyOrdersScreen()),
                        );
                      },
                      child: Container(
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
                    ),
              
                    GestureDetector(
                      onTap: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) =>  myCouponScreen()),
                        );
                      },
                      child: Container(
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
              
                    GestureDetector(
                      onTap: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => myWalletScreen()),
                        );
                      },
                      child: Container(
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
                    ),
              
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: GestureDetector(
                        onTap: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => UserSettingsScreen()),
                          );
                        },
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
                    ),
              
                    Container(
                      color: Colors.white,
                      width: width,
                      child: GestureDetector(
                        onTap: (){
                          authService.signOut(context);
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
                ),
              ),
            )
          ],
        )
    );
  }
}
