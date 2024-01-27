
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:senior_project/models/products.dart';
import 'package:senior_project/providers/user_provider.dart';
import 'package:senior_project/service/auth.dart';
import 'package:senior_project/service/product_service.dart';
import 'package:senior_project/widgets/follow_button.dart';
import '../utils/utils.dart';

class ProfileGeneral extends StatefulWidget {

  final String uid;

  const ProfileGeneral({super.key, required this.uid});

  @override
  State<ProfileGeneral> createState() => _ProfileGeneralState();
}


class _ProfileGeneralState extends State<ProfileGeneral> {

  final AuthService authService = AuthService();
  final ProductService firestoreService = ProductService();
  late Future<List<Product>> userProducts;
  late Future<String?> username;


  //late String? uid;
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
    //userProvider = Provider.of<UserProvider>(context, listen: false);
    //userProvider.fetchUser();
    //fetchData();
    getData();
    setState(() {});
  }


  /*Future<void> fetchData() async {
    uid = await authService.getCurrentUserId();
  }*/

  Future<void> getData() async {
    setState(() {
      isLoading = true;
    });
    try{
      var userSnap = await FirebaseFirestore.instance.collection('users').doc(widget.uid).get();

      // get post lENGTH
      var productSnap = await FirebaseFirestore.instance
          .collection('products')
          .where('uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .get();


        userData = userSnap.data()!;
        followers = userSnap.data()!['followers'].length;
        following = userSnap.data()!['following'].length;
        isFollowing = userSnap
            .data()!['followers']
            .contains(FirebaseAuth.instance.currentUser!.uid);

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

      return isLoading
        ? const Center(
        child: CircularProgressIndicator(),
        )
        : Scaffold(
        appBar: AppBar(
          title: FirebaseAuth.instance.currentUser!.uid != widget.uid ? Text(userData["username"]) : Text("Profilim"),
        ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
          Container(
          color: Colors.white,
          height: 200,
          width: width,
          child: Row(
            children: [
              Padding(
                padding:  EdgeInsets.only(left: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Consumer<UserProvider>(
                      builder: (context, value,child) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 100,
                              height: 100,
                              child: CircleAvatar(
                                backgroundImage: NetworkImage(
                                  userData["photoUrl"] ?? "https://i.pinimg.com/736x/8b/25/91/8b259121597545e2739974384c18a8e6.jpg",
                                ),
                              ),
                            ),

                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 54),
                              child: Row(
                                children: [
                                  Text("Takip: ${following}",
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.grey.shade600,
                                        fontWeight: FontWeight.bold
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: 15),
                                    child: Text("Takipçi: ${followers}",
                                      style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.grey.shade600,
                                          fontWeight: FontWeight.bold
                                      ),
                                    ),
                                  ),

                                ],
                              ),
                            ),

                          ],
                        );
                      },
                    ),

                    Padding(
                      padding:  EdgeInsets.only(left: 20,top: 10, bottom: 5),
                      child: Consumer<UserProvider>(
                        builder: (BuildContext context, UserProvider value, Widget? child) {
                          return Text(
                            userData["username"] ?? "Kullanıcı",
                            style: TextStyle(
                              color: Colors.black54,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          );
                        },
                      ),
                    ),

                    Row(
                      children: [
                        FirebaseAuth.instance.currentUser!.uid == widget.uid? Text("")
                         : isFollowing ? FollowButton(
                          text: "Takip",
                          backgroundColor: Colors.pinkAccent,
                          textColor: Colors.white,
                          borderColor: Colors.white,
                          function: () async {
                            await ProductService()
                                .followUser(
                              FirebaseAuth.instance
                                  .currentUser!.uid,
                              userData['uid'],
                            );

                            setState(() {
                              isFollowing = false;
                              followers--;
                            });
                          },
                        ) : FollowButton(
                          text: "Takip et",
                          backgroundColor: Colors.white,
                          textColor: Colors.white,
                          borderColor: Colors.pinkAccent,
                          function: () async{
                            await ProductService()
                                .followUser(
                              FirebaseAuth.instance
                                  .currentUser!.uid,
                              userData['uid'],
                            );
                            setState(() {
                              isFollowing = true;
                              followers++;
                            });
                          },
                        ),

                      ],
                    ),
                  ],
                ),
              ),
              Spacer(),


            ],
          ),
        ),

          Divider(),
          SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('products')
                      .where('uid', isEqualTo: widget.uid)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text('Hata oluştu: ${snapshot.error}');
                    } else {
                      var products = (snapshot.data! as dynamic).docs.length;
                      if (products != null) {
                        return Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(top: 10, left: 10),
                              child: Row(
                                children: [
                                  Text(
                                    'Toplam: ${products} ürün',
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
                                mainAxisExtent: 290.0,
                              ),
                              itemCount: (snapshot.data! as dynamic).docs.length,
                              itemBuilder: (context, index) {
                                DocumentSnapshot snap = (snapshot.data! as dynamic).docs[index];
                                return Padding(
                                  padding: EdgeInsets.only(left: 5),
                                  child: Container(
                                    width: 140,
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
                                            Stack(
                                              children: [
                                                ClipRRect(
                                                  borderRadius: BorderRadius.circular(10),
                                                  child: Image.network(
                                                    snap["image"],
                                                    width: double.infinity,
                                                    height: 200,
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                                FirebaseAuth.instance.currentUser!.uid != widget.uid? Text("") : Positioned(
                                                  top: 10,
                                                  right: 10,
                                                  child: Container(
                                                    width: 50,
                                                    height: 50,
                                                    child: Stack(
                                                      alignment: Alignment.center,
                                                      children: [
                                                        // Beyaz yuvarlak ikon (arka plan)
                                                        Container(
                                                          width: 40,
                                                          height: 40,
                                                          decoration: BoxDecoration(
                                                            shape: BoxShape.circle,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                        // Çöp kutusu ikonu (üstte)
                                                        IconButton(
                                                          onPressed: () async {
                                                            await showDialog(
                                                              context: context,
                                                              builder: (context) => Dialog(
                                                                child: ListView(
                                                                  padding: EdgeInsets.symmetric(vertical: 16),
                                                                  shrinkWrap: true,
                                                                  children: [
                                                                    "Ürünü Sil"
                                                                  ].map(
                                                                        (e) => InkWell(
                                                                      onTap: () async {
                                                                        await ProductService().deletePost(snap["productId"]);
                                                                        Navigator.of(context).pop();

                                                                        setState(() {
                                                                          userProducts = firestoreService.getUserProducts();
                                                                        });
                                                                      },
                                                                      child: Container(
                                                                        padding: EdgeInsets.symmetric(
                                                                          vertical: 12,
                                                                          horizontal: 16,
                                                                        ),
                                                                        child: Text(e),
                                                                      ),
                                                                    ),
                                                                  ).toList(),
                                                                ),
                                                              ),
                                                            );
                                                          },
                                                          icon: Icon(Icons.delete_outline),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(top: 8, left: 6),
                                          child: Text(
                                            snap["title"],
                                            textAlign: TextAlign.center,
                                            style: TextStyle(fontSize: 15),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(top: 10, bottom: 5, left: 6),
                                          child: Text(
                                            "${snap["price"]} ₺",
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
      ),
    );
    }

}
