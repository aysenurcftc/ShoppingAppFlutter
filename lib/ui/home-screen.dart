import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:senior_project/models/products.dart';
import 'package:senior_project/providers/product_provider.dart';
import 'package:senior_project/providers/user_provider.dart';
import 'package:senior_project/service/auth.dart';
import 'package:senior_project/service/product_service.dart';
import 'package:senior_project/ui/add-product-screen.dart';
import 'package:senior_project/ui/create_coupon.dart';
import 'package:senior_project/ui/new_products_screen.dart';
import 'package:senior_project/ui/product_detail.dart';

import '../models/users.dart';
import '../widgets/like_animation.dart';



class HomeScreen extends StatefulWidget {

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController _searchController = TextEditingController();

  void _startSearch() {
    String query = _searchController.text;
  }

  final AuthService authService = AuthService();
  final ProductService firestoreService = ProductService();
  late Future<List<Product>> userProducts;
  late Future<String?> username;




  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Set<int> liked = Set<int>();
  late ProductProvider _productProvider;



  late var userData;
  late UserProvider userProvider;


  @override
  void initState() {
    super.initState();
    userProducts = firestoreService.getAllUsersProducts();
    username = authService.getCurrentUsername();
    getUserData();
    _productProvider = Provider.of<ProductProvider>(context, listen: false);
    _productProvider.fetchProducts();

    userProvider = Provider.of<UserProvider>(context, listen: false);
    userProvider.fetchUser();

  }


  Future<void> getUserData() async {

    userData = await firestoreService.getUserData();
    print(userData.uid);
  }

  bool isLikeAnimating = false;

