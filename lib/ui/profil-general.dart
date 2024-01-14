
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:senior_project/models/products.dart';
import 'package:senior_project/models/users.dart';
import 'package:senior_project/providers/user_provider.dart';
import 'package:senior_project/service/auth.dart';
import 'package:senior_project/service/product_service.dart';
import 'package:senior_project/ui/user_settings.dart';

class ProfileGeneral extends StatefulWidget {

  @override
  State<ProfileGeneral> createState() => _ProfileGeneralState();
}



class _ProfileGeneralState extends State<ProfileGeneral> {

  final AuthService authService = AuthService();
  final ProductService firestoreService = ProductService();
  late Future<List<Product>> userProducts;
  late Future<String?> username;


  late String? uid;
  var userData = {};
  int followers = 0;
  int following = 0;
  bool isFollowing = false;
  bool isLoading = false;
  late UserProvider userProvider;


  @override
  void initState()  {
    super.initState();
    userProducts =  firestoreService.getUserProducts();
    username = authService.getCurrentUsername();
    userProvider = Provider.of<UserProvider>(context, listen: false);
    userProvider.fetchUser();
     fetchData();
  }


  Future<void> fetchData() async {
    uid = await authService.getCurrentUserId();
  }


  @override
  Widget build(BuildContext context) {

    var screenSize = MediaQuery.of(context);
    final double height = screenSize.size.height;
    final double width = screenSize.size.width;

      return isLoading
        ? const Center(
        child: CircularProgressIndicator(),
        )
        : Scaffold(
      body: Column(
        children: [
        Container(
        color: Colors.white,
        height: 200,
        width: width,
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      left: 20, top: 8, bottom: 5),
                  child: Consumer<UserProvider>(
                    builder: (context, value,child) {
                      return Container(
                        width: 100,
                        height: 100,
                        child: CircleAvatar(
                          backgroundImage: NetworkImage(
                            value.getUser?.photoUrl ?? "https://i.pinimg.com/736x/8b/25/91/8b259121597545e2739974384c18a8e6.jpg",
                          ),
                        ),
                      );
                    },
                  ),
                ),

                Padding(
                  padding:  EdgeInsets.only(left: 50,top: 8),
                  child:  Consumer<UserProvider>(
                    builder: (BuildContext context, UserProvider value, Widget? child) {
                      return Text(
                        value.getUser?.name ?? "Kullanıcı",
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      );
                    },
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(left: 25,top: 10),
                  child: ElevatedButton(onPressed: (){},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.pinkAccent.shade100,
                      ),
                      child: Text("Takip",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                      ),
                  ),
                )
              ],
            ),
            Spacer(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  children: [
                    IconButton(onPressed: (){
                      Navigator.pop(context);
                    }, icon: Icon(Icons.arrow_back)),
                    IconButton(onPressed: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => UserSettingsScreen()),
                      );
                    }, icon: Icon(Icons.settings,
                    size: 28,)),
                  ],
                ),
                Spacer(),
                Padding(
                  padding: EdgeInsets.only(right: 8,bottom: 8),
                  child: Row(
                    children: [
                      Padding(
                        padding:  EdgeInsets.only(right: 8),
                        child: Text("Takip: 0",
                          style: TextStyle(
                          fontSize: 15,
                          color: Colors.grey.shade600,
                            fontWeight: FontWeight.bold
                        ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 8),
                        child: Text("Takipçi: 0",
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.grey.shade600,
                            fontWeight: FontWeight.bold
                          ),),
                      ),

                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),

        SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
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
                              crossAxisSpacing: 15,
                              mainAxisSpacing: 15,
                                mainAxisExtent: 290.0
                            ),
                            itemCount: products.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: EdgeInsets.only(left: 5),
                                child: Container(
                                  width: 150,
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
                                              width: double.infinity,
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
                                ),
                              );
                            },
                          ),
                        ],
                      );
                    } else {
                      return Column(
                        children: [
                          SizedBox(height: 100,),
                          Text('Henüz ürün eklenmemiş.'),
                        ],
                      );
                    }
                  }
                },
              ),

            ],
          ),
        ),


        ]
      ),
    );
    }

}
