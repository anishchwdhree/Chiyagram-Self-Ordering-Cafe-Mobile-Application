import 'package:chiyagaram/screens/widget/background_scaffold.dart';
import 'package:chiyagaram/theme/theme_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:chiyagaram/responsive/size_config.dart';
import 'package:iconsax/iconsax.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  String _selectedFilter = 'All';
  final List<String> _filters = ['All', 'Orders', 'Offers', 'System'];

  final List<Map<String, dynamic>> _allNotifications = [
    {
      'date': 'Today',
      'items': [
        {
          'title': 'Order Accepted',
          'body': 'Your order has been accepted.',
          'time': '2 mins ago',
          'icon': Iconsax.clipboard_tick,
          'color': const Color(0xFF4CAF50), // Green
          'isUnread': true,
          'category': 'Orders',
        },
        {
          'title': 'Order Ready',
          'body': 'Your Masala Chiya is ready to serve!',
          'time': '15 mins ago',
          'icon': Iconsax.coffee,
          'color': const Color(0xFFFF9800), // Orange
          'isUnread': true,
          'category': 'Orders',
        },
        {
          'title': 'Flash Sale!',
          'body': 'Get 50% off on secondary snacks.',
          'time': '1 hour ago',
          'icon': Iconsax.discount_shape,
          'color': const Color(0xFFE91E63), // Pink
          'isUnread': false,
          'category': 'Offers',
        },
      ],
    },
    {
      'date': 'Yesterday',
      'items': [
        {
          'title': 'System Maintenance',
          'body': 'App scheduled for maintenance at 2 AM.',
          'time': 'Yesterday',
          'icon': Iconsax.setting_2,
          'color': const Color(0xFF607D8B), // Blue Grey
          'isUnread': false,
          'category': 'System',
        },
      ],
    },
  ];

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDark = themeProvider.isDarkMode;
    final textColor = isDark ? Colors.white : const Color(0xFF3E2723);
    final cardColor = isDark
        ? const Color(0xFF5D4037).withValues(alpha: 0.4)
        : Colors.white.withValues(alpha: 0.5);

    return BackgroundScaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: textColor, size: 20.sp),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "Notifications",
          style: GoogleFonts.philosopher(
            fontSize: 24.sp,
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Iconsax.tick_circle, color: textColor, size: 24.sp),
            tooltip: "Mark all as read",
          ),
          SizedBox(width: 10.w),
        ],
      ),
      body: Column(
        children: [
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
          Expanded(child: _buildGroupedList(isDark, textColor, cardColor)),
        ],
      ),
    );
  }

  Widget _buildGroupedList(bool isDark, Color textColor, Color cardColor) {
    List<Widget> listWidgets = [];

    for (var group in _allNotifications) {
      String date = group['date'];
      List<Map<String, dynamic>> items = group['items'];

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

        for (var i = 0; i < filteredItems.length; i++) {
          listWidgets.add(
            Padding(
              padding: EdgeInsets.fromLTRB(20.w, 0, 20.w, 16.h),
              child: _buildNotificationItem(
                filteredItems[i],
                isDark,
                textColor,
                cardColor,
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
  ) {
    return Dismissible(
      key: UniqueKey(),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        // Handle delete
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
