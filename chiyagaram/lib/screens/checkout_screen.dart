import 'package:chiyagaram/models/cart_model.dart';
import 'package:chiyagaram/responsive/size_config.dart';
import 'package:chiyagaram/screens/widget/background_scaffold.dart';
import 'package:chiyagaram/services/notification_provider.dart';
import 'package:chiyagaram/services/connectivity_provider.dart';
import 'package:chiyagaram/services/order_service.dart';
import 'package:chiyagaram/theme/theme_provider.dart';
import 'package:chiyagaram/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final TextEditingController _tableController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _tableController.dispose();
    super.dispose();
  }

  Future<void> _handleOrderPlacement(CartModel cart) async {
    final connectivityProvider = Provider.of<ConnectivityProvider>(
      context,
      listen: false,
    );
    if (!connectivityProvider.isOnline) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "No Internet connection. Unable to place order.",
            style: GoogleFonts.outfit(color: Colors.white),
          ),
          backgroundColor: Colors.redAccent,
        ),
      );
      return;
    }

    final tableNumberStr = _tableController.text.trim();
    if (tableNumberStr.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Please enter your table number",
            style: GoogleFonts.outfit(color: Colors.white),
          ),
          backgroundColor: Colors.redAccent,
        ),
      );
      return;
    }

    final tableNumber = int.tryParse(tableNumberStr);
    if (tableNumber == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Please enter a valid numeric table number",
            style: GoogleFonts.outfit(color: Colors.white),
          ),
          backgroundColor: Colors.redAccent,
        ),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final orderService = OrderService();
      final orderId = await orderService.placeOrder(
        tableNumber: tableNumber,
        items: cart.items.values.toList(),
        totalAmount: cart.totalPrice,
      );

      if (!mounted) return;

      // Register with NotificationProvider
      Provider.of<NotificationProvider>(
        context,
        listen: false,
      ).addActiveOrder(orderId);

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Order Placed for Table $tableNumber!",
            style: GoogleFonts.outfit(color: Colors.white),
          ),
          backgroundColor: Colors.green,
        ),
      );

      cart.clearCart();
      Navigator.popUntil(context, (route) => route.isFirst);
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Failed to place order. Please try again.",
            style: GoogleFonts.outfit(color: Colors.white),
          ),
          backgroundColor: Colors.redAccent,
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDark = themeProvider.isDarkMode;
    final textColor = isDark ? Colors.white : const Color(0xFF3E2723);
    final subTextColor = isDark
        ? AppColors.igTextSecondary
        : const Color(0xFF5D4037);
    final cardColor = isDark
        ? AppColors.igSurface.withValues(alpha: 0.6)
        : Colors.white.withValues(alpha: 0.4);

    return BackgroundScaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new, color: textColor, size: 20.sp),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "Table Order",
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
          // Decorative Background Circles
          Positioned(
            top: -50.w,
            right: -50.w,
            child: Container(
              width: 200.w,
              height: 200.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: (isDark ? AppColors.igSurface : const Color(0xFFFFCCBC))
                    .withValues(alpha: 0.4),
                boxShadow: [
                  BoxShadow(
                    color:
                        (isDark ? AppColors.igSurface : const Color(0xFFFFCCBC))
                            .withValues(alpha: 0.2),
                    blurRadius: 50.w,
                    spreadRadius: 10.w,
                  ),
                ],
              ),
            ),
          ),

          // Content
          Consumer<CartModel>(
            builder: (context, cart, child) {
              return SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.symmetric(horizontal: 20.w).copyWith(
                  top:
                      MediaQuery.of(context).padding.top +
                      kToolbarHeight +
                      20.h,
                  bottom: MediaQuery.of(context).padding.bottom + 20.h,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Table Number Section
                    _buildSectionTitle("Enter Table Details", textColor),
                    SizedBox(height: 10.w),
                    _buildGlassContainer(
                      cardColor: cardColor,
                      textColor: textColor,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Table Number",
                            style: GoogleFonts.outfit(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                              color: textColor,
                            ),
                          ),
                          SizedBox(height: 10.w),
                          TextField(
                            controller: _tableController,
                            keyboardType: TextInputType.number,
                            style: GoogleFonts.outfit(
                              fontSize: 18.sp,
                              color: textColor,
                              fontWeight: FontWeight.w600,
                            ),
                            decoration: InputDecoration(
                              hintText: "Ex: 5",
                              hintStyle: GoogleFonts.outfit(
                                color: subTextColor.withValues(alpha: 0.5),
                              ),
                              filled: true,
                              fillColor: isDark
                                  ? Colors.white.withValues(alpha: 0.05)
                                  : Colors.white.withValues(alpha: 0.5),
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 20.w,
                                vertical: 15.w,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.w),
                                borderSide: BorderSide.none,
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.w),
                                borderSide: BorderSide(
                                  color: isDark
                                      ? Colors.white12
                                      : Colors.white.withValues(alpha: 0.5),
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.w),
                                borderSide: BorderSide(
                                  color: textColor,
                                  width: 1.5,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 10.w),
                          Text(
                            "Please enter the table number where you are seated.",
                            style: GoogleFonts.outfit(
                              fontSize: 14.sp,
                              color: subTextColor.withValues(alpha: 0.8),
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 30.w),

                    // Order Summary Section
                    _buildSectionTitle("Order Summary", textColor),
                    SizedBox(height: 10.w),
                    _buildGlassContainer(
                      cardColor: cardColor,
                      textColor: textColor,
                      child: Column(
                        children: [
                          _buildSummaryRow(
                            "Subtotal",
                            cart.totalPrice.toStringAsFixed(0),
                            textColor,
                            subTextColor,
                          ),
                          SizedBox(height: 8.w),
                          _buildSummaryRow(
                            "Serving Fee",
                            "0",
                            textColor,
                            subTextColor,
                          ),
                          Divider(
                            color: textColor.withValues(alpha: 0.2),
                            height: 24.w,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Total",
                                style: GoogleFonts.philosopher(
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.bold,
                                  color: textColor,
                                ),
                              ),
                              Text(
                                "Rs. ${cart.totalPrice.toStringAsFixed(0)}",
                                style: GoogleFonts.philosopher(
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.bold,
                                  color: textColor,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 50.w),

                    // Confirm Button
                    GestureDetector(
                      onTap: _isLoading
                          ? null
                          : () => _handleOrderPlacement(cart),
                      child: Container(
                        width: double.infinity,
                        height: 55.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30.w),
                          color: isDark
                              ? Colors.white
                              : const Color(0xFF1A1A1A),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.2),
                              blurRadius: 10.w,
                              offset: Offset(0, 5.w),
                            ),
                          ],
                        ),
                        alignment: Alignment.center,
                        child: _isLoading
                            ? SizedBox(
                                height: 24.w,
                                width: 24.w,
                                child: CircularProgressIndicator(
                                  color: isDark ? Colors.black : Colors.white,
                                  strokeWidth: 2,
                                ),
                              )
                            : Text(
                                "Confirm Table Order",
                                style: GoogleFonts.outfit(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.bold,
                                  color: isDark ? Colors.black : Colors.white,
                                ),
                              ),
                      ),
                    ),
                    SizedBox(height: 30.w),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title, Color textColor) {
    return Text(
      title,
      style: GoogleFonts.philosopher(
        fontSize: 20.sp,
        fontWeight: FontWeight.bold,
        color: textColor,
      ),
    );
  }

  Widget _buildGlassContainer({
    required Widget child,
    required Color cardColor,
    required Color textColor,
  }) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(20.w),
        border: Border.all(color: textColor.withValues(alpha: 0.1), width: 1),
        boxShadow: [
          BoxShadow(
            color: textColor.withValues(alpha: 0.05),
            blurRadius: 10.w,
            offset: Offset(0, 4.w),
          ),
        ],
      ),
      child: child,
    );
  }

  Widget _buildSummaryRow(
    String label,
    String value,
    Color textColor,
    Color subTextColor,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: GoogleFonts.outfit(fontSize: 16.sp, color: subTextColor),
        ),
        Text(
          "Rs. $value",
          style: GoogleFonts.outfit(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            color: textColor,
          ),
        ),
      ],
    );
  }
}
