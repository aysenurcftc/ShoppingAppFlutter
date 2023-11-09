import 'package:flutter/material.dart';
import 'package:senior_project/models/product.dart';

class ProfileGeneral extends StatelessWidget {


  ProfileGeneral({Key? key}) : super(key: key);



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




  @override
  Widget build(BuildContext context) {

    var screenSize = MediaQuery.of(context);
    final double height = screenSize.size.height;
    final double width = screenSize.size.width;

    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
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
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  IconButton(onPressed: (){}, icon: Icon(Icons.settings,
                  size: 28,)),
                  Spacer(),
                  Padding(
                    padding: EdgeInsets.only(right: 8,bottom: 8),
                    child: Row(
                      children: [
                        Padding(
                          padding:  EdgeInsets.only(right: 6),
                          child: Text("Takip: 0",
                            style: TextStyle(
                            fontSize: 15,
                            color: Colors.grey.shade600,
                              fontWeight: FontWeight.bold
                          ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: 6),
                          child: Text("Takipçi: 0",
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.grey.shade600,
                              fontWeight: FontWeight.bold
                            ),),
                        ),
                        Text("Favori: 0",style: TextStyle(
                          fontSize: 15,
                          color: Colors.grey.shade600,
                          fontWeight: FontWeight.bold
                        ),),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 10, left: 10),
                    child: Text("Toplam: 4 ürün",
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.grey.shade600,
                        fontWeight: FontWeight.bold,
                    ),),
                  ),
                  Spacer(),
                  Padding(
                    padding: EdgeInsets.only(top: 10,right: 10),
                    child: IconButton(onPressed: (){}, icon: Icon(Icons.tune)),
                  )
                ],
              ),
              Row(
                children: [



                  Padding(
                    padding: const EdgeInsets.all(10.0),
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
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.asset("img/zara_bluz_2.jpg", width: 150),
                              ),

                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 8, left: 6),
                            child: Text(
                              "başlık",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 15
                              ),
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.only(top: 10,bottom: 5,left: 6),
                            child: Text(
                             "100" + "₺",
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
                  ),



                  Padding(
                    padding: const EdgeInsets.all(10.0),
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
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.asset("img/koton_bluz.jpg", width: 150),
                              ),

                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 8, left: 6),
                            child: Text(
                              "başlık",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 15
                              ),
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.only(top: 10,bottom: 5,left: 6),
                            child: Text(
                              "100" + "₺",
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
                  ),

                ],
              ),


              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
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
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.asset("img/zara_bluz.jpg", width: 150),
                              ),

                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 8, left: 6),
                            child: Text(
                              "başlık",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 15
                              ),
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.only(top: 10,bottom: 5,left: 6),
                            child: Text(
                              "100" + "₺",
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
                  ),




                  Padding(
                    padding: const EdgeInsets.all(10.0),
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
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.asset("img/koton_bluz_2.jpg", width: 150),
                              ),

                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 8, left: 6),
                            child: Text(
                              "başlık",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 15
                              ),
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.only(top: 10,bottom: 5,left: 6),
                            child: Text(
                              "100" + "₺",
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
                  ),



                ],
              ),
            ],
          ),


          ]
        ),
      ),
    );
  }
}
