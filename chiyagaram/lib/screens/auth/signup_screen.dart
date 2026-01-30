import 'package:chiyagaram/screens/widget/background_scaffold.dart';
import 'package:chiyagaram/theme/app_colors.dart';
import 'package:chiyagaram/theme/theme_provider.dart';
import 'package:provider/provider.dart';
import 'package:chiyagaram/animations/fade_animation.dart';
import 'package:chiyagaram/responsive/size_config.dart';
import 'package:chiyagaram/screens/second_homescreen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
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
      body: SafeArea(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(
                    horizontal: 24.w,
                    vertical: 24.h,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: Icon(Icons.arrow_back_ios, color: textColor),
                      ),
                      SizedBox(height: 20.h),
                      _buildHeader(textColor, subTextColor),
                      SizedBox(height: 40.h),
                      _buildSignupForm(isDark, textColor),
                      SizedBox(height: 40.h),
                      _buildSignupButton(isDark),
                      SizedBox(height: 30.h),
                      _buildDivider(isDark),
                      SizedBox(height: 30.h),
                      _buildSocialButtons(isDark),
                      SizedBox(height: 40.h),
                      _buildLoginLink(isDark),
                    ],
                  ),
                ),
              ),
            ],
          ),
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
            'Create Account',
            style: GoogleFonts.outfit(
              fontWeight: FontWeight.bold,
              color: textColor,
              fontSize: 32.sp,
            ),
          ),
          SizedBox(height: 10.h),
          Text(
            'Start your journey with us today!',
            style: GoogleFonts.inter(
              color: subTextColor,
              fontSize: 16.sp,
              height: 1.0,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSignupForm(bool isDark, Color textColor) {
    return Column(
      children: [
        FadeAnimation(
          delay: 0.3,
          child: _CustomTextField(
            controller: _nameController,
            label: "Full Name",
            hint: "Enter your full name",
            icon: Icons.person_outline,
            isDark: isDark,
            textColor: textColor,
          ),
        ),
        SizedBox(height: 20.h),
        FadeAnimation(
          delay: 0.4,
          child: _CustomTextField(
            controller: _emailController,
            label: "Email",
            hint: "Enter your email",
            icon: Icons.email_outlined,
            isDark: isDark,
            textColor: textColor,
          ),
        ),
        SizedBox(height: 20.h),
        FadeAnimation(
          delay: 0.5,
          child: _CustomTextField(
            controller: _passwordController,
            label: "Password",
            hint: "Create a password",
            isPassword: true,
            icon: Icons.lock_outline,
            isDark: isDark,
            textColor: textColor,
          ),
        ),
      ],
    );
  }

  Widget _buildSignupButton(bool isDark) {
    return FadeAnimation(
      delay: 0.6,
      child: SizedBox(
        width: double.infinity,
        height: 45.h,
        child: ElevatedButton(
          onPressed: () {
            setState(() {
              _isLoading = true;
            });
            Future.delayed(const Duration(seconds: 2), () {
              if (mounted) {
                setState(() {
                  _isLoading = false;
                });
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SecondHomescreen(),
                  ),
                );
              }
            });
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
                  'SIGN UP',
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

  Widget _buildDivider(bool isDark) {
    return FadeAnimation(
      delay: 0.7,
      child: Row(
        children: [
          Expanded(
            child: Divider(color: isDark ? Colors.white24 : Colors.black12),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Text(
              'Or sign up with',
              style: GoogleFonts.inter(
                color: isDark ? Colors.white54 : Colors.black38,
                fontSize: 13.sp,
              ),
            ),
          ),
          Expanded(
            child: Divider(color: isDark ? Colors.white24 : Colors.black12),
          ),
        ],
      ),
    );
  }

  Widget _buildSocialButtons(bool isDark) {
    return FadeAnimation(
      delay: 0.8,
      child: Center(
        child: _SocialButton(
          imagePath: "images/Google.png",
          label: "Continue with Google",
          isDark: isDark,
          onTap: () {},
        ),
      ),
    );
  }

  Widget _buildLoginLink(bool isDark) {
    return FadeAnimation(
      delay: 0.9,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Already have an account?",
            style: GoogleFonts.inter(
              color: isDark ? Colors.white54 : Colors.black54,
              fontSize: 14.sp,
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              "Login",
              style: GoogleFonts.inter(
                color: isDark ? AppColors.white : AppColors.secondary,
                fontWeight: FontWeight.bold,
                fontSize: 14.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CustomTextField extends StatelessWidget {
  final String label;
  final String hint;
  final bool isPassword;
  final IconData icon;
  final TextEditingController controller;
  final bool isDark;
  final Color textColor;

  const _CustomTextField({
    required this.label,
    required this.hint,
    this.isPassword = false,
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
            obscureText: isPassword,
            style: GoogleFonts.inter(
              fontSize: 16.sp,
              color: isDark ? Colors.white : Colors.black87,
            ),
            decoration: InputDecoration(
              hintText: hint,
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

class _SocialButton extends StatelessWidget {
  final IconData? icon;
  final String? imagePath;
  final String label;
  final VoidCallback onTap;
  final bool isDark;

  const _SocialButton({
    this.icon,
    this.imagePath,
    required this.label,
    required this.onTap,
    required this.isDark,
  }) : assert(icon != null || imagePath != null);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(30),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: isDark ? Colors.white10 : Colors.white,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: isDark ? Colors.white24 : Colors.black12),
          boxShadow: [
            if (!isDark)
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 5,
                offset: const Offset(0, 2),
              ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (imagePath != null)
              Image.asset(imagePath!, height: 24.h, width: 24.h)
            else
              Icon(
                icon,
                size: 24.sp,
                color: isDark ? Colors.white : AppColors.secondary,
              ),
            SizedBox(width: 12.w),
            Text(
              label,
              style: GoogleFonts.inter(
                fontSize: 15.sp,
                fontWeight: FontWeight.w600,
                color: isDark ? Colors.white : Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
