import 'package:cloud_firestore/cloud_firestore.dart';


class Product {
  late String title;
  late String description;
  late String price;
  late String size;
  late String category;
  late String condition;
  late String uid;
  late String image;
  late DateTime timestamp;
  final likes;


  // Constructor
  Product({
    required this.title,
    required this.description,
    required this.price,
    required this.size,
    required this.category,
    required this.condition,
    required this.uid,
    required this.image,
    required this.timestamp,
    required this.likes,
  });

  static Product fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return Product(
        title : snapshot['title'],
        description: snapshot["description"],
        price : snapshot['price'],
        category : snapshot['category'],
        condition : snapshot['condition'],
        size : snapshot['size'],
        uid: snapshot["uid"],
        image : snapshot['image'],
        timestamp: (snapshot['timestamp'] as Timestamp).toDate(),
        likes: snapshot["likes"],

    );
  }


  Map<String, dynamic> toJson() => {
    "title": title,
    "description": description,
    "price": price,
    "category": category,
    "condition": condition,
    "size": size,
    'uid': uid,
    'image': image,
    'timestamp' : timestamp,
    'likes' : likes,
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