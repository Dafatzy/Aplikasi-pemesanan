import 'package:aplikasi_pemesanan/models/cart_item.dart';
import 'package:flutter/material.dart';

class CartProvider with ChangeNotifier {
  final List<CartItem> _items = [];

  List<CartItem> get items => _items;

  int get itemCount => _items.fold(0, (sum, item) => sum + item.quantity);

  double get totalPrice {
    return _items.fold(0.0, (sum, item) {
      return sum + (double.tryParse(item.price.replaceAll("Rp", "").replaceAll(".", "")) ?? 0) * item.quantity;
    });
  }

  int get totalItems {
    return _items.fold(0, (sum, item) => sum + item.quantity);
  }

  void addToCart(CartItem item) {
    final index = _items.indexWhere((e) => e.name == item.name);
    if (index >= 0) {
      _items[index] = CartItem(
        name: item.name,
        price: item.price,
        imagePath: item.imagePath,
        subtotal: item.subtotal,
        quantity: _items[index].quantity + item.quantity,
      );
    } else {
      _items.add(item);
    }
    notifyListeners();
  }

  void removeFromCart(CartItem item) {
    _items.remove(item);
    notifyListeners();
  }

  void clearCart() {
    _items.clear();
    notifyListeners();
  }
}
