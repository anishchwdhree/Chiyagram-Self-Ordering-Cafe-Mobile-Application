import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:chiyagaram/responsive/size_config.dart';
import 'package:chiyagaram/theme/app_colors.dart';
import 'package:chiyagaram/theme/theme_provider.dart';
import 'package:provider/provider.dart';

class DeleteAccountScreen extends StatefulWidget {
  const DeleteAccountScreen({super.key});

  @override
  State<DeleteAccountScreen> createState() => _DeleteAccountScreenState();
}

class _DeleteAccountScreenState extends State<DeleteAccountScreen> {
  final TextEditingController _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDark = themeProvider.isDarkMode;
    final textColor = isDark ? Colors.white : const Color(0xFF3E2723);

    return Scaffold(
      body: Stack(
        children: [
          // Background Gradient
          RepaintBoundary(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: isDark
                      ? [
                          AppColors.igBlack,
                          AppColors.igDarkGrey,
                          AppColors.igBlack,
                        ]
                      : [
                          const Color(0xFFFFF3E0),
                          const Color(0xFFFFECB3),
                          const Color(0xFFFBE9E7),
                        ],
                ),
              ),
              child: const SizedBox.expand(),
            ),
          ),
          SafeArea(
            child: CustomScrollView(
              slivers: [
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 20.w,
                      vertical: 20.h,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            IconButton(
                              onPressed: () => Navigator.pop(context),
                              icon: Icon(
                                Icons.arrow_back_ios_new,
                                color: textColor,
                              ),
                            ),
                            Expanded(
                              child: Text(
                                "Delete Account",
                                textAlign: TextAlign.center,
                                style: GoogleFonts.philosopher(
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.bold,
                                  color: textColor,
                                ),
                              ),
                            ),
                            SizedBox(width: 40.w),
                          ],
                        ),
                        SizedBox(height: 60.h),
                        Icon(
                          Iconsax.warning_2,
                          size: 80.sp,
                          color: Colors.redAccent,
                        ),
                        SizedBox(height: 24.h),
                        Text(
                          "Are you sure?",
                          style: GoogleFonts.philosopher(
                            fontSize: 28.sp,
                            fontWeight: FontWeight.bold,
                            color: textColor,
                          ),
                        ),
                        SizedBox(height: 16.h),
                        Text(
                          "Deleting your account will permanently remove all your data, including order history and saved preferences. This action cannot be undone.",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.outfit(
                            fontSize: 16.sp,
                            color: isDark
                                ? AppColors.igTextSecondary
                                : const Color(0xFF5D4037),
                            height: 1.5,
                          ),
                        ),
                        const Spacer(),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () => _showConfirmationDialog(
                              context,
                              isDark,
                              textColor,
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: isDark
                                  ? Colors.white
                                  : Colors.redAccent,
                              padding: EdgeInsets.symmetric(vertical: 16.h),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16.w),
                              ),
                              elevation: 5,
                            ),
                            child: Text(
                              "Delete My Account",
                              style: GoogleFonts.outfit(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600,
                                color: isDark ? Colors.black : Colors.white,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 16.h),
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text(
                            "Cancel",
                            style: GoogleFonts.outfit(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w500,
                              color: textColor,
                            ),
                          ),
                        ),
                        SizedBox(height: 20.h),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showConfirmationDialog(
    BuildContext context,
    bool isDark,
    Color textColor,
  ) {
    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            backgroundColor: isDark
                ? AppColors.igSurface
                : const Color(0xFFFFF8E1),
            title: Text(
              "Final Confirmation",
              style: GoogleFonts.philosopher(
                fontWeight: FontWeight.bold,
                color: textColor,
              ),
            ),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Please enter your password to confirm deletion.",
                    style: GoogleFonts.outfit(
                      color: isDark
                          ? AppColors.igTextSecondary
                          : const Color(0xFF5D4037),
                    ),
                  ),
                  SizedBox(height: 16.h),
                  TextField(
                    controller: _passwordController,
                    obscureText: _obscurePassword,
                    style: GoogleFonts.outfit(color: textColor),
                    decoration: InputDecoration(
                      labelText: "Password",
                      labelStyle: GoogleFonts.outfit(
                        color: textColor.withValues(alpha: 0.7),
                      ),
                      prefixIcon: Icon(Iconsax.lock, color: textColor),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscurePassword ? Iconsax.eye_slash : Iconsax.eye,
                          color: textColor,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscurePassword = !_obscurePassword;
                          });
                        },
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.w),
                        borderSide: BorderSide(
                          color: isDark ? AppColors.igBorder : textColor,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.w),
                        borderSide: BorderSide(color: textColor, width: 2),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  _passwordController.clear();
                  Navigator.pop(context);
                },
                child: Text(
                  "Cancel",
                  style: GoogleFonts.outfit(color: textColor),
                ),
              ),
              TextButton(
                onPressed: () {
                  if (_passwordController.text.isNotEmpty) {
                    // Perform delete logic here
                    Navigator.pop(context); // Close dialog
                    Navigator.pop(context); // Go back to settings (or login)
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          "Account deleted successfully",
                          style: GoogleFonts.outfit(),
                        ),
                        backgroundColor: Colors.redAccent,
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          "Please enter your password",
                          style: GoogleFonts.outfit(),
                        ),
                        backgroundColor: Colors.redAccent,
                      ),
                    );
                  }
                },
                child: Text(
                  "Confirm",
                  style: GoogleFonts.outfit(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
