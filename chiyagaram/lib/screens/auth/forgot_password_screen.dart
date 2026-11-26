import 'package:chiyagaram/screens/widget/background_scaffold.dart';
import 'package:chiyagaram/theme/app_colors.dart';
import 'package:chiyagaram/theme/theme_provider.dart';
import 'package:provider/provider.dart';
import 'package:chiyagaram/animations/fade_animation.dart';
import 'package:chiyagaram/responsive/size_config.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _emailController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDark = themeProvider.isDarkMode;
    final textColor = isDark ? Colors.white : const Color(0xFF3E2723);
    final subTextColor = isDark
        ? Colors.white70
        : const Color(0xFF795548).withValues(alpha: 0.5);

    return BackgroundScaffold(
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: MediaQuery.of(context).padding.top),
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: Icon(Icons.arrow_back_ios, color: textColor),
                    ),
                    SizedBox(height: 10.h),
                    _buildHeader(textColor, subTextColor),
                    SizedBox(height: 40.h),
                    _buildForm(isDark, textColor),
                    SizedBox(height: 40.h),
                    _buildSendButton(isDark),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(Color textColor, Color subTextColor) {
    return FadeAnimation(
      delay: 0.2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Forgot Password?',
            style: GoogleFonts.outfit(
              fontWeight: FontWeight.bold,
              color: textColor,
              fontSize: 32.sp,
            ),
          ),
          SizedBox(height: 10.h),
          Text(
            "Don't worry! It happens. Please enter the address associated with your account.",
            style: GoogleFonts.inter(
              color: subTextColor,
              fontSize: 16.sp,
              height: 1.2,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildForm(bool isDark, Color textColor) {
    return FadeAnimation(
      delay: 0.4,
      child: _CustomTextField(
        controller: _emailController,
        label: "Email ID",
        icon: Icons.email_outlined,
        isDark: isDark,
        textColor: textColor,
      ),
    );
  }

  Widget _buildSendButton(bool isDark) {
    return FadeAnimation(
      delay: 0.6,
      child: SizedBox(
        width: double.infinity,
        height: 45.h,
        child: ElevatedButton(
          onPressed: () async {
            if (_emailController.text.isEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Please enter your email')),
              );
              return;
            }

            setState(() {
              _isLoading = true;
            });

            try {
              await FirebaseAuth.instance.sendPasswordResetEmail(
                email: _emailController.text.trim(),
              );

              if (mounted) {
                setState(() {
                  _isLoading = false;
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'Password reset link sent to ${_emailController.text}',
                    ),
                    backgroundColor: isDark
                        ? AppColors.igSurface
                        : AppColors.secondary,
                    behavior: SnackBarBehavior.floating,
                  ),
                );
                Navigator.pop(context);
              }
            } on FirebaseAuthException catch (e) {
              if (mounted) {
                setState(() {
                  _isLoading = false;
                });
                String message = 'An error occurred';
                if (e.code == 'user-not-found') {
                  message = 'No account found with this email.';
                } else if (e.code == 'invalid-email') {
                  message = 'Please enter a valid email address.';
                } else if (e.code == 'network-request-failed') {
                  message = 'Network error. Please check your connection.';
                } else {
                  message = e.message ?? message;
                }
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(message),
                    backgroundColor: Colors.redAccent,
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              }
            } catch (e) {
              if (mounted) {
                setState(() {
                  _isLoading = false;
                });
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text(e.toString())));
              }
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: isDark
                ? Colors.white
                : const Color.fromARGB(255, 0, 0, 0),
            foregroundColor: isDark ? Colors.black : Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            elevation: 8,
            shadowColor: const Color(0xFF5D4037).withValues(alpha: 0.5),
          ),
          child: _isLoading
              ? CircularProgressIndicator(
                  color: isDark ? Colors.black : Colors.white,
                )
              : Text(
                  'SUBMIT',
                  style: GoogleFonts.outfit(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.sp,
                    letterSpacing: 1.2,
                  ),
                ),
        ),
      ),
    );
  }
}

class _CustomTextField extends StatelessWidget {
  final String label;
  final IconData icon;
  final TextEditingController controller;
  final bool isDark;
  final Color textColor;

  const _CustomTextField({
    required this.label,
    required this.icon,
    required this.controller,
    required this.isDark,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.outfit(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            color: textColor,
          ),
        ),
        SizedBox(height: 8.h),
        Container(
          decoration: BoxDecoration(
            color: isDark ? Colors.white10 : Colors.white,
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              if (!isDark)
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
            ],
          ),
          child: TextField(
            controller: controller,
            style: GoogleFonts.inter(
              fontSize: 16.sp,
              color: isDark ? Colors.white : Colors.black87,
            ),
            decoration: InputDecoration(
              hintStyle: GoogleFonts.inter(
                color: isDark ? Colors.white38 : Colors.black38,
              ),
              prefixIcon: Icon(
                icon,
                color: isDark ? Colors.white70 : AppColors.mediumBrown,
              ),
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(
                horizontal: 20.w,
                vertical: 12.h,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
