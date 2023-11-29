import 'package:cloud_firestore/cloud_firestore.dart';



class Product {
  late String title;
  late String description;
  late double price;
  late String category;
  late String condition;
  late String image;
  late DateTime timestamp;

  // Constructor
  Product({
    required this.title,
    required this.description,
    required this.price,
    required this.category,
    required this.condition,
    required this.image,
    required this.timestamp,
  });

  // Named constructor to create a Product instance from a Map
  Product.fromMap(Map<String, dynamic> data) {
    title = data['title'] ?? '';
    description = data['description'] ?? '';
    price = (data['price'] ?? 0.0).toDouble();
    category = data['category'] ?? '';
    condition = data['condition'] ?? '';
    image = data['image'] ?? '';
    timestamp = (data['timestamp'] as Timestamp).toDate();
  }
}