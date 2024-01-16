import 'package:cloud_firestore/cloud_firestore.dart';


class Wallet {
  late String uid;
  late String price;
  late DateTime timestamp;



  // Constructor
  Wallet({
    required this.uid,
    required this.price,
    required this.timestamp,});


  static Wallet fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return Wallet(
      uid: snapshot["uid"],
      price : snapshot['price'],
      timestamp: (snapshot['timestamp'] as Timestamp).toDate(),


    );
  }


  Map<String, dynamic> toJson() => {
    "price": price,
    'uid': uid,
    'timestamp' : timestamp,
  };


/*
  Product.fromMap(Map<String, dynamic> data) {

    title = data['title'] ?? '';
    description = data['description'] ?? '';
    price = data['price'] ?? '';
    category = data['category'] ?? '';
    condition = data['condition'] ?? '';
    size = data['size'] ?? '';
    uid = data['uid'] ?? '';
    image = data['image'] ?? '';
    timestamp = (data['timestamp'] as Timestamp).toDate();

  }*/



}