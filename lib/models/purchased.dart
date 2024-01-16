

import 'package:cloud_firestore/cloud_firestore.dart';

class PurchasedItem {
  final String title;
  final String category;
  final double price;

  final String image;

  PurchasedItem({
    required this.title,
    required this.category,
    required this.price,
    required this.image,
  });

  static PurchasedItem fromJson(Map<String, dynamic> data) {
    return PurchasedItem(
      title: data["title"],
      category: data["category"],
      price: data["price"],
      image: data["image"],
    );
  }

  Map<String, dynamic> toJson() => {
    "title": title,
    "category": category,
    "price": price,
    "image": image,
  };
}