import 'package:chiyagaram/responsive/size_config.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:chiyagaram/models/cart_model.dart';
import 'package:iconsax/iconsax.dart';

class TraditionalChiyaScreen extends StatelessWidget {
  const TraditionalChiyaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> chiyaItems = [
      {
        'id': 'masala_chiya',
        'name': 'Masala Chiya',
        'price': 'Rs. 60',
        'image': 'images/masal.png',
        'description':
            'A rich, aromatic blend of tea leaves simmered with exotic spi...',
        'color': const Color(0xFFD84315),
      },
      {
        'id': 'black_tea',
        'name': 'Black Tea',
        'price': 'Rs. 40',
        'image': 'images/black.png',
        'description':
            'Classic strong black tea, perfect for a refreshing start to your day.',
        'color': const Color(0xFF4E342E),
      },
      {
        'id': 'lemon_tea',
        'name': 'Lemon Tea',
        'price': 'Rs. 45',
        'image': 'images/leamon.png',
        'description':
            'Refreshing tea with a zesty hint of lemon, a perfect pick-me-up.',
        'color': const Color(0xFFF57C00),
      },
      {
        'id': 'milk_tea',
        'name': 'Milk Tea',
        'price': 'Rs. 50',
        'image': 'images/chiya.png',
        'description':
            'Creamy and smooth milk tea, a comforting classic for any time.',
        'color': const Color(0xFF6D4C41),
      },
    ];

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFFFF5E6), Color(0xFFFFE9CC), Color(0xFFFFF0D9)],
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
                      icon: const Icon(
                        Icons.arrow_back_ios_new,
                        color: Color(0xFF3E2723),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        "Traditional Chiya",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.philosopher(
                          fontSize: 22.sp,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF3E2723),
                        ),
                      ),
                    ),
                    Consumer<CartModel>(
                      builder: (context, cart, child) {
                        return Stack(
                          children: [
                            IconButton(
                              onPressed: () {
                                // Navigate to cart if needed
                              },
                              icon: const Icon(
                                Iconsax.shopping_bag,
                                color: Color(0xFF3E2723),
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
                  itemCount: chiyaItems.length,
                  itemBuilder: (context, index) {
                    final item = chiyaItems[index];
                    return _buildChiyaCard(context, item);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildChiyaCard(BuildContext context, Map<String, dynamic> item) {
    final color = item['color'] as Color;

    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF9F0).withValues(alpha: 0.8),
        borderRadius: BorderRadius.circular(20.w),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10.w,
            offset: Offset(0, 4.h),
          ),
        ],
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
                    Icon(Icons.local_cafe, size: 40.sp, color: color),
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
                    color: const Color(0xFF3E2723),
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  item['description'],
                  style: GoogleFonts.outfit(
                    fontSize: 12.sp,
                    color: const Color(0xFF5D4037).withValues(alpha: 0.7),
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
                color: const Color(0xFF3E2723),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.2),
                    blurRadius: 8.w,
                    offset: Offset(0, 4.h),
                  ),
                ],
              ),
              child: Icon(Icons.add, color: Colors.white, size: 24.sp),
            ),
          ),
        ],
      ),
    );
  }

  void _addToCart(BuildContext context, Map<String, dynamic> item) {
    final cart = Provider.of<CartModel>(context, listen: false);

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
                ),
              ),
            ),
          ],
        ),
        backgroundColor: const Color(0xFF3E2723),
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
