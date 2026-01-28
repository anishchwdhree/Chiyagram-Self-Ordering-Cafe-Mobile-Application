import 'package:chiyagaram/animations/fade_animation.dart';
import 'package:chiyagaram/responsive/size_config.dart';
import 'package:chiyagaram/screens/auth/forgot_password_screen.dart';
import 'package:chiyagaram/screens/auth/signup_screen.dart';
import 'package:chiyagaram/screens/second_homescreen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Re-using the warm tea gradient concept but adapted to the user's requested layout
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          // Background
          Container(
            height: double.infinity,
            width: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFFFFF8E1), // Very light amber
                  Color(0xFFFFECB3), // Amber 100
                  Color(0xFFFFE0B2), // Orange 100
                ],
              ),
            ),
          ),

          SafeArea(
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
                          SizedBox(height: 40.h),
                          _buildHeader(),
                          SizedBox(height: 40.h),
                          _buildLoginForm(),
                          SizedBox(height: 20.h),
                          _buildForgotPassword(),
                          SizedBox(height: 40.h),
                          _buildLoginButton(),
                          SizedBox(height: 30.h),
                          _buildDivider(),
                          SizedBox(height: 30.h),
                          _buildSocialButtons(),
                          SizedBox(height: 40.h),
                          _buildSignUpLink(),
                        ],
                      ),
                    ),
                  ),
                  // _buildWhiteBottomSection(), // Optional, user had it but might not fit our style perfectly, let's omit or keep minimal
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return FadeAnimation(
      delay: 0.2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Welcome Back',
            style: GoogleFonts.outfit(
              fontWeight: FontWeight.bold,
              color: const Color(0xFF3E2723), // Dark Brown
              fontSize: 32.sp,
            ),
          ),
          SizedBox(height: 10.h),
          Text(
            'Brewing Happiness One Login at a Time',
            style: GoogleFonts.inter(
              // fontWeight: FontWeight.w600,
              color: const Color(
                0xFF795548,
              ).withValues(alpha: 0.5), // Brown 300 with reduced opacity
              fontSize: 16.sp,
              height: 1.0,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoginForm() {
    return Column(
      children: [
        FadeAnimation(
          delay: 0.4,
          child: _CustomTextField(
            controller: _emailController,
            label: "Email",
            hint: "Enter your email",
            icon: Icons.email_outlined,
          ),
        ),
        SizedBox(height: 20.h),
        FadeAnimation(
          delay: 0.5,
          child: _CustomTextField(
            controller: _passwordController,
            label: "Password",
            hint: "Enter your password",
            isPassword: true,
            icon: Icons.lock_outline,
          ),
        ),
      ],
    );
  }

  Widget _buildForgotPassword() {
    return FadeAnimation(
      delay: 0.6,
      beginOffset: const Offset(0.2, 0),
      child: Align(
        alignment: Alignment.centerRight,
        child: TextButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ForgotPasswordScreen(),
              ),
            );
          },
          child: Text(
            "Forgot Password?",
            style: GoogleFonts.inter(
              color: const Color(0xFF5D4037),
              fontWeight: FontWeight.w600,
              fontSize: 14.sp,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLoginButton() {
    return FadeAnimation(
      delay: 0.4,
      child: SizedBox(
        width: double.infinity,
        height: 45.h,
        child: ElevatedButton(
          onPressed: () {
            setState(() {
              _isLoading = true;
            });
            // Simulate network delay
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
            backgroundColor: const Color.fromARGB(255, 3, 2, 2),
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            elevation: 8,
            shadowColor: const Color(0xFF5D4037).withValues(alpha: 0.5),
          ),
          child: _isLoading
              ? const CircularProgressIndicator(color: Colors.white)
              : Text(
                  'LOGIN',
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

  Widget _buildDivider() {
    return FadeAnimation(
      delay: 0.8,
      child: Row(
        children: [
          const Expanded(child: Divider(color: Colors.black12)),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Text(
              'Or continue with',
              style: GoogleFonts.inter(color: Colors.black38, fontSize: 13.sp),
            ),
          ),
          const Expanded(child: Divider(color: Colors.black12)),
        ],
      ),
    );
  }

  Widget _buildSocialButtons() {
    return FadeAnimation(
      delay: 0.9,
      child: Center(
        child: _SocialButton(
          imagePath: "images/Google.png",
          label: "Continue with Google",
          onTap: () {
            // Handle Google Login
          },
        ),
      ),
    );
  }

  Widget _buildSignUpLink() {
    return FadeAnimation(
      delay: 1.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Don't have an account?",
            style: GoogleFonts.inter(color: Colors.black54, fontSize: 14.sp),
          ),
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SignupScreen()),
              );
            },
            child: Text(
              "Sign Up",
              style: GoogleFonts.inter(
                color: const Color(0xFF5D4037),
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

  const _CustomTextField({
    required this.label,
    required this.hint,
    this.isPassword = false,
    required this.icon,
    required this.controller,
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
            color: const Color(0xFF3E2723),
          ),
        ),
        SizedBox(height: 8.h),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
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
            style: GoogleFonts.inter(fontSize: 16.sp, color: Colors.black87),
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: GoogleFonts.inter(color: Colors.black38),
              prefixIcon: Icon(icon, color: const Color(0xFF8D6E63)),
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

  const _SocialButton({
    this.icon,
    this.imagePath,
    required this.label,
    required this.onTap,
  }) : assert(icon != null || imagePath != null);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(30),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: Colors.black12),
          boxShadow: [
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
              Icon(icon, size: 24.sp, color: const Color(0xFF5D4037)),
            SizedBox(width: 12.w),
            Text(
              label,
              style: GoogleFonts.inter(
                fontSize: 15.sp,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
