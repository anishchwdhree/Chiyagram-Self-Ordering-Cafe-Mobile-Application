import 'dart:ui';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:chiyagaram/responsive/size_config.dart';
import 'package:flutter/material.dart';

class HeroCarousel extends StatelessWidget {
  const HeroCarousel({super.key});

  @override
  Widget build(BuildContext context) {
    final List<int> items = [1, 2, 3, 4];

    return CarouselSlider(
      options: CarouselOptions(
        height: 180.h, // Rectangular height
        autoPlay: true,
        autoPlayInterval: const Duration(seconds: 3),
        enlargeCenterPage: true,
        viewportFraction: 0.8,
        aspectRatio: 2.0,
        initialPage: 0,
      ),
      items: items
          .map(
            (item) => Container(
              margin: EdgeInsets.all(5.0.w),
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(20.0.w)),
                child: Stack(
                  children: <Widget>[
                    // Glassmorphic Container Background
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.3),
                        borderRadius: BorderRadius.circular(20.w),
                        border: Border.all(
                          color: Colors.white.withValues(alpha: 0.4),
                          width: 1.5.w,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(
                              0xFF8D6E63,
                            ).withValues(alpha: 0.1),
                            blurRadius: 15.w,
                            offset: Offset(0, 8.h),
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20.w),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                          child: const SizedBox.expand(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
          .toList(),
    );
  }
}
