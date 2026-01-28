import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:chiyagaram/responsive/size_config.dart';

class MyOrdersScreen extends StatelessWidget {
  const MyOrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Color(0xFF3E2723),
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "My Orders",
          style: GoogleFonts.philosopher(
            fontSize: 24.sp,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF3E2723),
          ),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          // Background Gradient
          const RepaintBoundary(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFFFFF3E0),
                    Color(0xFFFFECB3),
                    Color(0xFFFBE9E7),
                  ],
                ),
              ),
              child: SizedBox.expand(),
            ),
          ),
          SafeArea(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
              itemCount: 5, // Dummy data count
              itemBuilder: (context, index) {
                return _buildOrderCard(index);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOrderCard(int index) {
    // Dummy Data
    final orderIds = [
      "#ORD-005",
      "#ORD-004",
      "#ORD-003",
      "#ORD-002",
      "#ORD-001",
    ];
    final dates = [
      "Today, 10:30 AM",
      "Yesterday, 5:45 PM",
      "Jan 25, 2:15 PM",
      "Jan 22, 1:00 PM",
      "Jan 20, 11:30 AM",
    ];
    final statuses = [
      "Preparing",
      "Completed",
      "Completed",
      "Cancelled",
      "Completed",
    ];
    final amounts = ["Rs. 450", "Rs. 1200", "Rs. 320", "Rs. 850", "Rs. 150"];
    final items = [
      "2x Masala Chiya, 1x Samosa",
      "4x Coffee, 2x Sandwich",
      "1x Iced Tea",
      "3x Burger, 3x Fries",
      "1x Black Tea",
    ];

    Color statusColor;
    switch (statuses[index]) {
      case "Preparing":
        statusColor = Colors.orange;
        break;
      case "Completed":
        statusColor = Colors.green;
        break;
      case "Cancelled":
        statusColor = Colors.red;
        break;
      default:
        statusColor = Colors.grey;
    }

    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.6),
        borderRadius: BorderRadius.circular(20.w),
        border: Border.all(color: Colors.white, width: 1.w),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF3E2723).withValues(alpha: 0.05),
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
                orderIds[index],
                style: GoogleFonts.outfit(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF3E2723),
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
                  statuses[index],
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
            items[index],
            style: GoogleFonts.outfit(
              fontSize: 14.sp,
              color: const Color(0xFF5D4037),
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: 12.h),
          Divider(color: const Color(0xFF3E2723).withValues(alpha: 0.1)),
          SizedBox(height: 8.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    Iconsax.calendar_1,
                    size: 16.sp,
                    color: const Color(0xFF795548),
                  ),
                  SizedBox(width: 6.w),
                  Text(
                    dates[index],
                    style: GoogleFonts.outfit(
                      fontSize: 13.sp,
                      color: const Color(0xFF795548),
                    ),
                  ),
                ],
              ),
              Text(
                amounts[index],
                style: GoogleFonts.outfit(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF3E2723),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
