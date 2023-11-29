import 'package:flutter/material.dart';
import 'package:senior_project/models/product.dart';



class ProductDetailScreen extends StatelessWidget {

  final String image;
  final String productTitle;
  final double productPrice;
  final String description;
  final String condition;
  final String category;
  final String size;

  ProductDetailScreen(this.image, this.productTitle, this.productPrice, this.description,this.condition,
      this.category, this.size);


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
                      image,
                    fit: BoxFit.cover,
                  ),
                  ),
                  Positioned(
                    top: 50,
                    right: 10,
                    child: GestureDetector(
                      onTap: () {},
                      child: Icon(
                        Icons.favorite_border,
                        color: Colors.pink.shade400,
                        size: 30,
                      ),
                    ),
                  ),

                  Positioned(
                    top: 50,
                    right: 50,
                    child: GestureDetector(
                      onTap: () {},
                      child: Icon(
                        Icons.share,
                        color: Colors.pink.shade400,
                        size: 30,
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
                  child: Text(productTitle,
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
                  child: Text(productPrice.toString()+ "₺",
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
                Text(category,
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
                      Text(size, style: TextStyle(
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
              child: Text("İnceltilmiş viskoz kumaştan relaxed fit bluz. Manşetleri düğmeli, pilili, "
                  "yırtmaçlı uzun kollu, V yaka. Kontrast fular detaylı. Yanları yırtmaçlı asimetrik "
                  "kenarlı. Önü düğmeli.",
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
              padding: const EdgeInsets.all(8.0),
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
    );
  }
}

