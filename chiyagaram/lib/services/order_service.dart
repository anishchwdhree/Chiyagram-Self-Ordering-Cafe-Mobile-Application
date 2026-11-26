import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/cart_model.dart';

class OrderService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> placeOrder({
    required int tableNumber,
    required List<CartItem> items,
    required double totalAmount,
  }) async {
    try {
      final orderId = 'ORD-${DateTime.now().millisecondsSinceEpoch}';

      await _firestore.collection('orders').doc(orderId).set({
        'orderId': orderId,
        'tableNumber': tableNumber,
        'items': items
            .map(
              (item) => {
                'id': item.id,
                'name': item.name,
                'price': item.price,
                'imagePath': item.imagePath,
                'quantity': item.quantity,
                'color1': item.color1.toARGB32(),
                'color2': item.color2.toARGB32(),
                'description': item.description,
              },
            )
            .toList(),
        'total': totalAmount,
        'status': 'pending', // OrderStatus.pending
        'userId': FirebaseAuth.instance.currentUser?.uid,
        'timestamp': FieldValue.serverTimestamp(),
      });

      // Save Order ID locally for history/notifications
      final prefs = await SharedPreferences.getInstance();
      final List<String> myOrders = prefs.getStringList('my_orders') ?? [];
      myOrders.add(orderId);
      await prefs.setStringList('my_orders', myOrders);

      // Return orderId so UI can register it with Provider
      return orderId;
    } catch (e) {
      debugPrint('Error placing order: $e');
      rethrow;
    }
  }
}
