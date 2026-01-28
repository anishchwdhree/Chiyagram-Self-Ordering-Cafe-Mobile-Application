import 'dart:ui';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:chiyagaram/responsive/size_config.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// Recommendation Item Model
class RecommendationItem {
  final String name;
  final String imagePath;
  final String price;
  final String description;
  final String rating;

  RecommendationItem({
    required this.name,
    required this.imagePath,
    required this.price,
    required this.description,
    required this.rating,
  });
}

// Recommendation Data
final List<RecommendationItem> recommendations = [
  RecommendationItem(
    name: "Masala Chiya",
    imagePath: "images/masal.png",
    price: "Rs. 50",
    description: "Spiced aromatic tea blend",
    rating: "4.9",
  ),
  RecommendationItem(
    name: "Steam Momos",
    imagePath: "images/momo.png",
    price: "Rs. 120",
    description: "Juicy dumplings with spices",
    rating: "4.8",
  ),
  RecommendationItem(
    name: "Eatable Chiya",
    imagePath: "images/eatable.png",
    price: "Rs. 120",
    description: "Eatable Chiya with milk.",
    rating: "4.8",
  ),
  RecommendationItem(
    name: "Pakauda",
    imagePath: "images/piyajpakauda.png",
    price: "Rs. 80",
    description: "Crispy onion fritters",
    rating: "4.7",
  ),
  RecommendationItem(
    name: "Wai Wai Sadeko",
    imagePath: "images/WaiWaiSadeko.png",
    price: "Rs. 80",
    description: "mix of noodles, onion, tomato, shallot, chilli sauce",
    rating: "4.7",
  ),
];

// Recommendation Section Widget
class RecommendationSection extends StatelessWidget {
  const RecommendationSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Section Header
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Row(
            children: [
              Text(
                "Recommendation",
                style: GoogleFonts.philosopher(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF4E342E),
                ),
              ),
              const Spacer(),
              Container(
                width: 50.w,
                height: 1.5,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      const Color(0xFF8D6E63).withValues(alpha: 0.4),
                      const Color(0xFF8D6E63).withValues(alpha: 0),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        const SizedBox(height: 10),
        // Recommendation Carousel
        CarouselSlider.builder(
          options: CarouselOptions(
            height: 170.h,
            viewportFraction: 0.35,
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 3),
            enableInfiniteScroll: true,
            padEnds: false,
            scrollPhysics: const BouncingScrollPhysics(),
          ),
          itemCount: recommendations.length,
          itemBuilder: (context, index, realIndex) {
            return RecommendationCard(item: recommendations[index]);
          },
        ),
      ],
    );
  }
}

// Recommendation Card Widget
class RecommendationCard extends StatelessWidget {
  final RecommendationItem item;

  const RecommendationCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120.w,
      margin: EdgeInsets.only(right: 16.w),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.4),
        borderRadius: BorderRadius.circular(24.w),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.6),
          width: 1.5.w,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF8D6E63).withValues(alpha: 0.1),
            blurRadius: 20.w,
            offset: Offset(0, 8.h),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24.w),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 10.h),
              // Round Image Section
              Container(
                width: 85.w,
                height: 85.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withValues(alpha: 0.3),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF5D4037).withValues(alpha: 0.1),
                      blurRadius: 10.w,
                      offset: Offset(0, 4.h),
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(6.0),
                child: Hero(
                  tag: item.name,
                  child: ClipOval(
                    child: Image.asset(
                      item.imagePath,
                      fit: BoxFit.cover,
                      width: 85.w,
                      height: 85.w,
                    ),
                  ),
                ),
              ),

              // Details Section
              Expanded(
                flex: 4,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(12.w, 8.h, 12.w, 12.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Text(
                            item.name,
                            textAlign: TextAlign.center,
                            style: GoogleFonts.philosopher(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFF3E2723),
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            item.description,
                            textAlign: TextAlign.center,
                            style: GoogleFonts.outfit(
                              fontSize: 11.sp,
                              color: const Color(
                                0xFF795548,
                              ).withValues(alpha: 0.8),
                              fontWeight: FontWeight.w400,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
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
}
