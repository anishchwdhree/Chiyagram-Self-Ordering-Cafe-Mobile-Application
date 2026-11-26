import 'package:chiyagaram/screens/widget/background_scaffold.dart';
import 'package:chiyagaram/theme/theme_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:chiyagaram/responsive/size_config.dart';
import 'package:iconsax/iconsax.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  String _selectedFilter = 'All';
  final List<String> _filters = ['All', 'Orders', 'Offers', 'System'];

  bool _isLoading = true;
  List<Map<String, dynamic>> _allNotifications = [];

  @override
  void initState() {
    super.initState();
    _fetchNotifications();
  }

  Future<void> _fetchNotifications() async {
    final prefs = await SharedPreferences.getInstance();
    final myOrders = prefs.getStringList('my_orders') ?? [];

    if (myOrders.isEmpty) {
      if (mounted) setState(() => _isLoading = false);
      return;
    }

    try {
      // Fetch orders. NOTE: whereIn is limited to 10 items.
      // If user has > 10 orders, we might need to batch or just fetch the last 10.
      // For now, let's take the last 10 IDs to avoid errors.
      final idsToFetch = myOrders.length > 10
          ? myOrders.sublist(myOrders.length - 10)
          : myOrders;

      final snapshot = await FirebaseFirestore.instance
          .collection('orders')
          .where('orderId', whereIn: idsToFetch)
          .get();

      List<Map<String, dynamic>> orderItems = [];

      for (var doc in snapshot.docs) {
        final data = doc.data();
        orderItems.add({
          'ids': data['orderId'], // Store ID for deletion
          'title': 'Order ${data['status'].toString().toUpperCase()}',
          'body': 'Order #${data['orderId']} is currently ${data['status']}',
          'time': _formatTimestamp(data['timestamp']),
          'icon': _getIconForStatus(data['status']),
          'color': _getColorForStatus(data['status']),
          'isUnread': data['status'] == 'completed' ? false : true,
          'category': 'Orders',
          'timestamp': data['timestamp'], // for sorting
        });
      }

      // precise sorting
      orderItems.sort((a, b) {
        // Handle null timestamps safely
        if (a['timestamp'] == null) return -1;
        if (b['timestamp'] == null) return 1;

        final tA = (a['timestamp'] as Timestamp).toDate();
        final tB = (b['timestamp'] as Timestamp).toDate();
        return tB.compareTo(tA);
      });

      setState(() {
        _allNotifications = [
          {'date': 'Recent Updates', 'items': orderItems},
        ];
        _isLoading = false;
      });
    } catch (e) {
      debugPrint('Error loading notifications: $e');
      if (mounted) setState(() => _isLoading = false);
    }
  }

  Future<void> _deleteNotification(String orderId) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final myOrders = prefs.getStringList('my_orders') ?? [];

      // Remove the ID from the list
      myOrders.remove(orderId);

      // Save updated list back to SharedPreferences
      await prefs.setStringList('my_orders', myOrders);

      debugPrint('Deleted notification for order: $orderId');
    } catch (e) {
      debugPrint('Error deleting notification: $e');
    }
  }

  IconData _getIconForStatus(String status) {
    switch (status) {
      case 'pending':
        return Iconsax.timer;
      case 'preparing':
        return Iconsax.coffee;
      case 'served':
        return Iconsax.tick_circle;
      case 'completed':
        return Iconsax.clipboard_tick;
      default:
        return Iconsax.notification;
    }
  }

  Color _getColorForStatus(String status) {
    switch (status) {
      case 'pending':
        return Colors.orange;
      case 'preparing':
        return Colors.blue;
      case 'served':
        return Colors.green;
      case 'completed':
        return Colors.grey;
      default:
        return Colors.black;
    }
  }

  String _formatTimestamp(dynamic timestamp) {
    if (timestamp == null) return 'Just now';
    if (timestamp is Timestamp) {
      final now = DateTime.now();
      final date = timestamp.toDate();
      final diff = now.difference(date);
      if (diff.inMinutes < 60) return '${diff.inMinutes} mins ago';
      if (diff.inHours < 24) return '${diff.inHours} hours ago';
      return '${date.day}/${date.month}';
    }
    return '';
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDark = themeProvider.isDarkMode;
    final textColor = isDark ? Colors.white : const Color(0xFF3E2723);
    final cardColor = isDark
        ? const Color(0xFF5D4037).withValues(alpha: 0.4)
        : Colors.white.withValues(alpha: 0.5);

    return BackgroundScaffold(
      body: Column(
        children: [
          SizedBox(height: MediaQuery.of(context).padding.top),
          // Custom App Bar
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
            child: Row(
              children: [
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: Icon(
                    Icons.arrow_back_ios_new,
                    color: textColor,
                    size: 20.sp,
                  ),
                ),
                Expanded(
                  child: Text(
                    "Notifications",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.philosopher(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.bold,
                      color: textColor,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Iconsax.tick_circle,
                    color: textColor,
                    size: 24.sp,
                  ),
                  tooltip: "Mark all as read",
                ),
              ],
            ),
          ),
          // 1. Category Filters
          SizedBox(height: 10.h),
          SizedBox(
            height: 40.h,
            child: ListView.separated(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              scrollDirection: Axis.horizontal,
              itemCount: _filters.length,
              separatorBuilder: (context, index) => SizedBox(width: 10.w),
              itemBuilder: (context, index) {
                final filter = _filters[index];
                final isSelected = _selectedFilter == filter;
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedFilter = filter;
                    });
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? (isDark ? Colors.white : const Color(0xFF3E2723))
                          : cardColor,
                      borderRadius: BorderRadius.circular(20.w),
                      border: Border.all(
                        color: isSelected
                            ? Colors.transparent
                            : textColor.withValues(alpha: 0.1),
                      ),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      filter,
                      style: GoogleFonts.outfit(
                        fontSize: 14.sp,
                        fontWeight: isSelected
                            ? FontWeight.w600
                            : FontWeight.normal,
                        color: isSelected
                            ? (isDark ? Colors.black : Colors.white)
                            : textColor,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          SizedBox(height: 20.h),

          // 2. Notification List
          Expanded(
            child: _isLoading
                ? Center(child: CircularProgressIndicator(color: textColor))
                : _buildGroupedList(isDark, textColor, cardColor),
          ),
        ],
      ),
    );
  }

  Widget _buildGroupedList(bool isDark, Color textColor, Color cardColor) {
    List<Widget> listWidgets = [];

    for (var i = 0; i < _allNotifications.length; i++) {
      final group = _allNotifications[i];
      final date = group['date'];
      final items = group['items'] as List<Map<String, dynamic>>;

      var filteredItems = items.where((item) {
        if (_selectedFilter == 'All') return true;
        return item['category'] == _selectedFilter;
      }).toList();

      if (filteredItems.isNotEmpty) {
        listWidgets.add(
          Padding(
            padding: EdgeInsets.fromLTRB(20.w, 0, 20.w, 10.h),
            child: Text(
              date,
              style: GoogleFonts.outfit(
                fontSize: 14.sp,
                fontWeight: FontWeight.bold,
                color: isDark ? Colors.white70 : const Color(0xFF795548),
                letterSpacing: 0.5,
              ),
            ),
          ),
        );

        for (var j = 0; j < filteredItems.length; j++) {
          listWidgets.add(
            Padding(
              padding: EdgeInsets.fromLTRB(20.w, 0, 20.w, 16.h),
              child: _buildNotificationItem(
                filteredItems[j],
                isDark,
                textColor,
                cardColor,
                () {
                  // Remove from UI immediately
                  setState(() {
                    // Find the original list and remove the item
                    items.remove(filteredItems[j]);
                    if (items.isEmpty) {
                      _allNotifications.removeAt(i);
                    }
                  });
                  // Delete from storage
                  _deleteNotification(filteredItems[j]['ids']);
                },
              ),
            ),
          );
        }
      }
    }

    if (listWidgets.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Iconsax.notification_status,
              size: 64.sp,
              color: textColor.withValues(alpha: 0.3),
            ),
            SizedBox(height: 10.h),
            Text(
              "No notifications found",
              style: GoogleFonts.outfit(
                fontSize: 16.sp,
                color: textColor.withValues(alpha: 0.5),
              ),
            ),
          ],
        ),
      );
    }

    return AnimationLimiter(
      child: ListView.builder(
        padding: EdgeInsets.only(bottom: 20.h),
        itemCount: listWidgets.length,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          return AnimationConfiguration.staggeredList(
            position: index,
            duration: const Duration(milliseconds: 500),
            child: SlideAnimation(
              verticalOffset: 50.0,
              child: FadeInAnimation(child: listWidgets[index]),
            ),
          );
        },
      ),
    );
  }

  Widget _buildNotificationItem(
    Map<String, dynamic> data,
    bool isDark,
    Color textColor,
    Color cardColor,
    VoidCallback onDismiss,
  ) {
    return Dismissible(
      key: Key(data['ids'].toString()), // Unique Key based on ID
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        onDismiss();
      },
      background: Container(
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 20.w),
        decoration: BoxDecoration(
          color: Colors.redAccent.withValues(alpha: 0.8),
          borderRadius: BorderRadius.circular(20.w),
        ),
        child: Icon(Iconsax.trash, color: Colors.white, size: 24.sp),
      ),
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: data['isUnread']
              ? (isDark
                    ? Colors.white.withValues(alpha: 0.15)
                    : Colors.white.withValues(alpha: 0.95))
              : cardColor,
          borderRadius: BorderRadius.circular(20.w),
          border: Border.all(
            color: textColor.withValues(alpha: 0.1),
            width: 1.w,
          ),
          boxShadow: [
            BoxShadow(
              color: textColor.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(10.w),
              decoration: BoxDecoration(
                color: (data['color'] as Color).withValues(alpha: 0.15),
                shape: BoxShape.circle,
              ),
              child: Icon(
                data['icon'] as IconData,
                color: data['color'] as Color,
                size: 22.sp,
              ),
            ),
            SizedBox(width: 14.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        data['title'],
                        style: GoogleFonts.outfit(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          color: textColor,
                        ),
                      ),
                      Text(
                        data['time'],
                        style: GoogleFonts.outfit(
                          fontSize: 11.sp,
                          color: isDark
                              ? Colors.white54
                              : const Color(0xFF795548).withValues(alpha: 0.7),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    data['body'],
                    style: GoogleFonts.outfit(
                      fontSize: 13.sp,
                      color: isDark
                          ? Colors.white70
                          : const Color(0xFF5D4037).withValues(alpha: 0.9),
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
            if (data['isUnread'])
              Padding(
                padding: EdgeInsets.only(left: 8.w, top: 4.h),
                child: CircleAvatar(
                  radius: 4.w,
                  backgroundColor: const Color(0xFFE91E63),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
