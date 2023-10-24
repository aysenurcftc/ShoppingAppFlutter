import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {

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
      body: Column(
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
                          child: Text("ShiningApp'de Al, Sat, Keşfet",
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
                          // Gölge rengi ve opaklık
                          spreadRadius: 3,
                          blurRadius: 5,
                          offset: Offset(0, 3), // Gölge offset değeri (x, y)
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Image.asset("img/home-like.jpg",
                          width: 150,),
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
                        Image.asset("img/home-2.jpg",
                          width: 150,),
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
                        Image.asset("img/home-taki.jpg",
                          width: 150,),
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
                        Image.asset("img/home-ceket.jpg",
                          width: 150,),
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
                        Image.asset("img/home-mu.jpg",
                          width: 150,),
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
        ],
      ),
    );
  }
}
