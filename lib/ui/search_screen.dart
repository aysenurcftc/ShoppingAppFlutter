
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:senior_project/ui/profile-screen.dart';
import 'package:senior_project/utils/colors.dart';


class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {

  final TextEditingController searchEditingController = TextEditingController();
  bool isShowUsers = false;


  @override
  void dispose() {
    super.dispose();
    searchEditingController.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mobileBackgroundColor,
        title: TextFormField(
          controller: searchEditingController,
          decoration: InputDecoration(
            labelText: "Search for a user",
          ),
          onFieldSubmitted: (String _){
            setState(() {
              isShowUsers = true;
            });

          },
        ),
      ),
      body: isShowUsers ? FutureBuilder(
        future: FirebaseFirestore.instance.collection("users")
            .where("username", isGreaterThanOrEqualTo: searchEditingController.text)
            .get(),
        builder: (context, snapshot){
          if(!snapshot.hasData){
            return const Center (
              child: CircularProgressIndicator(),
            );
          }
          return ListView.builder(
              itemCount: (snapshot.data! as dynamic).docs.length,
              itemBuilder: (context, index){
                return InkWell(
                  onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => ProfileScreen(uid: (snapshot.data! as dynamic).docs[index]['uid']))),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(
                        (snapshot.data! as dynamic).docs[index]['photoUrl'],
                      ),
                    ),
                    title: Text((snapshot.data! as dynamic).docs[index]['username']),
                  ),
                );
              }
          );
        },
      ) : FutureBuilder(
        future: FirebaseFirestore.instance.collection('posts').get(),
        builder: (context, snapshot){
          if(!snapshot.hasData){
            return const Center(child: CircularProgressIndicator());
          }

          return MasonryGridView.count(
            crossAxisCount: 3,
            itemCount: (snapshot.data! as dynamic).docs.length,
            itemBuilder: (context, index) => Image.network(
              (snapshot.data! as dynamic).docs[index]['postUrl'],
              fit: BoxFit.cover,
            ),
            mainAxisSpacing: 8.0,
            crossAxisSpacing: 8.0,
          );


        },


      ),
    );
  }
}
