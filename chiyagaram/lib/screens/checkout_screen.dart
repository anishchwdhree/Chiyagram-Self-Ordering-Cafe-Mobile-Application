import 'package:chiyagaram/models/cart_model.dart';
import 'package:chiyagaram/responsive/size_config.dart';
import 'package:chiyagaram/screens/widget/background_scaffold.dart';
import 'package:chiyagaram/theme/theme_provider.dart';
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

  @override
  void dispose() {
    _tableController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDark = themeProvider.isDarkMode;
    final textColor = isDark ? Colors.white : const Color(0xFF3E2723);
    final subTextColor = isDark ? Colors.white70 : const Color(0xFF5D4037);
    final cardColor = isDark
        ? const Color(0xFF5D4037).withOpacity(0.4)
        : Colors.white.withValues(alpha: 0.4);

    return BackgroundScaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: textColor,
            size: 20.sp,
          ),
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

          // Content
          SafeArea(
            child: Consumer<CartModel>(
              builder: (context, cart, child) {
                return SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 20.w),

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
                                fillColor: isDark ? Colors.white.withOpacity(0.05) : Colors.white.withValues(alpha: 0.5),
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
                                    color: isDark ? Colors.white12 : Colors.white.withValues(alpha: 0.5),
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
                            _buildSummaryRow("Serving Fee", "0", textColor, subTextColor),
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
                        onTap: () {
                          if (_tableController.text.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  "Please enter your table number",
                                  style: GoogleFonts.outfit(
                                    color: Colors.white,
                                  ),
                                ),
                                backgroundColor: Colors.redAccent,
                                behavior: SnackBarBehavior.floating,
                                margin: EdgeInsets.all(20.w),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.w),
                                ),
                              ),
                            );
                            return;
                          }

                          // Mock Order Success
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                "Order Placed for Table ${_tableController.text}!",
                                style: GoogleFonts.outfit(color: Colors.white),
                              ),
                              backgroundColor: Colors.green,
                              behavior: SnackBarBehavior.floating,
                              margin: EdgeInsets.all(20.w),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.w),
                              ),
                            ),
                          );
                          cart.clearCart();
                          Navigator.popUntil(context, (route) => route.isFirst);
                        },
                        child: Container(
                          width: double.infinity,
                          height: 55.w,
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
                          alignment: Alignment.center,
                          child: Text(
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

  Widget _buildGlassContainer({required Widget child, required Color cardColor, required Color textColor}) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(20.w),
        border: Border.all(
          color: textColor.withValues(alpha: 0.1),
          width: 1,
        ),
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

  Widget _buildSummaryRow(String label, String value, Color textColor, Color subTextColor) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: GoogleFonts.outfit(
            fontSize: 16.sp,
            color: subTextColor,
          ),
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
