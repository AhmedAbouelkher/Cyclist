import 'package:cyclist/models/responses/search_in_products_response.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartRepo {
  Future<List<Product>> getCartItems() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> itemsInString = prefs.getStringList('cart_items');
    List<Product> items = [];
    if (itemsInString != null) {
      itemsInString.forEach((strItem) {
        items.add(productFromJson(strItem));
      });
    }
    return items;
  }

  /// this method will delete all cart items from the prfs
  Future<bool> clearCart() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    bool status = await prefs.remove('cart_items');
    return status;
  }

  /// this method will add item into prfs
  Future<bool> addItemToTheCart({@required Product product}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> itemsList = prefs.getStringList('cart_items');
    bool result;
    if (itemsList == null) {
      result = await prefs.setStringList('cart_items', [productToJson(product)]);
    } else {
      if (itemsList.contains(product)) {
        product.quantity++;
      }
      itemsList.add(productToJson(product));
      result = await prefs.setStringList('cart_items', itemsList);
    }
    return result;
  }

  Future<List<Product>> deleteItemFromTheCart({
    @required Product itemToDelete,
  }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<Product> items = await getCartItems();
    List<String> newList = [];

    for (int i = 0; i < items.length; i++) {
      Product currentItem = items[i];
      final bool sameId = currentItem.id == itemToDelete.id;
      final bool sameCount = currentItem.quantity == itemToDelete.quantity;
      if (sameId && sameCount) {
        print('#Deleted');
      } else {
        newList.add(productToJson(currentItem));
      }
    }

    await prefs.setStringList('cart_items', newList);
    return getCartItems();
  }

  Future<int> itemPlusPlus({@required String productID}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<Product> cartItems = await getCartItems();
    List<String> newList = [];
    int productQuantity;
    cartItems.forEach((product) {
      if (product.id == int.parse(productID)) {
        product.quantity++;
        newList.add(productToJson(product));
        productQuantity = product.quantity;
      } else {
        newList.add(productToJson(product));
      }
    });
    await prefs.setStringList('cart_items', newList);
    return productQuantity;
  }

  Future<int> itemMinMin({@required String productID}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<Product> cartItems = await getCartItems();
    List<String> newList = [];
    int productQuantity;
    cartItems.forEach((product) {
      if (product.id == int.parse(productID)) {
        product.quantity--;
        newList.add(productToJson(product));
        productQuantity = product.quantity;
      } else {
        newList.add(productToJson(product));
      }
    });
    await prefs.setStringList('cart_items', newList);
    return productQuantity;
  }

  Future<double> getCartCost() async {
    List<Product> itemsList = await getCartItems();
    if (itemsList != null && itemsList.isNotEmpty) {
      double totalPrice = 0.0;
      itemsList.forEach((product) {
        totalPrice += double.parse(product.salePrice);
      });
      return totalPrice;
    } else {
      return 0.0;
    }
  }

  // just a getter for cart list items count
  Future<int> getCartItemsCount() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> list = prefs.getStringList('cart_items');
    if (list == null) {
      return 0;
    } else {
      return list.length;
    }
  }
}
