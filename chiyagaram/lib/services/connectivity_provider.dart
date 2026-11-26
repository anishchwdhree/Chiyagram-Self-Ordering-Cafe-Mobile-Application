import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

class ConnectivityProvider extends ChangeNotifier {
  bool _isOnline = true;
  bool get isOnline => _isOnline;

  late StreamSubscription<List<ConnectivityResult>> _subscription;

  ConnectivityProvider() {
    _checkInitialStatus();
    _subscription = Connectivity().onConnectivityChanged.listen((
      List<ConnectivityResult> results,
    ) {
      _updateConnectionStatus(results);
    });
  }

  Future<void> _checkInitialStatus() async {
    try {
      final results = await Connectivity().checkConnectivity();
      _updateConnectionStatus(results);
    } catch (e) {
      debugPrint("Error checking connectivity: $e");
    }
  }

  void _updateConnectionStatus(List<ConnectivityResult> results) {
    // If any connection is active (mobile, wifi, ethernet, etc.), we consider it online.
    // connectivity_plus v6.x returns a List<ConnectivityResult>.
    final bool currentlyOnline = results.any(
      (result) => result != ConnectivityResult.none,
    );

    if (_isOnline != currentlyOnline) {
      _isOnline = currentlyOnline;
      notifyListeners();
    }
  }

  Future<void> retryConnection() async {
    await _checkInitialStatus();
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
