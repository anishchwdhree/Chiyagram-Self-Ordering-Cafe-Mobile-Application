import 'dart:ui';
import 'dart:convert'; // Added for Base64
import 'package:carousel_slider/carousel_slider.dart';
import 'package:chiyagaram/responsive/size_config.dart';
import 'package:chiyagaram/theme/app_colors.dart';
import 'package:chiyagaram/theme/theme_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HeroCarousel extends StatefulWidget {
  const HeroCarousel({super.key});

  @override
  State<HeroCarousel> createState() => _HeroCarouselState();
}

class _HeroCarouselState extends State<HeroCarousel> {
  final ValueNotifier<int> _currentIndex = ValueNotifier<int>(0);
  final CarouselSliderController _controller = CarouselSliderController();

  @override
  void dispose() {
    _currentIndex.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDark = themeProvider.isDarkMode;

    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('banners_list').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Center(child: Text('Something went wrong'));
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return _buildLoadingState(isDark);
        }

        final docs = snapshot.data?.docs ?? [];
        final sortedDocs = docs.toList()..sort((a, b) => a.id.compareTo(b.id));

        if (sortedDocs.isEmpty) {
          return _buildEmptyState(isDark);
        }

        return Column(
          children: [
            CarouselSlider(
              key: const PageStorageKey('hero_carousel'),
              carouselController: _controller,
              options: CarouselOptions(
                height: 180.h,
                autoPlay: true,
                autoPlayInterval: const Duration(seconds: 4),
                autoPlayAnimationDuration: const Duration(milliseconds: 900),
                autoPlayCurve: Curves.easeInOutQuart,
                enlargeCenterPage: true,
                enlargeFactor: 0.22,
                viewportFraction: 0.86,
                aspectRatio: 2.0,
                initialPage: 0,
                enableInfiniteScroll: sortedDocs.length > 1,
                scrollPhysics: const BouncingScrollPhysics(),
                onPageChanged: (index, reason) {
                  _currentIndex.value = index;
                },
              ),
              items: sortedDocs.map((doc) {
                final data = doc.data() as Map<String, dynamic>;
                final String imageUrl = data['imageUrl'] ?? '';
                return Container(
                  margin: EdgeInsets.symmetric(vertical: 8.h),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(28.0.w)),
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: isDark
                          ? [
                              AppColors.igBorder.withValues(alpha: 0.3),
                              AppColors.igBorder.withValues(alpha: 0.1),
                            ]
                          : [
                              Colors.white.withValues(alpha: 0.8),
                              Colors.white.withValues(alpha: 0.4),
                            ],
                    ),
                    border: Border.all(
                      width: 2.5.w,
                      color: isDark
                          ? AppColors.igBorder.withValues(alpha: 0.6)
                          : Colors.white.withValues(alpha: 0.8),
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(26.0.w)),
                    child: Stack(
                      children: <Widget>[
                        _buildGlassCard(isDark),
                        imageUrl.isNotEmpty
                            ? (imageUrl.startsWith('http')
                                  ? Image.network(
                                      imageUrl,
                                      fit: BoxFit.cover,
                                      width: double.infinity,
                                      errorBuilder:
                                          (context, error, stackTrace) =>
                                              const Center(
                                                child: Icon(
                                                  Icons.error_outline,
                                                ),
                                              ),
                                    )
                                  : Image.memory(
                                      base64Decode(imageUrl),
                                      fit: BoxFit.cover,
                                      width: double.infinity,
                                      errorBuilder:
                                          (context, error, stackTrace) =>
                                              const Center(
                                                child: Icon(
                                                  Icons.error_outline,
                                                ),
                                              ),
                                    ))
                            : const Center(child: Icon(Icons.image)),
                        Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.transparent,
                                Colors.black.withValues(alpha: 0.05),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
            SizedBox(height: 10.h),
            ValueListenableBuilder<int>(
              valueListenable: _currentIndex,
              builder: (context, currentIndex, child) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: sortedDocs.asMap().entries.map((entry) {
                    final isSelected = currentIndex == entry.key;
                    return GestureDetector(
                      onTap: () => _controller.animateToPage(entry.key),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        width: isSelected ? 12.0.w : 6.0.w,
                        height: 5.0.h,
                        margin: EdgeInsets.symmetric(horizontal: 3.0.w),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color: isSelected
                              ? AppColors.primary
                              : AppColors.primary.withValues(alpha: 0.2),
                        ),
                      ),
                    );
                  }).toList(),
                );
              },
            ),
          ],
        );
      },
    );
  }

  Widget _buildGlassCard(bool isDark) {
    return Container(
      decoration: BoxDecoration(
        color: isDark
            ? AppColors.igSurface.withValues(alpha: 0.4)
            : Colors.white.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(26.w),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(26.w),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: const SizedBox.expand(),
        ),
      ),
    );
  }

  Widget _buildLoadingState(bool isDark) {
    return Container(
      height: 180.h,
      margin: EdgeInsets.symmetric(horizontal: 24.w),
      decoration: BoxDecoration(
        color: isDark
            ? AppColors.igSurface
            : Colors.white.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(28.w),
      ),
      child: const Center(child: CircularProgressIndicator()),
    );
  }

  Widget _buildEmptyState(bool isDark) {
    return Container(
      height: 180.h,
      margin: EdgeInsets.symmetric(horizontal: 24.w),
      decoration: BoxDecoration(
        color: isDark
            ? AppColors.igSurface
            : Colors.white.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(28.w),
      ),
      child: const Center(child: Text('No banners available')),
    );
  }
}
