import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartBloc with ChangeNotifier {
  Map<int, int> _cart = {};
  int _cartcount = 0;

  Map<int, int> get cart => _cart;

  void addToCart(index) {
    if (_cart.containsKey(index)) {
      _cart[index] += 1;
    } else {
      _cart[index] = 1;
    }
    notifyListeners();
  }

  void clear(index) {
    if (_cart.containsKey(index)) {
      _cart.remove(index);
      notifyListeners();
    }
  }

  int getcount() {
    return _cartcount;
  }

  void totalCount(count) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    _prefs.setInt('cart_count', count);
    _cartcount = count;
    notifyListeners();
  }

}