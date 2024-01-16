import 'package:flutter/material.dart';
import 'package:senior_project/models/basket_product.dart';


class BasketProvider extends ChangeNotifier {
  List<basketProduct> _basketItems = [];

  List<basketProduct> get basketItems => _basketItems;

  void addToBasket(basketProduct product) {
    _basketItems.add(product);
    notifyListeners();
  }

  void removeFromBasket(int index) {
    _basketItems.removeAt(index);
    notifyListeners();
  }




}