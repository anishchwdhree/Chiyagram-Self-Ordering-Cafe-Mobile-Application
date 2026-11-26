import 'package:chiyagaram/responsive/size_config.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:chiyagaram/models/cart_model.dart';
import 'package:chiyagaram/theme/app_colors.dart';
import 'package:chiyagaram/theme/theme_provider.dart';
import 'package:iconsax/iconsax.dart';

import 'package:chiyagaram/services/navigation_provider.dart';

class HookahScreen extends StatelessWidget {
  const HookahScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDark = themeProvider.isDarkMode;
    final textColor = isDark ? Colors.white : const Color(0xFF3E2723);
    final subTextColor = isDark
        ? AppColors.igTextSecondary
        : const Color(0xFF5D4037);

    final List<Map<String, dynamic>> hookahItems = [
      {
        'id': 'classic_hookah',
        'name': 'Classic Hookah',
        'price': 'Rs. 500',
        'image': 'images/huk1.png',
        'description': 'Traditional hookah with classic tobacco blend',
        'color': const Color(0xFF6A4C93),
      },
      {
        'id': 'mint_hookah',
        'name': 'Mint Hookah',
        'price': 'Rs. 550',
        'image': 'images/huk2.png',
        'description': 'Refreshing mint flavor for a cool experience',
        'color': const Color(0xFF1FA774),
      },
      {
        'id': 'grape_hookah',
        'name': 'Grape Hookah',
        'price': 'Rs. 550',
        'image': 'images/huk3.png',
        'description': 'Sweet grape flavor with aromatic smoke',
        'color': const Color(0xFF8E44AD),
      },
      {
        'id': 'double_apple',
        'name': 'Double Apple',
        'price': 'Rs. 600',
        'image': 'images/huk4.png',
        'description': 'Rich double apple flavor, smooth and satisfying',
        'color': const Color(0xFFE74C3C),
      },
    ];

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: isDark
                ? [AppColors.igBlack, AppColors.igDarkGrey, AppColors.igBlack]
                : [
                    const Color(0xFFFFF5E6),
                    const Color(0xFFFFE9CC),
                    const Color(0xFFFFF0D9),
                  ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Header
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: Icon(Icons.arrow_back_ios_new, color: textColor),
                    ),
                    Expanded(
                      child: Text(
                        "Hookah",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.philosopher(
                          fontSize: 22.sp,
                          fontWeight: FontWeight.bold,
                          color: textColor,
                        ),
                      ),
                    ),
                    Consumer<CartModel>(
                      builder: (context, cart, child) {
                        return Stack(
                          children: [
                            IconButton(
                              onPressed: () {
                                Provider.of<NavigationProvider>(
                                  context,
                                  listen: false,
                                ).setIndex(2);
                                Navigator.popUntil(
                                  context,
                                  (route) => route.isFirst,
                                );
                              },
                              icon: Icon(
                                Iconsax.shopping_bag,
                                color: textColor,
                              ),
                            ),
                            if (cart.itemCount > 0)
                              Positioned(
                                right: 8.w,
                                top: 8.h,
                                child: Container(
                                  padding: EdgeInsets.all(4.w),
                                  decoration: const BoxDecoration(
                                    color: Color(0xFFFF6B35),
                                    shape: BoxShape.circle,
                                  ),
                                  constraints: BoxConstraints(
                                    minWidth: 16.w,
                                    minHeight: 16.w,
                                  ),
                                  child: Center(
                                    child: Text(
                                      '${cart.itemCount}',
                                      style: GoogleFonts.outfit(
                                        fontSize: 9.sp,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),
              // Items List
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.w,
                    vertical: 10.h,
                  ),
                  physics: const BouncingScrollPhysics(),
                  itemCount: hookahItems.length,
                  itemBuilder: (context, index) {
                    final item = hookahItems[index];
                    return _buildHookahCard(
                      context,
                      item,
                      isDark,
                      textColor,
                      subTextColor,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHookahCard(
    BuildContext context,
    Map<String, dynamic> item,
    bool isDark,
    Color textColor,
    Color subTextColor,
  ) {
    final color = item['color'] as Color;

    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: isDark
            ? AppColors.igSurface.withValues(alpha: 0.5)
            : const Color(0xFFFFF9F0).withValues(alpha: 0.8),
        borderRadius: BorderRadius.circular(20.w),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: isDark ? 0.2 : 0.05),
            blurRadius: 10.w,
            offset: Offset(0, 4.h),
          ),
        ],
        border: Border.all(
          color: isDark
              ? AppColors.igBorder.withValues(alpha: 0.5)
              : Colors.black.withValues(alpha: 0.05),
        ),
      ),
      child: Row(
        children: [
          // Circular Image
          Container(
            width: 80.w,
            height: 80.w,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: color.withValues(alpha: 0.15),
                  blurRadius: 8.w,
                  offset: Offset(0, 4.h),
                ),
              ],
            ),
            padding: EdgeInsets.all(8.w),
            child: ClipOval(
              child: Image.asset(
                item['image'],
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) =>
                    Icon(Icons.air, size: 40.sp, color: color),
              ),
            ),
          ),
          SizedBox(width: 16.w),
          // Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item['name'],
                  style: GoogleFonts.philosopher(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                    color: textColor,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  item['description'],
                  style: GoogleFonts.outfit(
                    fontSize: 12.sp,
                    color: subTextColor.withValues(alpha: 0.7),
                    height: 1.3,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 8.h),
                Text(
                  item['price'],
                  style: GoogleFonts.outfit(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFFFF6B35),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 12.w),
          // Add Button
          GestureDetector(
            onTap: () => _addToCart(context, item),
            child: Container(
              width: 44.w,
              height: 44.w,
              decoration: BoxDecoration(
                color: isDark ? AppColors.white : AppColors.primary,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.2),
                    blurRadius: 8.w,
                    offset: Offset(0, 4.h),
                  ),
                ],
              ),
              child: Icon(
                Icons.add,
                color: isDark ? Colors.black : Colors.white,
                size: 24.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _addToCart(BuildContext context, Map<String, dynamic> item) {
    final cart = Provider.of<CartModel>(context, listen: false);
    final isDark = Provider.of<ThemeProvider>(
      context,
      listen: false,
    ).isDarkMode;

    cart.addItem(
      productId: item['id'],
      name: item['name'],
      price: item['price'],
      imagePath: item['image'],
      description: item['description'],
      color1: item['color'],
      color2: item['color'],
    );

    // Show success feedback
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(Iconsax.tick_circle, color: Colors.white, size: 20.sp),
            SizedBox(width: 12.w),
            Expanded(
              child: Text(
                '${item['name']} added to cart!',
                style: GoogleFonts.outfit(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
        backgroundColor: isDark ? AppColors.igSurface : AppColors.primary,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.w),
        ),
        margin: EdgeInsets.all(16.w),
        duration: const Duration(seconds: 2),
      ),
    );
  }
}
