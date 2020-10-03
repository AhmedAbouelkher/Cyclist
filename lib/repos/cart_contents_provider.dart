import 'package:flutter/cupertino.dart';
import 'package:cyclist/repos/cart_repo.dart';

class CartItemsProvider extends ChangeNotifier {
  int _cartCount;

  int get cartCount => _cartCount;
  CartRepo _cartRepo;
  CartItemsProvider() {
    if (_cartRepo == null) _cartRepo = CartRepo();
  }

  Future<void> getCarCount() async {
    _cartCount = await _cartRepo.getCartItemsCount();
    if (_cartCount == 0) _cartCount = null;
    notifyListeners();
  }
}
