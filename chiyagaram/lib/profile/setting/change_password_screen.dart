import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:chiyagaram/responsive/size_config.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final _oldPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _obscureOld = true;
  bool _obscureNew = true;
  bool _obscureConfirm = true;

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
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // App Bar
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
                          "Change Password",
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
                  SizedBox(height: 40.h),

                  _buildPasswordField(
                    "Current Password",
                    "Enter current password",
                    _oldPasswordController,
                    _obscureOld,
                    () => setState(() => _obscureOld = !_obscureOld),
                  ),
                  SizedBox(height: 20.h),
                  _buildPasswordField(
                    "New Password",
                    "Enter new password",
                    _newPasswordController,
                    _obscureNew,
                    () => setState(() => _obscureNew = !_obscureNew),
                  ),
                  SizedBox(height: 20.h),
                  _buildPasswordField(
                    "Confirm New Password",
                    "Re-enter new password",
                    _confirmPasswordController,
                    _obscureConfirm,
                    () => setState(() => _obscureConfirm = !_obscureConfirm),
                  ),
                  SizedBox(height: 50.h),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        // Implement password change logic
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF3E2723),
                        padding: EdgeInsets.symmetric(vertical: 16.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16.w),
                        ),
                        elevation: 5,
                      ),
                      child: Text(
                        "Update Password",
                        style: GoogleFonts.outfit(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPasswordField(
    String label,
    String hint,
    TextEditingController controller,
    bool obscure,
    VoidCallback onToggle,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.outfit(
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            color: const Color(0xFF3E2723).withValues(alpha: 0.7),
          ),
        ),
        SizedBox(height: 8.h),
        TextField(
          controller: controller,
          obscureText: obscure,
          style: GoogleFonts.outfit(
            fontSize: 16.sp,
            color: const Color(0xFF3E2723),
          ),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: GoogleFonts.outfit(
              fontSize: 16.sp,
              color: const Color(0xFF3E2723).withValues(alpha: 0.4),
            ),
            prefixIcon: Icon(
              Iconsax.lock,
              color: const Color(0xFF3E2723).withValues(alpha: 0.6),
              size: 22.sp,
            ),
            suffixIcon: IconButton(
              icon: Icon(
                obscure ? Iconsax.eye_slash : Iconsax.eye,
                color: const Color(0xFF3E2723).withValues(alpha: 0.6),
                size: 22.sp,
              ),
              onPressed: onToggle,
            ),
            filled: true,
            fillColor: Colors.white.withValues(alpha: 0.6),
            contentPadding: EdgeInsets.symmetric(
              vertical: 16.h,
              horizontal: 20.w,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16.w),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16.w),
              borderSide: BorderSide(
                color: Colors.white.withValues(alpha: 0.5),
                width: 1.w,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16.w),
              borderSide: BorderSide(
                color: const Color(0xFF3E2723).withValues(alpha: 0.2),
                width: 1.w,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
