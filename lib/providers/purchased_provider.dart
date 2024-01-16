

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:senior_project/models/purchased.dart';
import 'package:senior_project/service/product_service.dart';

class PurchasedItemsProvider extends ChangeNotifier {
  List<PurchasedItem> _purchasedItems = [];

  List<PurchasedItem> get purchasedItems => _purchasedItems;

  final ProductService productService = ProductService();

  /*
  void addPurchasedItem(PurchasedItem item) {
    _purchasedItems.add(item);
    notifyListeners();
  }*/


  void addPurchasedItem(PurchasedItem item, String userId) {
    _purchasedItems.add(item);
    productService.addOrder(userId, item.toJson()); // Firestore'a siparişi ekle
    notifyListeners();
  }

  Stream<QuerySnapshot<Object?>> getPurchasedItemsStream(String userId) {
    return productService.getOrdersStream(userId);
  }



}