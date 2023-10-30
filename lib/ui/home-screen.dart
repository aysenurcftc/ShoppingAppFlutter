import 'package:flutter/material.dart';
import 'package:senior_project/models/product.dart';
import 'package:senior_project/ui/product_detail.dart';

class HomeScreen extends StatelessWidget {

  TextEditingController _searchController = TextEditingController();

  void _startSearch() {
    String query = _searchController.text;
  }

  final List<Product> newProducts = [
    Product(imagePath: "img/zara_dress.jpg", productTitle: "Zara Elbise",productPrice: 100),
    Product(imagePath: "img/zara_dress_2.jpg", productTitle: "Zara Elbise",productPrice: 100),
    Product(imagePath: "img/zara_bluz.jpg", productTitle: "Zara Bluz",productPrice: 100),
    Product(imagePath: "img/zara_bluz_2.jpg", productTitle: "Zara Bluz",productPrice: 100),
    Product(imagePath: "img/zara_dress.jpg", productTitle: "Zara Elbise",productPrice: 100),
    Product(imagePath: "img/zara_dress_2.jpg", productTitle: "Zara Elbise",productPrice: 100),
    Product(imagePath: "img/zara_bluz.jpg", productTitle: "Zara Bluz",productPrice: 100),
    Product(imagePath: "img/zara_bluz_2.jpg", productTitle: "Zara Bluz",productPrice: 100),
  ];



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
                          Text("Hemen Başla",
                            style: TextStyle(
                              color: Colors.grey.shade600,
                              fontSize: 15,
                              decoration: TextDecoration.underline,
                            ),),
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
                            child: Image.asset("img/home-like.jpg",
                              width: 150,),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
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
                            child: Image.asset("img/home-2.jpg",
                              width: 150,),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 15),
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
                            child: Image.asset("img/home-taki.jpg",
                              width: 150,),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: Text("En Beğenilen Aksesuarlar",
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
                              width: 150,),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 15),
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
                            child: Image.asset("img/home-mu.jpg",
                              width: 150,),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: Text("En Sevilen Cilt Bakım Ürünleri",
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
                children: newProducts.map((product) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: 150,
                      height: 300,
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
                        onTap: (){
                          Navigator.push(context,MaterialPageRoute(builder: (context) => ProductDetailScreen(product.imagePath,product.productTitle,product.productPrice)));
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.asset(product.imagePath, width: 150),
                                ),
                                Positioned(
                                  top: 10,
                                  right: 10,
                                  child: GestureDetector(
                                    onTap: () {
                                      // Kalp simgesine tıklama işlemi
                                    },
                                    child: Icon(
                                      Icons.favorite_border,
                                      color: Colors.grey.shade600,
                                      size: 20,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 8, left: 6),
                              child: Text(
                                product.productTitle,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 15
                                ),
                              ),
                            ),

                            Padding(
                              padding: const EdgeInsets.only(top: 10,bottom: 5,left: 6),
                              child: Text(
                                product.productPrice.toString() + "₺",
                                textAlign: TextAlign.center,
                                style: TextStyle(
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
              ),
            ),




          ],
        ),
      ),
    );
  }
}
