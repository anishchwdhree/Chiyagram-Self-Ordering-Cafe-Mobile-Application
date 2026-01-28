import 'package:flutter/material.dart';

class CartItem {
  final String id;
  final String name;
  final String price;
  final String imagePath;
  final String description;
  final Color color1;
  final Color color2;
  int quantity;

  CartItem({
    required this.id,
    required this.name,
    required this.price,
    required this.imagePath,
    required this.description,
    required this.color1,
    required this.color2,
    this.quantity = 1,
  });
}

class CartModel extends ChangeNotifier {
  final Map<String, CartItem> _items = {};

  Map<String, CartItem> get items {
    return {..._items};
  }

  int get itemCount {
    return _items.length;
  }

  double get subTotal {
    var total = 0.0;
    _items.forEach((key, cartItem) {
      String priceString = cartItem.price.replaceAll(RegExp(r'[^0-9]'), '');
      double price = double.tryParse(priceString) ?? 0.0;
      total += price * cartItem.quantity;
    });
    return total;
  }

  // double get taxAmount => subTotal * 0.10; // Removed as per request
  double get servingFee => 0.0; // Fixed Serving Fee (Free)
  double get grandTotal => subTotal + servingFee;

  // Keep for backward compatibility if used elsewhere, but alias to subTotal or grandTotal?
  // The previous UI used 'totalAmount' as the final price, but now we have a breakdown.
  // Let's keep it as subTotal for now to avoid breaking other things, or update usage.
  double get totalAmount => subTotal;

  void addItem({
    required String productId,
    required String name,
    required String price,
    required String imagePath,
    required String description,
    required Color color1,
    required Color color2,
  }) {
    if (_items.containsKey(productId)) {
      // update quantity...
      _items.update(
        productId,
        (existingCartItem) => CartItem(
          id: existingCartItem.id,
          name: existingCartItem.name,
          price: existingCartItem.price,
          imagePath: existingCartItem.imagePath,
          description: existingCartItem.description,
          color1: existingCartItem.color1,
          color2: existingCartItem.color2,
          quantity: existingCartItem.quantity + 1,
        ),
      );
    } else {
      _items.putIfAbsent(
        productId,
        () => CartItem(
          id: productId,
          name: name,
          price: price,
          imagePath: imagePath,
          description: description,
          color1: color1,
          color2: color2,
          quantity: 1,
        ),
      );
    }
    notifyListeners();
  }

  void removeItem(String productId) {
    _items.remove(productId);
    notifyListeners();
  }

  void removeSingleItem(String productId) {
    if (!_items.containsKey(productId)) {
      return;
    }
    if (_items[productId]!.quantity > 1) {
      _items.update(
        productId,
        (existingCartItem) => CartItem(
          id: existingCartItem.id,
          name: existingCartItem.name,
          price: existingCartItem.price,
          imagePath: existingCartItem.imagePath,
          description: existingCartItem.description,
          color1: existingCartItem.color1,
          color2: existingCartItem.color2,
          quantity: existingCartItem.quantity - 1,
        ),
      );
    } else {
      _items.remove(productId);
    }
    notifyListeners();
  }

  void clear() {
    _items.clear();
    notifyListeners();
  }

  // Aliases for compatibility
  double get totalPrice => grandTotal;
  void clearCart() => clear();
}
