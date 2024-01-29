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

  void clearBasket() {
    _basketItems.clear();
    notifyListeners();
  }

  void incrementItemCount(int index) {
    if (index >= 0 && index < _basketItems.length) {
      _basketItems[index].count++;
      notifyListeners();
    }
  }


  void decrementItemCount(int index) {
    if (index >= 0 && index < _basketItems.length) {
      if (_basketItems[index].count > 1) {
        _basketItems[index].count--;
        notifyListeners();
      }
    }
  }



}