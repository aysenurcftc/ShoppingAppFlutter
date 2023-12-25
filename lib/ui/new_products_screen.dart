

import 'package:flutter/material.dart';
import 'package:senior_project/models/products.dart';
import 'package:senior_project/ui/product_detail.dart';

class NewProductScreen extends StatefulWidget {

  final Future<List<Product>> userProducts;

  NewProductScreen(this.userProducts);


  @override
  State<NewProductScreen> createState() => _NewProductScreenState();
}

class _NewProductScreenState extends State<NewProductScreen> {


  bool isLiked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("En Yeni Ürünler"),
      ),
      body:   SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: FutureBuilder<List<Product>>(
          future: widget.userProducts,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Hata oluştu: ${snapshot.error}');
            } else {
              List<Product>? products = snapshot.data;
              if (products != null && products.isNotEmpty) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 10, left: 10),
                      child: Row(
                        children: [
                          Text(
                            'Toplam: ${products.length} ürün',
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.grey.shade600,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Spacer(),
                          Padding(
                            padding: EdgeInsets.only(top: 10, right: 10),
                            child: IconButton(onPressed: () {}, icon: Icon(Icons.tune)),
                          )
                        ],
                      ),
                    ),
                    GridView.builder(
                      shrinkWrap: true,
                      physics: BouncingScrollPhysics(),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 15,
                          mainAxisSpacing: 15,
                          mainAxisExtent: 280.0
                      ),
                      itemCount: products.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: (){
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ProductDetailScreen(
                                  products[index].image,
                                  products[index].title,
                                  products[index].price,
                                  products[index].description,
                                  products[index].category,
                                  products[index].condition,
                                  products[index].size,
                                  products[index].uid,
                                ),
                              ),
                            );
                          },
                          child: Container(
                            width: 130,
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
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.network(
                                        products[index].image,
                                        height: 200,
                                        fit: BoxFit.cover,
                                        width: double.infinity,
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
                                             isLiked  ? Icons.favorite : Icons.favorite_border,
                                          ),
                                          color: Colors.pink.shade400,
                                          iconSize: 20,
                                          onPressed: () {
                                            setState(() {

                                            });
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 8, left: 6),
                                  child: Text(
                                    products[index].title,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontSize: 15),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 10, bottom: 5, left: 6),
                                  child: Text(
                                    "${products[index].price} ₺",
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
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
                    ),
                  ],
                );
              } else {
                return Text('Henüz ürün eklenmemiş.');
              }
            }
          },
        ),
      ),
    );
  }
}
