import 'package:cloud_firestore/cloud_firestore.dart';


class Product {
  late String title;
  final String productId;
  late String description;
  late String price;
  late String size;
  late String category;
  late String condition;
  late String uid;
  late String image;
  late DateTime timestamp;
  final String profImage;

  final String productQuantity;
  final String name;
  final likes;
  final saveProducts;


  // Constructor
  Product({
    required this.title,
    required this.productId,
    required this.description,
    required this.price,
    required this.size,
    required this.category,
    required this.condition,
    required this.uid,
    required this.image,
    required this.timestamp,
    required this.profImage,
    required this.productQuantity,
    required this.name,
    required this.likes,
    required this.saveProducts,
  });

  static Product fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return Product(
        title : snapshot['title'],
        productId: snapshot['productId'],
        description: snapshot["description"],
        price : snapshot['price'],
        category : snapshot['category'],
        condition : snapshot['condition'],
        size : snapshot['size'],
        uid: snapshot["uid"],
        image : snapshot['image'],
        timestamp: (snapshot['timestamp'] as Timestamp).toDate(),
        profImage: snapshot['profImage'],
        productQuantity : snapshot['productQuantity'],
        name: snapshot['name'],
        likes: snapshot["likes"],
      saveProducts:  snapshot["saveProducts"],

    );
  }


  Map<String, dynamic> toJson() => {
    "title": title,
    "productId": productId,
    "description": description,
    "price": price,
    "category": category,
    "condition": condition,
    "size": size,
    'uid': uid,
    'image': image,
    'timestamp' : timestamp,
    'profImage': profImage,
    'productQuantity' : productQuantity,
    'name' : name,
    'likes' : likes,
    'saveProducts' : saveProducts,
  };





}