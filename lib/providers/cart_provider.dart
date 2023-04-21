import 'package:flutter/material.dart';

class CartItem {
  final int id;
  final String image;
  final String name;
  final int price;
  final int quantity;

  CartItem(this.id, this.image, this.name, this.price, this.quantity);
}

class CartProvider extends ChangeNotifier {
  Map<int, CartItem> items = {};

  void addCart(
      int productId, String image, String name, int price, int quantity) {
    if (items.containsKey(productId)) {
      items.update(
        productId,
        (value) =>
            CartItem(productId, image, name, price, value.quantity + quantity),
      );
    }
    items.putIfAbsent(
      productId,
      () => CartItem(productId, image, name, price, quantity),
    );
    notifyListeners();
    print(items[productId]?.quantity.toString());
  }

  void increase(int productId) {
    items.update(productId, (value) {
      return CartItem(
          value.id, value.image, value.name, value.price, value.quantity + 1);
    });
    notifyListeners();
  }

  void decrease(int productId) {
    if (items[productId]!.quantity == 1) {
      items.removeWhere((key, value) => key == productId);
    } else {
      items.update(
          productId,
          (value) => CartItem(value.id, value.image, value.name, value.price,
              value.quantity - 1));
    }

    notifyListeners();
  }

  void removeCart() {
    items = {};
    notifyListeners();
  }
}
