import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:chiyagaram/responsive/size_config.dart';
import 'package:provider/provider.dart';
import 'package:chiyagaram/models/cart_model.dart';
import 'package:chiyagaram/theme/theme_provider.dart';

class GlassBottomNavBar extends StatefulWidget {
  final int currentIndex;
  final Function(int) onTap;

  const GlassBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  State<GlassBottomNavBar> createState() => _GlassBottomNavBarState();
}

class _GlassBottomNavBarState extends State<GlassBottomNavBar> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDark = themeProvider.isDarkMode;

    return Padding(
      padding: EdgeInsets.fromLTRB(20.w, 0, 20.w, 20.h),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(40.w),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 25, sigmaY: 25),
          child: Container(
            height: 72.h,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: isDark
                    ? [
                        Colors.black.withValues(alpha: 0.8),
                        Colors.black.withValues(alpha: 0.6),
                        Colors.black.withValues(alpha: 0.4),
                      ]
                    : [
                        Colors.white.withValues(alpha: 0.6),
                        Colors.white.withValues(alpha: 0.1),
                        Colors.white.withValues(alpha: 0.05),
                      ],
                stops: const [0.0, 0.3, 1.0],
              ),
              borderRadius: BorderRadius.circular(40.w),
              border: Border.all(
                color: isDark
                    ? Colors.white.withValues(alpha: 0.1)
                    : Colors.white.withValues(alpha: 0.3),
                width: 1.0.w,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1),
                  blurRadius: 20.w,
                  spreadRadius: -2.w,
                  offset: Offset(0, 10.h),
                ),
              ],
            ),
            child: Consumer<CartModel>(
              builder: (context, cart, child) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildNavItem(Iconsax.home, Iconsax.home5, 0, null, isDark),
                    _buildNavItem(
                      Iconsax.menu_board,
                      Iconsax.menu_board5,
                      1,
                      null,
                      isDark,
                    ),
                    _buildNavItem(
                      Iconsax.shopping_cart,
                      Iconsax.shopping_cart5,
                      2,
                      cart.itemCount,
                      isDark,
                    ),
                    // _buildNavItem(Iconsax.location, Iconsax.location, 3, null),
                    _buildNavItem(Iconsax.user, Iconsax.user, 3, null, isDark),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(
    IconData icon,
    IconData activeIcon,
    int index,
    int? badgeCount,
    bool isDark,
  ) {
    final isSelected = widget.currentIndex == index;
    final showBadge = badgeCount != null && badgeCount > 0;

    return GestureDetector(
      onTap: () => widget.onTap(index),
      child: AnimatedScale(
        scale: isSelected ? 1.0 : 0.9,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOutBack,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOutQuad,
          padding: EdgeInsets.all(14.w),
          decoration: isSelected
              ? BoxDecoration(
                  color: isDark
                      ? Colors.white.withValues(alpha: 0.15)
                      : Colors.white.withValues(alpha: 0.4),
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: isDark
                        ? Colors.white.withValues(alpha: 0.2)
                        : Colors.white.withValues(alpha: 0.5),
                    width: 1.w,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: isDark
                          ? Colors.black.withValues(alpha: 0.2)
                          : Colors.white.withValues(alpha: 0.2),
                      blurRadius: 20.w,
                      spreadRadius: 2.w,
                    ),
                  ],
                )
              : const BoxDecoration(
                  color: Colors.transparent,
                  shape: BoxShape.circle,
                ),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 250),
                transitionBuilder: (Widget child, Animation<double> animation) {
                  return ScaleTransition(
                    scale: animation,
                    child: FadeTransition(opacity: animation, child: child),
                  );
                },
                child: Icon(
                  isSelected ? activeIcon : icon,
                  key: ValueKey<bool>(isSelected),
                  color: isSelected
                      ? (isDark ? Colors.white : Colors.black)
                      : (isDark
                            ? Colors.white60
                            : Colors.black.withValues(alpha: 0.6)),
                  size: 26.sp,
                ),
              ),
              if (showBadge)
                Positioned(
                  right: -4.w,
                  top: -4.w,
                  child: Container(
                    padding: EdgeInsets.all(4.w),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 1.5.w),
                    ),
                    constraints: BoxConstraints(
                      minWidth: 18.w,
                      minHeight: 18.w,
                    ),
                    child: Center(
                      child: Text(
                        badgeCount > 9 ? '9+' : badgeCount.toString(),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10.sp,
                          fontWeight: FontWeight.bold,
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
}
