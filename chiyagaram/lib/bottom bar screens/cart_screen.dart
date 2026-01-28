import 'dart:ui';
import 'package:chiyagaram/screens/checkout_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:chiyagaram/models/cart_model.dart';
import 'package:chiyagaram/responsive/size_config.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:lottie/lottie.dart';
import 'package:iconsax/iconsax.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context); // Ensure SizeConfig is initialized
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          "My Order",
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
          // 1. Background Gradient
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

          // 2. Decorative Background Circles
          Positioned(
            top: -50.w, // W-based
            right: -50.w,
            child: Container(
              width: 200.w,
              height: 200.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFFFFCCBC).withValues(alpha: 0.4),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFFFFCCBC).withValues(alpha: 0.2),
                    blurRadius: 50.w,
                    spreadRadius: 10.w,
                  ),
                ],
              ),
            ),
          ),

          // 3. Cart Content
          SafeArea(
            child: Consumer<CartModel>(
              builder: (context, cart, child) {
                if (cart.items.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Lottie.asset(
                          'images/Cart.json',
                          height: 250.h,
                          fit: BoxFit.contain,
                        ),
                        SizedBox(height: 16.h),
                        Text(
                          "Your cart is empty",
                          style: GoogleFonts.outfit(
                            fontSize: 18.sp,
                            color: const Color(0xFF8D6E63),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  );
                }

                return Column(
                  children: [
                    Expanded(
                      child: AnimationLimiter(
                        child: ListView.builder(
                          padding: EdgeInsets.symmetric(
                            horizontal: 20.w,
                            vertical: 10.h,
                          ),
                          physics: const BouncingScrollPhysics(),
                          itemCount: cart.items.length,
                          itemBuilder: (context, index) {
                            String key = cart.items.keys.elementAt(index);
                            CartItem item = cart.items[key]!;
                            return AnimationConfiguration.staggeredList(
                              position: index,
                              duration: const Duration(milliseconds: 500),
                              child: SlideAnimation(
                                verticalOffset: 50.h,
                                child: FadeInAnimation(
                                  child: _buildCartItem(context, item, cart),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    // Total and Checkout
                    Padding(
                      padding: EdgeInsets.only(bottom: 100.w), // Lifted up
                      child: _buildCheckoutSection(context, cart),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCartItem(BuildContext context, CartItem item, CartModel cart) {
    return Container(
      margin: EdgeInsets.only(bottom: 8.w), // Ultra Reduced gap
      // Removed fixed height: 130.h
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.centerLeft,
        children: [
          // Glassmorphic Card
          Container(
            margin: EdgeInsets.only(left: 0), // Base container
            constraints: BoxConstraints(
              minHeight: 85.w,
            ), // Ultra Reduced height
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24.w),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  item.color1.withValues(alpha: 0.15),
                  item.color2.withValues(alpha: 0.05),
                ],
              ),
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.6),
                width: 1.5.w,
              ),
              boxShadow: [
                BoxShadow(
                  color: item.color1.withValues(alpha: 0.1),
                  blurRadius: 20.w,
                  offset: Offset(0, 8.w), // W-based offset
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(24.w),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                child: Padding(
                  // Reduced padding: left adjusted for smaller image
                  padding: EdgeInsets.fromLTRB(80.w, 10.w, 12.w, 10.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    // mainAxisAlignment: MainAxisAlignment.center, // Removed
                    mainAxisSize: MainAxisSize.min, // Wrap content
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              item.name,
                              style: GoogleFonts.philosopher(
                                fontSize: 18.sp, // Slightly smaller
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFF3E2723),
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          GestureDetector(
                            onTap: () => cart.removeItem(item.id),
                            child: Container(
                              padding: EdgeInsets.all(4.w),
                              decoration: BoxDecoration(
                                color: Colors.red.withValues(alpha: 0.1),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Iconsax.trash,
                                size: 20.sp,
                                color: Colors.red[800],
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 4.w), // Ultra Reduced spacing
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text(
                                "Rs. ${(double.parse(item.price.replaceAll(RegExp(r'[^0-9]'), '')) * item.quantity).toStringAsFixed(0)}",
                                style: GoogleFonts.outfit(
                                  fontSize: 15.sp, // Slightly smaller
                                  color: const Color(0xFF3E2723),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 8.w),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 6.w,
                              vertical: 4.w, // W-based vertical padding
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.5),
                              borderRadius: BorderRadius.circular(20.w),
                              border: Border.all(
                                color: Colors.white.withValues(alpha: 0.8),
                              ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                _buildQtyBtn(
                                  icon: Icons.remove,
                                  onTap: () => cart.removeSingleItem(item.id),
                                  itemColor: item.color1,
                                  size: 24.w, // Smaller
                                ),
                                SizedBox(width: 8.w), // Tighter gap
                                Text(
                                  item.quantity.toString(),
                                  style: GoogleFonts.outfit(
                                    fontSize: 15.sp, // Smaller
                                    fontWeight: FontWeight.bold,
                                    color: const Color(0xFF3E2723),
                                  ),
                                ),
                                SizedBox(width: 8.w), // Tighter gap
                                _buildQtyBtn(
                                  icon: Icons.add,
                                  onTap: () => cart.addItem(
                                    productId: item.id,
                                    name: item.name,
                                    price: item.price,
                                    imagePath: item.imagePath,
                                    description: item.description,
                                    color1: item.color1,
                                    color2: item.color2,
                                  ),
                                  isAdd: true,
                                  itemColor: item.color1,
                                  size: 24.w, // Smaller
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // Floating Image - Further Reduced
          Positioned(
            left: 10.w,
            // bottom: 20.h, // Can't use fixed bottom if card height varies easily?
            // Actually, if we use Stack alignment, we can align it to the left center.
            child: Container(
              width: 60.w, // Smaller image
              height: 60.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: item.color1.withValues(alpha: 0.4),
                    blurRadius: 15.w,
                    offset: Offset(0, 8.w), // W-based
                  ),
                ],
              ),
              child: ClipOval(
                child: Image.asset(
                  item.imagePath,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) =>
                      Icon(Icons.fastfood, size: 30.sp),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQtyBtn({
    required IconData icon,
    required VoidCallback onTap,
    bool isAdd = false,
    required Color itemColor,
    double? size,
  }) {
    final btnSize = size ?? 28.w;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: btnSize,
        height: btnSize,
        decoration: BoxDecoration(
          color: isAdd ? itemColor : Colors.white,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: itemColor.withValues(alpha: 0.2),
              blurRadius: 4.w,
              offset: Offset(0, 2.h),
            ),
          ],
        ),
        child: Icon(
          icon,
          size: (btnSize * 0.55),
          color: isAdd ? Colors.white : itemColor,
        ),
      ),
    );
  }

  Widget _buildCheckoutSection(BuildContext context, CartModel cart) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(35.w),
        topRight: Radius.circular(35.w),
      ),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 24.w,
          vertical: 12.h,
        ), // Extra Reduced vertical padding
        decoration: BoxDecoration(
          color: const Color(0xFFFFF3E0), // Solid Creamy Background
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(35.w),
            topRight: Radius.circular(35.w),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 20.w,
              offset: Offset(0, -5.h),
            ),
          ],
        ),
        child: SafeArea(
          top: false,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Cost Breakdown
              _buildSummaryRow("Sub total", cart.subTotal),
              SizedBox(height: 6.h), // Extra Tighter spacing
              _buildSummaryRow("Serving Fee", cart.servingFee),
              SizedBox(height: 8.h), // Extra Tighter spacing
              // Divider
              Divider(
                color: const Color(0xFF5D4037).withValues(alpha: 0.2),
                thickness: 1,
              ),
              SizedBox(height: 8.h), // Extra Tighter spacing
              // Grand Total
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Total",
                    style: GoogleFonts.philosopher(
                      fontSize: 22.sp,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF3E2723),
                    ),
                  ),
                  Text(
                    "Rs. ${cart.grandTotal.toStringAsFixed(0)}",
                    style: GoogleFonts.philosopher(
                      fontSize: 26.sp,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF3E2723),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12.h), // Extra Tighter spacing
              // Checkout Button
              // Checkout Button
              Container(
                width: double.infinity,
                height: 45.w, // Increased height
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30.w), // Pill shape
                  color: const Color(0xFF1A1A1A), // Almost black/dark brown
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.2),
                      blurRadius: 10.w,
                      offset: Offset(0, 5.w),
                    ),
                  ],
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const CheckoutScreen(),
                        ),
                      );
                    },
                    borderRadius: BorderRadius.circular(30.w),
                    child: Center(
                      child: Text(
                        "Checkout",
                        style: GoogleFonts.outfit(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSummaryRow(String label, double amount) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: GoogleFonts.outfit(
            fontSize: 15.sp,
            color: const Color(0xFF5D4037).withValues(alpha: 0.8),
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          "Rs. ${amount.toStringAsFixed(0)}",
          style: GoogleFonts.outfit(
            fontSize: 15.sp,
            color: const Color(0xFF3E2723),
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