  Color myColor = Color(0xFFF3E9E0);

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context);
    final double height = screenSize.size.height;
    final double width = screenSize.size.width;

    //final Users user = Provider.of<UserProvider>(context).getUser;


    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  alignment: Alignment.topCenter,
                  height: height / 2 - 50,

                  child: Image.asset("img/home-bg.jpg",
                    width: width,
                  ),
                ),
                Positioned(
                  bottom: 20,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Container(
                      width: width - 40,
                      height: 100,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),

                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 12, bottom: 20),
                            child: Text("Al, Sat, Keşfet",
                              style: TextStyle(
                                color: Colors.grey.shade600,
                                fontSize: 20,
                              ),),
                          ),
                          GestureDetector(
                            onTap: (){
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => AddProductScreen()),
                              );
                            },
                            child: Text("Hemen Başla",
                              style: TextStyle(
                                color: Colors.grey.shade600,
                                fontSize: 15,
                                decoration: TextDecoration.underline,
                              ),),
                          ),
                        ],
                      ),

                    ),
                  ),
                ),
              ],
            ),

            Padding(
              padding: const EdgeInsets.only(right: 10, left: 10),
              child: Row(
                children: [
                  Text("Kampanyalar",
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),),
                  Spacer(),
                  Text("Tümünü gör",
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: 150,
                      height: 160,
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
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.asset("img/home-coupon.jpg",
                              width: 150,
                            height: 130,
                              fit: BoxFit.cover,),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: Text("Kupon Fırsatları",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                              ),),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: 150,
                      height: 160,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            // Gölge rengi ve opaklık
                            spreadRadius: 3,
                            blurRadius: 5,
                            offset: Offset(0, 3), // Gölge offset değeri (x, y)
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.asset("img/home-like.jpg",
                              width: 149,
                            height: 130,
                            fit: BoxFit.cover,),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: Text("En Beğenilenler",
                              textAlign: TextAlign.center,),
                          ),
                        ],
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: 150,
                      height: 160,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            // Gölge rengi ve opaklık
                            spreadRadius: 3,
                            blurRadius: 5,
                            offset: Offset(0, 3), // Gölge offset değeri (x, y)
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.asset("img/home-jell.jpg",
                              width: 150,
                              height: 130,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: Text("Aksesuarlar",
                              textAlign: TextAlign.center,),
                          ),
                        ],
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: 150,
                      height: 160,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            // Gölge rengi ve opaklık
                            spreadRadius: 3,
                            blurRadius: 5,
                            offset: Offset(0, 3), // Gölge offset değeri (x, y)
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.asset("img/home-ceket.jpg",
                              width: 150,
                              height: 130,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: Text("Favori Ceketler"),
                          ),
                        ],
                      ),
                    ),
                  ),


                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: 150,
                      height: 160,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            // Gölge rengi ve opaklık
                            spreadRadius: 3,
                            blurRadius: 5,
                            offset: Offset(0, 3), // Gölge offset değeri (x, y)
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.asset("img/make-up.jpg",
                              width: 150,
                              height: 130,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: Text("Cilt Bakım",
                              textAlign: TextAlign.center,),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(top: 20,bottom: 15),
              child: GestureDetector(
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CreateCouponScreen()),
                  );
                },
                child: Container(
                  width: 340,
                  height: 60,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [Color(0xFFF3E9E0), Colors.white], // İstediğiniz renkleri buraya ekleyebilirsiniz
                      ),
                    borderRadius: BorderRadius.circular(15), // Yarı çapı kadar oval bir container yapar
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 3,
                        blurRadius: 5,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      "Kupon Oluştur",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.grey.shade600,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),


            Padding(
              padding: const EdgeInsets.only(right: 10, left: 10, top: 10),
              child: Row(
                children: [
                  Text("En Yeniler",
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,

                    ),
                  ),
                  Spacer(),
                  GestureDetector(
                    onTap: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => NewProductScreen(userProducts)),
                      );
                    },
                    child: Text("Tümünü gör",
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 15,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: StreamBuilder<List<Product>>(
                stream: firestoreService.streamAllUsersProducts(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    List<Product> products = snapshot.data ?? [];
                    return Row(
                      children: products.map((product) {
                        final int index = products.indexOf(product);
                        final bool isLiked = liked.contains(index);
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width: 150,
                            height: 280,
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
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ProductDetailScreen(
                                      product.image,
                                      product.title,
                                      product.price,
                                      product.description,
                                      product.category,
                                      product.condition,
                                      product.size,
                                      product.uid,
                                      product.likes,
                                    ),
                                  ),
                                );
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Stack(
                                    children: [
                                      Stack(
                                        children: [
                                          GestureDetector(
                                            onDoubleTap: () async {
                                              await ProductService().likePost(
                                                product.uid,
                                                userProvider.getUser.uid,
                                                product.likes,
                                              );
                                              setState(() {
                                                isLikeAnimating = true;
                                              });
                                            },
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.circular(10),
                                              child: product.image != null
                                                  ? Image.network(
                                                product.image,
                                                width: 150,
                                                height: 190,
                                                fit: BoxFit.cover,
                                              )
                                                  : Placeholder(), // Add a placeholder or handle null image case
                                            ),
                                          ),
                                          AnimatedOpacity(
                                            duration: const Duration(milliseconds: 100),
                                            opacity: isLikeAnimating ? 1 : 0,
                                            child: LikeAnimation(
                                              child: Padding(
                                                padding: const EdgeInsets.only(top: 85),
                                                child: Center(
                                                  child: Icon(
                                                    Icons.favorite,
                                                    color: Colors.white,
                                                    size: 40,
                                                  ),
                                                ),
                                              ),
                                              isAnimating: isLikeAnimating,
                                              duration: const Duration(milliseconds: 100),
                                              onEnd: () {
                                                setState(() {
                                                  isLikeAnimating = true;
                                                });
                                              },
                                              smallLike: true,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Positioned(
                                        top: 10,
                                        right: 10,
                                        child: Container(
                                          width: 40,
                                          height: 40,
                                          decoration: const BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.white,
                                          ),
                                          padding: EdgeInsets.all(1),
                                          child: LikeAnimation(
                                            isAnimating: product.likes
                                                .contains(userProvider.getUser.uid),
                                            smallLike: false,
                                            child: IconButton(
                                              icon: product.likes.contains(userProvider.getUser.uid)
                                                  ? const Icon(Icons.favorite, color: Colors.red)
                                                  : const Icon(Icons.favorite_border),
                                              color: Colors.pink.shade400,
                                              iconSize: 20,
                                              onPressed: () async {
                                                await ProductService().likePost(
                                                  product.uid,
                                                  userProvider.getUser.uid,
                                                  product.likes,
                                                );

                                                setState(() {
                                                  isLikeAnimating = false;
                                                });
                                              },
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      top: 8,
                                      left: 6,
                                    ),
                                    child: Text(
                                      product.title ?? '',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(fontSize: 15),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      top: 10,
                                      bottom: 5,
                                      left: 6,
                                    ),
                                    child: Text(
                                      product.price ?? '' + "₺",
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    );
                  }
                },
              )
            ),
          ],
        ),
      ),
    );
  }
}
