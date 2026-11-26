import 'dart:ui';
import 'dart:convert'; // Added for Base64
import 'package:carousel_slider/carousel_slider.dart';
import 'package:chiyagaram/responsive/size_config.dart';
import 'package:chiyagaram/theme/app_colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// Recommendation Item Model
class RecommendationItem {
  final String name;
  final String? imagePath; // Kept for backward compatibility if needed
  final String? imageBase64; // Changed from imageUrl to imageBase64
  final String price;
  final String description;
  final String rating;

  RecommendationItem({
    required this.name,
    this.imagePath,
    this.imageBase64,
    required this.price,
    required this.description,
    required this.rating,
  });

  factory RecommendationItem.fromMap(Map<String, dynamic> map) {
    return RecommendationItem(
      name: map['name'] ?? 'Untitled',
      imageBase64: map['imageUrl'] ?? map['imageBase64'], // Support both names
      price: map['price'] ?? 'Rs. 0',
      description: map['description'] ?? '',
      rating: map['rating'] ?? '5.0',
    );
  }
}

// Recommendation Section Widget
class RecommendationSection extends StatelessWidget {
  final bool isDark;
  const RecommendationSection({super.key, required this.isDark});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('recommendations_list')
          .snapshots(),
      builder: (context, snapshot) {
        // Default Fallback Items (Restoring Original Design)
        final List<RecommendationItem> defaultItems = [
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

        final docs = snapshot.data?.docs ?? [];
        // Sort documents by ID
        final sortedDocs = docs.toList()..sort((a, b) => a.id.compareTo(b.id));

        List<RecommendationItem> items = [];

        if (sortedDocs.isNotEmpty) {
          items = sortedDocs
              .map(
                (doc) => RecommendationItem.fromMap(
                  doc.data() as Map<String, dynamic>,
                ),
              )
              .toList();
        }

        // Use default items if Firestore is empty or loading
        if (items.isEmpty) {
          items = defaultItems;
        }

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
                      color: isDark ? Colors.white : const Color(0xFF4E342E),
                    ),
                  ),
                  const Spacer(),
                  Container(
                    width: 50.w,
                    height: 1.5,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          (isDark ? Colors.white : const Color(0xFF8D6E63))
                              .withValues(alpha: 0.4),
                          (isDark ? Colors.white : const Color(0xFF8D6E63))
                              .withValues(alpha: 0),
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
              itemCount: items.length,
              itemBuilder: (context, index, realIndex) {
                return RecommendationCard(item: items[index], isDark: isDark);
              },
            ),
          ],
        );
      },
    );
  }
}

// Recommendation Card Widget
class RecommendationCard extends StatelessWidget {
  final RecommendationItem item;
  final bool isDark;

  const RecommendationCard({
    super.key,
    required this.item,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120.w,
      margin: EdgeInsets.only(right: 16.w),
      decoration: BoxDecoration(
        color: isDark
            ? AppColors.igSurface.withValues(alpha: 0.6)
            : Colors.white.withValues(alpha: 0.4),
        borderRadius: BorderRadius.circular(24.w),
        border: Border.all(
          color: isDark
              ? AppColors.igBorder.withValues(alpha: 0.5)
              : Colors.white.withValues(alpha: 0.6),
          width: 1.5.w,
        ),
        boxShadow: [
          BoxShadow(
            color: (isDark ? Colors.black : const Color(0xFF8D6E63)).withValues(
              alpha: 0.1,
            ),
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
                  color: isDark
                      ? Colors.white.withValues(alpha: 0.1)
                      : Colors.white.withValues(alpha: 0.3),
                  boxShadow: [
                    BoxShadow(
                      color: (isDark ? Colors.black : const Color(0xFF5D4037))
                          .withValues(alpha: 0.1),
                      blurRadius: 10.w,
                      offset: Offset(0, 4.h),
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(6.0),
                child: Hero(
                  tag: item.name,
                  child: ClipOval(
                    child:
                        item.imageBase64 != null && item.imageBase64!.isNotEmpty
                        ? (item.imageBase64!.startsWith('http')
                              ? Image.network(
                                  item.imageBase64!,
                                  fit: BoxFit.cover,
                                  width: 85.w,
                                  height: 85.w,
                                  errorBuilder: (context, error, stackTrace) =>
                                      Image.asset(
                                        "images/chiya.png",
                                        fit: BoxFit.cover,
                                        width: 85.w,
                                        height: 85.w,
                                      ),
                                )
                              : Image.memory(
                                  base64Decode(item.imageBase64!),
                                  fit: BoxFit.cover,
                                  width: 85.w,
                                  height: 85.w,
                                  errorBuilder: (context, error, stackTrace) =>
                                      Image.asset(
                                        "images/chiya.png",
                                        fit: BoxFit.cover,
                                        width: 85.w,
                                        height: 85.w,
                                      ),
                                ))
                        : Image.asset(
                            item.imagePath ?? "images/chiya.png",
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
                              color: isDark
                                  ? Colors.white
                                  : const Color(0xFF3E2723),
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
                              color: isDark
                                  ? AppColors.igTextSecondary
                                  : const Color(
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
