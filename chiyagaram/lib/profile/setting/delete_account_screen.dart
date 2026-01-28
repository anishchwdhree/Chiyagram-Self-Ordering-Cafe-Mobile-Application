import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:chiyagaram/responsive/size_config.dart';

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
    return Scaffold(
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
                              icon: const Icon(
                                Icons.arrow_back_ios_new,
                                color: Color(0xFF3E2723),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                "Delete Account",
                                textAlign: TextAlign.center,
                                style: GoogleFonts.philosopher(
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.bold,
                                  color: const Color(0xFF3E2723),
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
                            color: const Color(0xFF3E2723),
                          ),
                        ),
                        SizedBox(height: 16.h),
                        Text(
                          "Deleting your account will permanently remove all your data, including order history and saved preferences. This action cannot be undone.",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.outfit(
                            fontSize: 16.sp,
                            color: const Color(0xFF5D4037),
                            height: 1.5,
                          ),
                        ),
                        const Spacer(),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () => _showConfirmationDialog(context),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.redAccent,
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
                                color: Colors.white,
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
                              color: const Color(0xFF3E2723),
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

  void _showConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            backgroundColor: const Color(0xFFFFF8E1),
            title: Text(
              "Final Confirmation",
              style: GoogleFonts.philosopher(
                fontWeight: FontWeight.bold,
                color: const Color(0xFF3E2723),
              ),
            ),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Please enter your password to confirm deletion.",
                    style: GoogleFonts.outfit(color: const Color(0xFF5D4037)),
                  ),
                  SizedBox(height: 16.h),
                  TextField(
                    controller: _passwordController,
                    obscureText: _obscurePassword,
                    style: GoogleFonts.outfit(color: const Color(0xFF3E2723)),
                    decoration: InputDecoration(
                      labelText: "Password",
                      labelStyle: GoogleFonts.outfit(
                        color: const Color(0xFF3E2723).withValues(alpha: 0.7),
                      ),
                      prefixIcon: const Icon(
                        Iconsax.lock,
                        color: Color(0xFF3E2723),
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscurePassword ? Iconsax.eye_slash : Iconsax.eye,
                          color: const Color(0xFF3E2723),
                        ),
                        onPressed: () {
                          setState(() {
                            _obscurePassword = !_obscurePassword;
                          });
                        },
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.w),
                        borderSide: const BorderSide(color: Color(0xFF3E2723)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.w),
                        borderSide: const BorderSide(
                          color: Color(0xFF3E2723),
                          width: 2,
                        ),
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
                  style: GoogleFonts.outfit(color: const Color(0xFF3E2723)),
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
