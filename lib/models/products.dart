import 'package:cloud_firestore/cloud_firestore.dart';


class Product {
  late String title;
  late String description;
  late double price;
  late String category;
  late String condition;
  late String image;
  late String size;
  late String likes;
  late DateTime timestamp;
  late bool isLiked;

  // Constructor
  Product({
    required this.title,
    required this.description,
    required this.price,
    required this.category,
    required this.condition,
    required this.image,
    required this.timestamp,
    required this.size,
    this.isLiked = false,

  });


  Product.fromMap(Map<String, dynamic> data) {
    title = data['title'] ?? '';
    isLiked = data['isLiked'] ?? false;
    description = data['description'] ?? '';
    price = (data['price'] ?? 0.0).toDouble();
    category = data['category'] ?? '';
    condition = data['condition'] ?? '';
    image = data['image'] ?? '';
    size = data['size'] ?? '';
    timestamp = (data['timestamp'] as Timestamp).toDate();
  }
}