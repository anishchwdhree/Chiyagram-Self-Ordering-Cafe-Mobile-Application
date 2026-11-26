import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'notification_service.dart';

class NotificationProvider extends ChangeNotifier {
  int _unreadCount = 0;
  int get unreadCount => _unreadCount;

  final List<StreamSubscription> _subscriptions = [];
  final List<String> _activeOrderIds = [];

  NotificationProvider() {
    _init();
  }

  Future<void> _init() async {
    final prefs = await SharedPreferences.getInstance();
    final myOrders = prefs.getStringList('my_orders') ?? [];

    // In a real app, we might filter out old filled orders here
    // For now, listen to the last 5 to save resources
    final recentOrders = myOrders.length > 5
        ? myOrders.sublist(myOrders.length - 5)
        : myOrders;

    for (var orderId in recentOrders) {
      debugPrint('NotificationProvider: Listening to existing order $orderId');
      _listenToOrder(orderId);
    }
  }

  void addActiveOrder(String orderId) {
    debugPrint('NotificationProvider: Adding active order $orderId');
    if (!_activeOrderIds.contains(orderId)) {
      _listenToOrder(orderId);
    }
  }

  void markAllRead() {
    _unreadCount = 0;
    notifyListeners();
  }

  void _listenToOrder(String orderId) {
    _activeOrderIds.add(orderId);

    final sub = FirebaseFirestore.instance
        .collection('orders')
        .doc(orderId)
        .snapshots()
        .listen((snapshot) {
          if (snapshot.exists) {
            final data = snapshot.data();
            if (data != null && data.containsKey('status')) {
              _handleStatusChange(orderId, data['status']);
            }
          }
        });

    _subscriptions.add(sub);
  }

  // Track last known status to avoid duplicates if needed
  // For simplicity, we assume every update that comes in via stream *might* be actionable
  // Ideally we'd store local state of 'lastStatus' to compare.
  final Map<String, String> _lastKnownStatus = {};

  void _handleStatusChange(String orderId, String newStatus) {
    final oldStatus = _lastKnownStatus[orderId];

    // Only notify if status CHANGED
    if (oldStatus != newStatus) {
      debugPrint(
        'NotificationProvider: Status change for $orderId: $oldStatus -> $newStatus',
      );
      _lastKnownStatus[orderId] = newStatus;

      // Don't notify on initial load of 'pending'
      if (oldStatus == null && newStatus == 'pending') return;

      // Increment badge
      _unreadCount++;
      notifyListeners();

      // Trigger Push Notification
      _showPushNotification(orderId, newStatus);
    }
  }

  void _showPushNotification(String orderId, String status) {
    String title = '';
    String body = '';

    switch (status) {
      case 'preparing':
        title = 'Order Preparing';
        body = 'Your order #$orderId is being prepared.';
        break;
      case 'served':
        title = 'Order Served';
        body = 'Your order #$orderId has been served! Enjoy.';
        break;
      case 'completed':
        title = 'Order Completed';
        body = 'Thank you for visiting Chiya Ki Tapari.';
        break;
    }

    if (title.isNotEmpty) {
      NotificationService().showNotification(
        id: orderId.hashCode,
        title: title,
        body: body,
      );
    }
  }

  @override
  void dispose() {
    for (var sub in _subscriptions) {
      sub.cancel();
    }
    super.dispose();
  }
}
