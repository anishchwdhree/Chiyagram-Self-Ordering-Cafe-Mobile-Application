import 'package:chiyagaram/responsive/size_config.dart';
import 'package:chiyagaram/screens/widget/background_scaffold.dart';
import 'package:chiyagaram/theme/app_colors.dart';
import 'package:chiyagaram/theme/theme_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

class MyOrdersScreen extends StatefulWidget {
  const MyOrdersScreen({super.key});

  @override
  State<MyOrdersScreen> createState() => _MyOrdersScreenState();
}

class _MyOrdersScreenState extends State<MyOrdersScreen> {
  bool _isLoading = true;
  List<Map<String, dynamic>> _orders = [];

  @override
  void initState() {
    super.initState();
    _fetchOrders();
  }

  Future<void> _fetchOrders() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final myOrders = prefs.getStringList('my_orders') ?? [];

      if (myOrders.isEmpty) {
        if (mounted) {
          setState(() {
            _isLoading = false;
            _orders = [];
          });
        }
        return;
      }

      // Fetch orders. Limit to last 10 to avoid whereIn limit error
      final idsToFetch = myOrders.length > 10
          ? myOrders.sublist(myOrders.length - 10)
          : myOrders;

      final snapshot = await FirebaseFirestore.instance
          .collection('orders')
          .where('orderId', whereIn: idsToFetch)
          .get();

      List<Map<String, dynamic>> fetchedOrders = [];

      for (var doc in snapshot.docs) {
        final data = doc.data();

        // Items string formatting
        String itemsText = "";
        if (data['items'] is List) {
          final itemsList = data['items'] as List;
          itemsText = itemsList
              .map((item) {
                final name = item['name'] ?? 'Item';
                final qty = item['quantity'] ?? 1;
                return "${qty}x $name";
              })
              .join(", ");
        }

        fetchedOrders.add({
          'id': data['orderId'],
          'status': data['status'] ?? 'pending',
          'total': 'Rs. ${data['total'] ?? 0}',
          'timestamp': data['timestamp'],
          'items': itemsText,
        });
      }

      // Sort by timestamp descending
      fetchedOrders.sort((a, b) {
        if (a['timestamp'] == null) return -1;
        if (b['timestamp'] == null) return 1;
        final tA = (a['timestamp'] as Timestamp).toDate();
        final tB = (b['timestamp'] as Timestamp).toDate();
        return tB.compareTo(tA);
      });

      if (mounted) {
        setState(() {
          _orders = fetchedOrders;
          _isLoading = false;
        });
      }
    } catch (e) {
      debugPrint("Error fetching orders: $e");
      if (mounted) setState(() => _isLoading = false);
    }
  }

  String _formatDate(dynamic timestamp) {
    if (timestamp == null) return "";
    if (timestamp is Timestamp) {
      return DateFormat('MMM d, h:mm a').format(timestamp.toDate());
    }
    return "";
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDark = themeProvider.isDarkMode;
    final textColor = isDark ? Colors.white : const Color(0xFF3E2723);

    return BackgroundScaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_rounded, color: textColor),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "My Orders",
          style: GoogleFonts.philosopher(
            fontSize: 24.sp,
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
        ),
        centerTitle: true,
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator(color: textColor))
          : _orders.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Iconsax.bag_2,
                    size: 64.sp,
                    color: textColor.withValues(alpha: 0.3),
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    "No recent orders",
                    style: GoogleFonts.outfit(
                      fontSize: 18.sp,
                      color: textColor.withValues(alpha: 0.6),
                    ),
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 20.w).copyWith(
                top: MediaQuery.of(context).padding.top + kToolbarHeight + 20.h,
                bottom: 20.h + MediaQuery.of(context).padding.bottom,
              ),
              itemCount: _orders.length,
              itemBuilder: (context, index) {
                return _buildOrderCard(_orders[index], isDark, textColor);
              },
            ),
    );
  }

  Widget _buildOrderCard(
    Map<String, dynamic> order,
    bool isDark,
    Color textColor,
  ) {
    Color statusColor;
    String status = order['status'].toString().toLowerCase();

    switch (status) {
      case "preparing":
        statusColor = Colors.orange;
        break;
      case "served":
      case "completed":
        statusColor = Colors.green;
        break;
      case "cancelled":
        statusColor = Colors.red;
        break;
      default:
        statusColor = Colors.grey;
    }

    String displayStatus = status[0].toUpperCase() + status.substring(1);

    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: isDark
            ? AppColors.igSurface
            : Colors.white.withValues(alpha: 0.6),
        borderRadius: BorderRadius.circular(20.w),
        border: Border.all(
          color: isDark ? AppColors.igBorder : Colors.white,
          width: 1.w,
        ),
        boxShadow: [
          BoxShadow(
            color: (isDark ? Colors.black : const Color(0xFF3E2723)).withValues(
              alpha: 0.05,
            ),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "#${order['id']}",
                style: GoogleFonts.outfit(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  color: textColor,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: statusColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12.w),
                  border: Border.all(color: statusColor.withValues(alpha: 0.3)),
                ),
                child: Text(
                  displayStatus,
                  style: GoogleFonts.outfit(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                    color: statusColor,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          Text(
            order['items'],
            style: GoogleFonts.outfit(
              fontSize: 14.sp,
              color: isDark
                  ? AppColors.igTextSecondary
                  : const Color(0xFF5D4037),
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: 12.h),
          Divider(color: textColor.withValues(alpha: 0.1)),
          SizedBox(height: 8.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    Iconsax.calendar_1,
                    size: 16.sp,
                    color: isDark
                        ? AppColors.igTextSecondary
                        : const Color(0xFF795548),
                  ),
                  SizedBox(width: 6.w),
                  Text(
                    _formatDate(order['timestamp']),
                    style: GoogleFonts.outfit(
                      fontSize: 13.sp,
                      color: isDark
                          ? AppColors.igTextSecondary
                          : const Color(0xFF795548),
                    ),
                  ),
                ],
              ),
              Text(
                order['total'],
                style: GoogleFonts.outfit(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  color: textColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
