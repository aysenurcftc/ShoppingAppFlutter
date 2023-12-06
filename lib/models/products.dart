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
  late bool isLiked;

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
    this.isLiked = false,

  });


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
    isLiked = data['isLiked'] ?? false;
  }
}