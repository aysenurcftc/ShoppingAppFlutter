import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:senior_project/models/basket_product.dart';
import 'package:senior_project/providers/product_provider.dart';
import 'package:senior_project/providers/user_provider.dart';
import 'package:senior_project/service/product_service.dart';
import 'package:senior_project/ui/commets_screen.dart';
import 'package:senior_project/ui/create_coupon.dart';
import 'package:senior_project/ui/profil-general.dart';
import 'package:senior_project/ui/shopping_basket_screen.dart';
import 'package:senior_project/providers/basket_provider.dart';
import 'package:senior_project/utils/utils.dart';
import 'package:senior_project/widgets/like_animation.dart';


class ProductDetailScreen extends StatefulWidget {

  final String image;
  final String productTitle;
  final String productId;
  final String productPrice;
  final String description;
  final String condition;
  final String category;
  final String size;
  final String uid;
  final likes;



  ProductDetailScreen( this.image, this.productTitle, this.productId, this.productPrice, this.description,this.condition,
      this.category, this.size, this.uid, this.likes,);

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}


class _ProductDetailScreenState extends State<ProductDetailScreen> {
  final ProductService firestoreService = ProductService();

  late UserProvider userProvider;
  late ProductProvider productProvider;

  late String photoUrl;
  late String username;
  late String uid;

  @override
  void initState() {
    super.initState();
    userProvider = Provider.of<UserProvider>(context, listen: false);
    userProvider.fetchUser();
    productProvider = Provider.of<ProductProvider>(context, listen: false);
    isLiked = widget.likes.contains(userProvider.getUser.uid);
    getData();
  }

  bool isLikeAnimating = false;
  late bool isLiked;
  bool isLoading = false;


  getData() async {
    setState(() {
      isLoading = true;
    });
    try{
      var userSnap = await FirebaseFirestore.instance.collection('users').doc(widget.uid).get();
      photoUrl = userSnap.data()!['photoUrl'];
      username = userSnap.data()!['username'];
      uid = userSnap.data()!['uid'];

      setState(() {});
    }catch(e){
      showSnackBar(context, e.toString());
    }
    setState(() {
      isLoading = false;
    });
  }




  @override
  Widget build(BuildContext context) {


    var screenSize = MediaQuery.of(context);
    final double height = screenSize.size.height;
    final double width = screenSize.size.width;



    return isLoading ? const Center(child: CircularProgressIndicator(),) : Scaffold(
      body: Consumer<ProductProvider>(builder: (context, productProvider, child){
        return SingleChildScrollView(
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
                        child: LikeAnimation(
                          isAnimating: isLiked,
                          smallLike: false,
                          child: IconButton(
                            icon: isLiked
                                ? const Icon(Icons.favorite, color: Colors.red)
                                : const Icon(Icons.favorite_border),
                            color: Colors.pink.shade400,
                            iconSize: 20,
                            onPressed: () async {

                              await ProductService().likePost(
                                widget.productId,
                                widget.uid,
                                widget.likes,
                              );

                              if (widget.likes.contains(userProvider.getUser.uid)) {
                                widget.likes.remove(userProvider.getUser.uid);
                              } else {
                                widget.likes.add(userProvider.getUser.uid);
                              }

                              setState(() {
                                isLiked = widget.likes.contains(userProvider.getUser.uid);
                              });

                            },
                          ),
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

              Divider(),

              Container(
                width: width,
                height: 100,
                color: Colors.white,
                child: Padding(
                  padding:  EdgeInsets.only(left: 18,right: 18,top: 20,bottom: 20),
                  child: Row(
                    children: [
                      Container(
                        height: 100,
                        width: 100,
                        child: CircleAvatar(
                          backgroundImage: NetworkImage(
                            photoUrl,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(username,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                            ),
                            GestureDetector(
                              onTap: (){
                                Navigator.of(context).push(MaterialPageRoute(builder: (contex) => ProfileGeneral(uid: uid)));
                              },
                                child: Text("Satıcıyı görüntüle >")),
                          ],
                        ),
                      ),
                    ],
                  )
                ),
              ),

              Divider(),

              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CreateCouponScreen()),
                  );
                },
                child: Container(
                  width: width,
                    height: 80,
                    color: Colors.white,
                    child: Padding(
                      padding:  EdgeInsets.only(left: 18,right: 18,top: 10,bottom: 10),
                      child: Text("Kuponlar & Kampanyalar",style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,

                      ),

                      ),
                    ),
                ),
              ),

              Padding(
                padding: EdgeInsets.only(top: 10,bottom: 50,right: 10,left: 10),
                child: Container(
                  width: width,
                  height: 80,
                  color: Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Text("Ürün Soru & Cevapları",style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                          ),
                          Spacer(),
                          GestureDetector(
                            onTap: (){
                              Navigator.of(context)
                                  .push(MaterialPageRoute(builder: (context) => CommentsScreen(snap: widget.productId,)));
                            },
                            child: Text(
                              "Tümü >",
                              style: TextStyle(
                                color: Colors.pinkAccent,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),



                    ],
                  ),
                ),
              ),





            ],
          ),
        );
      },
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

