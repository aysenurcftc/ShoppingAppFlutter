import 'package:flutter/material.dart';
import 'package:senior_project/models/products.dart';
import 'package:senior_project/service/auth.dart';
import 'package:senior_project/service/product_service.dart';
import 'package:senior_project/ui/add-product-screen.dart';
import 'package:senior_project/ui/new_products_screen.dart';
import 'package:senior_project/ui/product_detail.dart';



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
  final FirestoreService firestoreService = FirestoreService();
  late Future<List<Product>> userProducts;
  late Future<String?> username;
  bool isLiked = false;

  @override
  void initState() {
    super.initState();
    userProducts = firestoreService.getAllUsersProducts();
    username = authService.getCurrentUsername();
  }

  Color myColor = Color(0xFFF3E9E0);

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context);
    final double height = screenSize.size.height;
    final double width = screenSize.size.width;


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
                  // Container'ı resmin üzerinde yukarı doğru kaydırarak görünmesini sağlar
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Container(
                      width: width - 40,
                      height: 100,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        // Card'ın rengini beyaz yapar
                        borderRadius: BorderRadius.circular(12.0),
                        // Köşeleri oval yapar
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
              child: FutureBuilder<List<Product>>(
                future: userProducts ,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    List<Product> products = snapshot.data ?? [];
                    return Row(
                      children: products.map((product) {
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
                                      product.price as double,
                                      product.description,
                                      product.category,
                                      product.condition,
                                      product.size,
                                    ),
                                  ),
                                );
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Stack(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Image.network(
                                          product.image,
                                          width: 150,
                                          height: 200,
                                          fit: BoxFit.cover,
                                        ),
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
                                          child: IconButton(
                                            icon: Icon(
                                              product.isLiked  ? Icons.favorite : Icons.favorite_border,
                                            ),
                                            color: Colors.pink.shade400,
                                            iconSize: 20,
                                            onPressed: () async {
                                              setState(() {
                                                product.isLiked = !product.isLiked;
                                              });
                                              await firestoreService.likeProduct(product.uid, product.isLiked);

                                          },
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
                                      product.title,
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
                                      product.price + "₺",
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}
