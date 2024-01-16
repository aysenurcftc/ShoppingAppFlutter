



import 'package:flutter/material.dart';
import 'package:senior_project/service/product_service.dart';

import '../models/products.dart';

class ProductProvider extends ChangeNotifier {

  final ProductService _productService = ProductService();
  List<Product> _products = [];

  List<Product> get products => _products;

  // Fetch products and notify listeners
  Future<void> fetchProducts() async {
    _products = await _productService.getAllUsersProducts();
    notifyListeners();
  }




}