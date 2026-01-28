import 'package:chiyagaram/screens/widget/background_scaffold.dart';
import 'package:chiyagaram/theme/theme_provider.dart';
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
    SizeConfig().init(context);
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDark = themeProvider.isDarkMode;
    final textColor = isDark ? Colors.white : const Color(0xFF3E2723);

    return BackgroundScaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back_ios, color: textColor),
        ),
        title: Text(
          "My Order",
          style: GoogleFonts.philosopher(
            fontSize: 24.sp,
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          // 1. Decorative Background Circles
          Positioned(
            top: -50.w,
            right: -50.w,
            child: Container(
              width: 200.w,
              height: 200.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: (isDark ? const Color(0xFF4E342E) : const Color(0xFFFFCCBC)).withValues(alpha: 0.4),
                boxShadow: [
                  BoxShadow(
                    color: (isDark ? const Color(0xFF4E342E) : const Color(0xFFFFCCBC)).withValues(alpha: 0.2),
                    blurRadius: 50.w,
                    spreadRadius: 10.w,
                  ),
                ],
              ),
            ),
          ),

          // 2. Cart Content
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
                            color: isDark ? Colors.white70 : const Color(0xFF8D6E63),
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
                                  child: _buildCartItem(context, item, cart, isDark, textColor),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    // Total and Checkout
                    Padding(
                      padding: EdgeInsets.only(bottom: 100.w),
                      child: _buildCheckoutSection(context, cart, isDark, textColor),
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

  Widget _buildCartItem(BuildContext context, CartItem item, CartModel cart, bool isDark, Color textColor) {
    return Container(
      margin: EdgeInsets.only(bottom: 8.w),
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.centerLeft,
        children: [
          // Glassmorphic Card
          Container(
            margin: const EdgeInsets.only(left: 0),
            constraints: BoxConstraints(
              minHeight: 85.w,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24.w),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: isDark 
                  ? [
                      Colors.white.withValues(alpha: 0.1),
                      Colors.white.withValues(alpha: 0.05),
                    ]
                  : [
                      item.color1.withValues(alpha: 0.15),
                      item.color2.withValues(alpha: 0.05),
                    ],
              ),
              border: Border.all(
                color: isDark ? Colors.white10 : Colors.white.withValues(alpha: 0.6),
                width: 1.5.w,
              ),
              boxShadow: [
                BoxShadow(
                  color: isDark ? Colors.black26 : item.color1.withValues(alpha: 0.1),
                  blurRadius: 20.w,
                  offset: Offset(0, 8.w),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(24.w),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                child: Padding(
                  padding: EdgeInsets.fromLTRB(80.w, 10.w, 12.w, 10.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              item.name,
                              style: GoogleFonts.philosopher(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.bold,
                                color: textColor,
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
                                color: isDark ? Colors.redAccent : Colors.red[800],
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 4.w),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text(
                                "Rs. ${(double.parse(item.price.replaceAll(RegExp(r'[^0-9]'), '')) * item.quantity).toStringAsFixed(0)}",
                                style: GoogleFonts.outfit(
                                  fontSize: 15.sp,
                                  color: textColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 8.w),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 6.w,
                              vertical: 4.w,
                            ),
                            decoration: BoxDecoration(
                              color: isDark ? Colors.white10 : Colors.white.withValues(alpha: 0.5),
                              borderRadius: BorderRadius.circular(20.w),
                              border: Border.all(
                                color: isDark ? Colors.white10 : Colors.white.withValues(alpha: 0.8),
                              ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                _buildQtyBtn(
                                  icon: Icons.remove,
                                  onTap: () => cart.removeSingleItem(item.id),
                                  itemColor: isDark ? Colors.white : item.color1,
                                  size: 24.w,
                                  isDark: isDark,
                                ),
                                SizedBox(width: 8.w),
                                Text(
                                  item.quantity.toString(),
                                  style: GoogleFonts.outfit(
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.bold,
                                    color: textColor,
                                  ),
                                ),
                                SizedBox(width: 8.w),
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
                                  itemColor: isDark ? Colors.white : item.color1,
                                  size: 24.w,
                                  isDark: isDark,
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

          // Floating Image
          Positioned(
            left: 10.w,
            child: Container(
              width: 60.w,
              height: 60.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: item.color1.withValues(alpha: 0.4),
                    blurRadius: 15.w,
                    offset: Offset(0, 8.w),
                  ),
                ],
              ),
              child: ClipOval(
                child: Image.asset(
                  item.imagePath,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) =>
                      Icon(Icons.fastfood, size: 30.sp, color: textColor),
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
    required bool isDark,
  }) {
    final btnSize = size ?? 28.w;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: btnSize,
        height: btnSize,
        decoration: BoxDecoration(
          color: isAdd ? (isDark ? Colors.white : itemColor) : (isDark ? Colors.transparent : Colors.white),
          shape: BoxShape.circle,
          border: isDark && !isAdd ? Border.all(color: Colors.white24) : null,
          boxShadow: [
            if (!isDark)
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
          color: isAdd 
              ? (isDark ? Colors.black : Colors.white) 
              : (isDark ? Colors.white : itemColor),
        ),
      ),
    );
  }

  Widget _buildCheckoutSection(BuildContext context, CartModel cart, bool isDark, Color textColor) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(35.w),
        topRight: Radius.circular(35.w),
      ),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 24.w,
          vertical: 12.h,
        ),
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF2D1B18) : const Color(0xFFFFF3E0),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(35.w),
            topRight: Radius.circular(35.w),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: isDark ? 0.3 : 0.05),
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
              _buildSummaryRow("Sub total", cart.subTotal, isDark, textColor),
              SizedBox(height: 6.h),
              _buildSummaryRow("Serving Fee", cart.servingFee, isDark, textColor),
              SizedBox(height: 8.h),
              // Divider
              Divider(
                color: (isDark ? Colors.white : const Color(0xFF5D4037)).withValues(alpha: 0.2),
                thickness: 1,
              ),
              SizedBox(height: 8.h),
              // Grand Total
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Total",
                    style: GoogleFonts.philosopher(
                      fontSize: 22.sp,
                      fontWeight: FontWeight.bold,
                      color: textColor,
                    ),
                  ),
                  Text(
                    "Rs. ${cart.grandTotal.toStringAsFixed(0)}",
                    style: GoogleFonts.philosopher(
                      fontSize: 26.sp,
                      fontWeight: FontWeight.bold,
                      color: textColor,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12.h),
              // Checkout Button
              Container(
                width: double.infinity,
                height: 45.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30.w),
                  color: isDark ? Colors.white : const Color(0xFF1A1A1A),
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
                          color: isDark ? Colors.black : Colors.white,
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

  Widget _buildSummaryRow(String label, double amount, bool isDark, Color textColor) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: GoogleFonts.outfit(
            fontSize: 15.sp,
            color: isDark ? Colors.white70 : const Color(0xFF5D4037).withValues(alpha: 0.8),
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          "Rs. ${amount.toStringAsFixed(0)}",
          style: GoogleFonts.outfit(
            fontSize: 15.sp,
            color: textColor,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
