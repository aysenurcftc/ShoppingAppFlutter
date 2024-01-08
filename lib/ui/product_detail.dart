import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:senior_project/models/basket_product.dart';
import 'package:senior_project/models/products.dart';
import 'package:senior_project/service/product_service.dart';
import 'package:senior_project/ui/shopping_basket_screen.dart';
import 'package:senior_project/providers/basket_provider.dart';


class ProductDetailScreen extends StatefulWidget {

  final String image;
  final String productTitle;
  final String productPrice;
  final String description;
  final String condition;
  final String category;
  final String size;
  final String uid;

  ProductDetailScreen(this.image, this.productTitle, this.productPrice, this.description,this.condition,
      this.category, this.size, this.uid);

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  final FirestoreService firestoreService = FirestoreService();

  @override
  Widget build(BuildContext context) {


    var screenSize = MediaQuery.of(context);
    final double height = screenSize.size.height;
    final double width = screenSize.size.width;


    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              alignment: Alignment.center,
              child:  Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      widget.image,
                      width: double.infinity,
                      fit: BoxFit.cover,
                  ),
                  ),

                  Positioned(
                    top: 50,
                    right: 10,
                    child: Container(
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                      padding: EdgeInsets.all(2),
                      child: Center(
                        child: IconButton(
                          icon : Icon( Icons.share,),
                          onPressed: (){},
                          color: Colors.pink.shade400,
                          iconSize: 30,
                        ),
                      ),
                    ),
                  ),

                  Positioned(
                    top: 50,
                    left: 10,
                    child: Container(
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                      padding: EdgeInsets.all(2),
                      child: Center(
                        child: IconButton(
                          icon : Icon( Icons.arrow_back,),
                          onPressed: (){
                            Navigator.pop(context);
                          },
                          color: Colors.pink.shade400,
                          iconSize: 30,
                        ),
                      ),
                    ),
                  ),

                  Positioned(
                    top: 50,
                    right: 70,
                    child: Container(
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                      padding: EdgeInsets.all(2),
                      child: IconButton(
                        icon: Icon(
                  Icons.favorite_border
                        ),
                        color: Colors.pink.shade400,
                        iconSize: 30,
                        onPressed: () async {
                          setState(() {

                          });

                        },
                      ),
                    ),
                  ),

                ],
              ),
            ),


            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10,bottom: 10,left: 15),
                  child: Text(widget.productTitle,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.black,
                  ),
                  ),
                ),
                Spacer(),
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Text(widget.productPrice+ "₺",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.grey.shade600,
                  ),),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 20,),
                  child: Icon(Icons.bookmark_border,
                  size: 30,
                    color: Colors.pink.shade400,
                  ),
                ),

              ],
            ),

             Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20,right: 10),
                  child: Icon(
                    Icons.local_offer_outlined,
                    color: Colors.pink.shade400,

                  ),
                ),
                Text("Durumu: ",
                style: TextStyle(
                  color: Colors.pink.shade400,
                ),
                ),
                Text(widget.category,
                  style: TextStyle(
                    color: Colors.grey.shade600,
                  ),
                ),

                Spacer(),
                Padding(
                  padding: const EdgeInsets.only(right: 25),
                  child: Row(
                    children: [
                      Text("Beden: ",
                        style: TextStyle(
                          color: Colors.pink.shade400,
                        ),
                      ),
                      Text(widget.size, style: TextStyle(
                        color: Colors.grey.shade600,
                      ),
                      )
                    ],
                  ),
                ),


              ],
            ),

            Padding(
              padding: const EdgeInsets.only(left: 18,right: 18,top: 10,bottom: 20),
              child: Text( widget.description,
              style: TextStyle(
                color: Colors.grey.shade600,
                fontSize: 16,
              ),),
            ),

            Container(
              width: width,
                height: 80,
                color: Colors.white,
                child: Padding(
                  padding:  EdgeInsets.only(left: 18,right: 18,top: 10,bottom: 10),
                  child: Text("Kuponlar&Kampanyalar",style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,

                  ),

                  ),
                ),
            ),

            Padding(
              padding: EdgeInsets.only(top: 10,bottom: 50,right: 10,left: 10),
              child: Container(
                width: width,
                height: 100,
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Soru&Cevap",style: TextStyle(
                      fontSize: 20,
                    ),),
                    TextField(
                      decoration: InputDecoration(
                        hintText: "Satıcıya Sor",
                        hintStyle: TextStyle(
                          fontSize: 14,
                          color: Colors.grey.shade600,
                        ),
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ],
                ),
              ),
            ),






          ],

        ),
      ),
        bottomNavigationBar: Consumer<BasketProvider>(
          builder: (BuildContext context, BasketProvider value, Widget? child) {
            return  BottomNavigationBar(
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(Icons.check),
                  label: 'Teklif Ver',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.shopping_bag_outlined),
                  label: 'Sepete Ekle',
                ),
              ],
              selectedItemColor: Colors.grey.shade600,
              unselectedItemColor: Colors.grey.shade600,
              onTap: (int index){
                if(index==0){

                }else if(index==1){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ShoppingBasketScreen()),
                  );

                  final product = basketProduct(
                    image: widget.image,
                    title: widget.productTitle,
                    price: widget.productPrice,
                    description: widget.description,
                    condition: widget.condition,
                    category: widget.category,
                    size: widget.size,
                    uid: widget.uid,
                  );

                  Provider.of<BasketProvider>(context, listen: false).addToBasket(product);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Ürün sepete eklendi')),
                  );
                }
              },
            );
          },
        ),
    );


  }
}

