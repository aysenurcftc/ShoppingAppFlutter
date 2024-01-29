
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:senior_project/models/products.dart';
import 'package:senior_project/providers/product_provider.dart';
import 'package:senior_project/providers/user_provider.dart';
import 'package:senior_project/service/product_service.dart';
import 'package:senior_project/ui/product_detail.dart';
import 'package:senior_project/widgets/like_animation.dart';

class SaveProductScreen extends StatefulWidget {
  const SaveProductScreen({super.key});

  @override
  State<SaveProductScreen> createState() => _SaveProductScreenState();
}



class _SaveProductScreenState extends State<SaveProductScreen> {
  late UserProvider userProvider;
  late ProductProvider  productProvider;


  @override
  void initState() {
    super.initState();
    userProvider = Provider.of<UserProvider>(context, listen: false);
    userProvider.fetchUser();

    productProvider = Provider.of<ProductProvider>(context, listen: false);

  }


  final ProductService firestoreService = ProductService();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Koleksiyonum"),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Consumer<ProductProvider>(builder: (context, productProvider, widget) {
          List<String> savedUserIds = [userProvider.getUser.uid]; // Kullanıcının ID'sini içeren liste

          return StreamBuilder<List<Product>>(
            stream: firestoreService.streamAllUsersProducts(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                List<Product> products = snapshot.data ?? [];

                List<Product> savedProducts = products.where((product) {
                  return product.saveProducts.any((savedUserId) => savedUserIds.contains(savedUserId));
                }).toList();

                if (savedProducts.isNotEmpty) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 10, left: 10),
                        child: Row(
                          children: [
                            Text(
                              'Toplam: ${savedProducts.length} ürün',
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
                          mainAxisExtent: 280.0,
                        ),
                        itemCount: savedProducts.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ProductDetailScreen(
                                    savedProducts[index].image,
                                    savedProducts[index].title,
                                    savedProducts[index].productId,
                                    savedProducts[index].price,
                                    savedProducts[index].description,
                                    savedProducts[index].category,
                                    savedProducts[index].condition,
                                    savedProducts[index].size,
                                    savedProducts[index].uid,
                                    savedProducts[index].likes,
                                    savedProducts[index].productQuantity,
                                    savedProducts[index].saveProducts,
                                  ),
                                ),
                              );
                            },
                            child: Container(
                              width: 130,
                              height: 230,
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
                                          savedProducts[index].image,
                                          height: 190,
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
                                          child: LikeAnimation(
                                            isAnimating: savedProducts[index].likes.contains(userProvider.getUser.uid),
                                            smallLike: false,
                                            child: IconButton(
                                              icon: savedProducts[index].likes.contains(userProvider.getUser.uid)
                                                  ? const Icon(Icons.favorite, color: Colors.red)
                                                  : const Icon(Icons.favorite_border),
                                              color: Colors.pink.shade400,
                                              iconSize: 20,
                                              onPressed: () async {
                                                await ProductService().likeProduct(
                                                  savedProducts[index].productId,
                                                  userProvider.getUser.uid,
                                                  savedProducts[index].likes,
                                                );

                                                if (productProvider.likedProductIds.contains(savedProducts[index].productId)) {
                                                  productProvider.removeFromLikedProducts(savedProducts[index].productId);
                                                } else {
                                                  productProvider.addToLikedProducts(savedProducts[index].productId);
                                                }
                                              },
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 8, left: 6),
                                    child: Text(
                                      savedProducts[index].title,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(fontSize: 15),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 10, bottom: 5, left: 6),
                                    child: Text(
                                      "${savedProducts[index].price} ₺",
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
                  return SizedBox(
                    height: 400,
                    child: Center(
                        child: Text('Henüz koleksiyon bulunmamaktadır.',
                          style: TextStyle(
                            color:Colors.pinkAccent,
                            fontSize: 16,
                          ),
                        )),
                  );
                }
              }
            },
          );
        }),
      ),
    );
  }
}