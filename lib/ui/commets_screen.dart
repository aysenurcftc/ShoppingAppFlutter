
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:senior_project/models/users.dart';
import 'package:senior_project/providers/user_provider.dart';
import 'package:senior_project/service/product_service.dart';

import '../utils/colors.dart';
import '../widgets/commets_card.dart';

class CommentsScreen extends StatefulWidget {

  final snap;
  const CommentsScreen({super.key, required this.snap});

  @override
  State<CommentsScreen> createState() => _CommentsScreenState();
}

class _CommentsScreenState extends State<CommentsScreen> {


  final TextEditingController  _commentController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _commentController.dispose();
  }


  @override
  Widget build(BuildContext context) {

    final Users user = Provider.of<UserProvider>(context).getUser;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.white,
        title: const Text("Yorumlar"),
        centerTitle: false,
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('products')
            .doc(widget.snap)
            .collection('comments')
            .orderBy("datePublished",descending: true)
            .snapshots(),
        builder: (context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return  ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (ctx, index) => CommentCard(
              snap: (snapshot.data! as dynamic).docs[index].data(),
              onDelete: () async {
                await ProductService().deleteComment(
                    snapshot.data!.docs[index].id, widget.snap); // Pass the comment ID or any identifier
              },
            ),
          );
        },
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          height: kToolbarHeight,
          margin: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          padding: const EdgeInsets.only(left: 16, right: 8),
          child:  Row(
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(
                    user.photoUrl
                ),
                radius: 16,
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(left: 16, right: 8),
                  child: TextField(
                    controller: _commentController,
                    decoration: InputDecoration(
                      hintText: "Yorum yap",
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),

              InkWell(
                onTap: () async{
                  await ProductService().postComment(widget.snap, _commentController.text, user.uid, user.username, user.photoUrl);
                  setState(() {
                    _commentController.text = "";
                  });
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: Text(
                    "Gönder",
                    style: TextStyle(
                      color: Colors.black,

                    ),

                  ),
                ),

              ),
            ],
          ),
        ),
      ),
    );



  }




}
