



import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:senior_project/service/product_service.dart';

import '../models/products.dart';

class ProductProvider extends ChangeNotifier {

  User? _user;
  List<String> _likedProductIds = [];

  final ProductService _productService = ProductService();
  List<Product> _products = [];

  List<Product> get products => _products;

  // Fetch products and notify listeners
  Future<void> fetchProducts() async {
    _products = await _productService.getAllUsersProducts();
    notifyListeners();
  }

  void addToLikedProducts(String productId) {
    if (!_likedProductIds.contains(productId)) {
      _likedProductIds.add(productId);
      notifyListeners();
    }
  }

  void removeFromLikedProducts(String productId) {
    _likedProductIds.remove(productId);
    notifyListeners();
  }

  List<String> get likedProductIds => _likedProductIds;




}