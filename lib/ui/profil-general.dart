
import 'package:senior_project/service/auth.dart';
import 'package:flutter/material.dart';
import 'package:senior_project/models/products.dart';
import 'package:senior_project/service/product_service.dart';

class ProfileGeneral extends StatefulWidget {


  ProfileGeneral({Key? key}) : super(key: key);

  @override
  State<ProfileGeneral> createState() => _ProfileGeneralState();
}

class _ProfileGeneralState extends State<ProfileGeneral> {

  final AuthService authService = AuthService();
  final FirestoreService firestoreService = FirestoreService();
  late Future<List<Product>> userProducts;
  late Future<String?> username;


  @override
  void initState() {
    super.initState();
    userProducts = firestoreService.getUserProducts();
    username = authService.getCurrentUsername();
  }





  @override
  Widget build(BuildContext context) {

    var screenSize = MediaQuery.of(context);
    final double height = screenSize.size.height;
    final double width = screenSize.size.width;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
          Container(
          color: Colors.white,
          height: 130,
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
                    padding: const EdgeInsets.only(left: 30),
                    child: FutureBuilder<String?>(
                      initialData: "Kullanıcı Adı",
                      future: username,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          String? username = snapshot.data;
                          return Text(
                            username ?? 'KullanıcıAdı',
                            style: TextStyle(
                              color: Colors.grey.shade600,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          );
                        } else if (snapshot.hasError) {
                          return Text('Hata oluştu: ${snapshot.error}');
                        } else {
                          return CircularProgressIndicator();
                        }
                      },
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
          
              FutureBuilder<List<Product>>(
                future: userProducts,
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
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 12,
                              mainAxisSpacing: 12,
                                mainAxisExtent: 280.0
                            ),
                            itemCount: products.length,
                            itemBuilder: (context, index) {
                              return Container(
                                width: 120,
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
                                            width: 150,
                                            height: 200,
                                            fit: BoxFit.cover,

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
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15,
                                        ),
                                      ),
                                    ),
                                  ],
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
          
          
          
          
            ],
          ),
        
        
          ]
        ),
      ),
    );
  }
}
