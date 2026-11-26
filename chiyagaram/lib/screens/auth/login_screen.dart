import 'dart:async';
import 'package:chiyagaram/services/google_auth_service.dart';
import 'package:chiyagaram/screens/auth/signup_screen.dart';
import 'package:chiyagaram/screens/auth/forgot_password_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:chiyagaram/theme/app_colors.dart';
import 'package:chiyagaram/theme/theme_provider.dart';
import 'package:chiyagaram/animations/fade_animation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:chiyagaram/responsive/size_config.dart';
import 'package:provider/provider.dart';
import 'package:chiyagaram/screens/widget/background_scaffold.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;
  bool _isPasswordVisible = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Initialize SizeConfig if not already done in AuthWrapper
    SizeConfig().init(context);

    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDark = themeProvider.isDarkMode;
    final textColor = isDark ? Colors.white : Colors.black87;

    return BackgroundScaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 100.h),
              FadeAnimation(
                delay: 0.1,
                child: Text(
                  'Welcome Back',
                  style: GoogleFonts.outfit(
                    fontSize: 32.sp,
                    fontWeight: FontWeight.bold,
                    color: textColor,
                    letterSpacing: -0.5,
                  ),
                ),
              ),
              FadeAnimation(
                delay: 0.2,
                child: Text(
                  'Login to your account',
                  style: GoogleFonts.inter(
                    fontSize: 16.sp,
                    color: isDark ? Colors.white70 : Colors.black45,
                  ),
                ),
              ),
              SizedBox(height: 48.h),
              _CustomTextField(
                label: 'Email Address',
                icon: Icons.email_outlined,
                controller: _emailController,
                isDark: isDark,
                textColor: textColor,
              ),
              SizedBox(height: 20.h),
              _CustomTextField(
                label: 'Password',
                icon: Icons.lock_outline,
                obscureText: !_isPasswordVisible,
                controller: _passwordController,
                isDark: isDark,
                textColor: textColor,
                suffixIcon: IconButton(
                  icon: Icon(
                    _isPasswordVisible
                        ? Icons.visibility_off
                        : Icons.visibility,
                    color: isDark ? Colors.white54 : Colors.black26,
                  ),
                  onPressed: () {
                    setState(() {
                      _isPasswordVisible = !_isPasswordVisible;
                    });
                  },
                ),
              ),
              SizedBox(height: 12.sp),
              FadeAnimation(
                delay: 0.3,
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
                      'Forgot Password?',
                      style: GoogleFonts.inter(
                        color: isDark ? AppColors.white : AppColors.secondary,
                        fontWeight: FontWeight.w600,
                        fontSize: 14.sp,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 32.h),
              _buildLoginButton(isDark),
              SizedBox(height: 32.h),
              _buildDivider(isDark),
              SizedBox(height: 32.h),
              _buildSocialButtons(isDark),
              SizedBox(height: 40.h),
              _buildSignUpLink(isDark),
              SizedBox(height: 24.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLoginButton(bool isDark) {
    return FadeAnimation(
      delay: 0.4,
      child: SizedBox(
        width: double.infinity,
        height: 45.h,
        child: ElevatedButton(
          onPressed: () async {
            if (_emailController.text.isEmpty ||
                _passwordController.text.isEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Please fill in all fields')),
              );
              return;
            }

            setState(() {
              _isLoading = true;
            });

            try {
              await FirebaseAuth.instance
                  .signInWithEmailAndPassword(
                    email: _emailController.text.trim(),
                    password: _passwordController.text.trim(),
                  )
                  .timeout(
                    const Duration(seconds: 15),
                    onTimeout: () {
                      throw TimeoutException(
                        'Login timed out. Please check your connection.',
                      );
                    },
                  );
              // AuthWrapper handles redirection
            } on FirebaseAuthException catch (e) {
              if (mounted) {
                setState(() {
                  _isLoading = false;
                });
                String message = 'An error occurred';
                if (e.code == 'user-not-found') {
                  message = 'No account found with this email.';
                } else if (e.code == 'wrong-password') {
                  message = 'Incorrect password. Please try again.';
                } else if (e.code == 'invalid-email') {
                  message = 'Please enter a valid email address.';
                } else if (e.code == 'too-many-requests') {
                  message = 'Too many attempts. Please try again later.';
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
            } on TimeoutException catch (e) {
              if (mounted) {
                setState(() {
                  _isLoading = false;
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(e.message ?? 'Login timed out.'),
                    backgroundColor: Colors.orange,
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
                : const Color.fromARGB(255, 3, 2, 2),
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

  Widget _buildDivider(bool isDark) {
    return FadeAnimation(
      delay: 0.8,
      child: Row(
        children: [
          Expanded(
            child: Divider(color: isDark ? Colors.white24 : Colors.black12),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Text(
              'Or continue with',
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
      delay: 0.9,
      child: Center(
        child: _SocialButton(
          imagePath: "images/Google.png",
          label: "Continue with Google",
          isDark: isDark,
          onTap: () async {
            try {
              await GoogleAuthService().signInWithGoogle();
            } catch (e) {
              if (mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Google Sign-In failed: ${e.toString()}'),
                  ),
                );
              }
            }
          },
        ),
      ),
    );
  }

  Widget _buildSignUpLink(bool isDark) {
    return FadeAnimation(
      delay: 1.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Don't have an account?",
            style: GoogleFonts.inter(
              color: isDark ? Colors.white54 : Colors.black54,
              fontSize: 14.sp,
            ),
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

class _SocialButton extends StatelessWidget {
  final String imagePath;
  final String label;
  final VoidCallback onTap;
  final bool isDark;

  const _SocialButton({
    required this.imagePath,
    required this.label,
    required this.onTap,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(30),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
        decoration: BoxDecoration(
          color: isDark ? Colors.white10 : Colors.white,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: isDark ? Colors.white24 : Colors.black12),
          boxShadow: [
            if (!isDark)
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(imagePath, height: 24.h),
            SizedBox(width: 12.w),
            Text(
              label,
              style: GoogleFonts.inter(
                fontWeight: FontWeight.w600,
                color: isDark ? Colors.white : Colors.black87,
                fontSize: 14.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CustomTextField extends StatelessWidget {
  final String label;
  final bool obscureText;
  final IconData icon;
  final TextEditingController controller;
  final bool isDark;
  final Color textColor;
  final Widget? suffixIcon;

  const _CustomTextField({
    required this.label,
    this.obscureText = false,
    required this.icon,
    required this.controller,
    required this.isDark,
    required this.textColor,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return FadeAnimation(
      delay: 0.2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: GoogleFonts.inter(
              color: isDark ? Colors.white70 : Colors.black54,
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 8.h),
          TextField(
            controller: controller,
            obscureText: obscureText,
            style: GoogleFonts.inter(color: textColor, fontSize: 16.sp),
            decoration: InputDecoration(
              hintStyle: GoogleFonts.inter(
                color: isDark ? Colors.white24 : Colors.black26,
                fontSize: 16.sp,
              ),
              prefixIcon: Icon(
                icon,
                color: isDark ? Colors.white54 : Colors.black38,
                size: 20.sp,
              ),
              suffixIcon: suffixIcon,
              filled: true,
              fillColor: isDark
                  ? Colors.white.withValues(alpha: 0.05)
                  : Colors.grey[50],
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(
                  color: isDark ? Colors.white10 : Colors.black12,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(
                  color: isDark ? Colors.white : AppColors.secondary,
                  width: 1.5,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
