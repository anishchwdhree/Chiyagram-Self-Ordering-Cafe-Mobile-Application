import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:chiyagaram/responsive/size_config.dart';
import 'package:chiyagaram/theme/app_colors.dart';
import 'package:chiyagaram/theme/theme_provider.dart';
import 'package:provider/provider.dart';

class LocationsScreen extends StatefulWidget {
  const LocationsScreen({super.key});

  @override
  State<LocationsScreen> createState() => _LocationsScreenState();
}

class _LocationsScreenState extends State<LocationsScreen> {
  bool _isExpanded = false;
  bool _isEnglishExpanded = false;

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDark = themeProvider.isDarkMode;
    final textColor = isDark ? Colors.white : const Color(0xFF3E2723);
    final subTextColor = isDark ? Colors.white70 : const Color(0xFF795548);
    final containerColor = isDark
        ? AppColors.igSurface.withValues(alpha: 0.6)
        : Colors.white.withValues(alpha: 0.5);

    return Stack(
      children: [
        // ... (Background sections remain unchanged)
        // 1. Background Gradient
        RepaintBoundary(
          child: DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: isDark
                    ? [
                        AppColors.igBlack,
                        AppColors.igDarkGrey,
                        AppColors.igBlack,
                      ]
                    : [
                        const Color(0xFFFFF3E0),
                        const Color(0xFFFFECB3),
                        const Color(0xFFFBE9E7),
                      ],
              ),
            ),
            child: const SizedBox.expand(),
          ),
        ),

        // 2. Background Shapes
        Stack(
          children: [
            Positioned(
              top: -50.h,
              right: -50.w,
              child: _buildBackgroundCircle(
                200.w,
                isDark ? AppColors.igSurface : const Color(0xFFFFCCBC),
                0.4,
              ),
            ),
            Positioned(
              bottom: 100.h,
              left: -30.w,
              child: _buildBackgroundCircle(
                140.w,
                isDark ? AppColors.igDarkGrey : const Color(0xFFFFE0B2),
                0.3,
              ),
            ),
          ],
        ),

        // 3. Content
        SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Our Locations & About Us",
                      style: GoogleFonts.philosopher(
                        fontSize: 25.sp,
                        fontWeight: FontWeight.bold,
                        color: textColor,
                      ),
                    ),
                    SizedBox(height: 5.h),
                    Text(
                      "Discover our story and find us nearby",
                      style: GoogleFonts.outfit(
                        fontSize: 16.sp,
                        color: subTextColor,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  children: [
                    SizedBox(height: 20.h),
                    // History Image
                    Center(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16.w),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.1),
                              blurRadius: 10,
                              offset: const Offset(0, 5),
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16.w),
                          child: Image.asset(
                            'images/histoy.png',
                            width: double.infinity,
                            height: 230.h,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 25.h),

                    // Nepali Story Section
                    Container(
                      padding: EdgeInsets.all(20.w),
                      decoration: BoxDecoration(
                        color: containerColor,
                        borderRadius: BorderRadius.circular(20.w),
                        border: Border.all(
                          color: textColor.withValues(alpha: 0.1),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "हाम्रो कथा (Our Story)",
                            style: GoogleFonts.philosopher(
                              fontSize: 22.sp,
                              fontWeight: FontWeight.bold,
                              color: textColor,
                            ),
                          ),
                          SizedBox(height: 15.h),
                          Text(
                            "चियाग्रामको सुरुवात सुरज श्रेष्ठले गरेका हुन् । उनले १३ वर्ष विदेशमा काम गरेपछि नेपालमै केही अर्थपूर्ण काम गर्ने निर्णय गरे । सुरुमा के व्यवसाय गर्ने भन्ने स्पष्ट नभएकाले उनले तीन वर्षसम्म बजार अध्ययन गरे — मानिसहरू के खान रुचाउँछन्, कहाँ बस्न मन पराउँछन् र कुन किसिमका खाजा धेरैलाई मन पर्छ भन्ने कुरा बुझ्दै । अन्ततः मंसिर महिनामा (डिसेम्बर/जनवरीतिर) उनले तिलोत्तमा नगरपालिका–३, योगीकुटीमा चियाग्राम सञ्चालनमा ल्याए, जसलाई उनले “सहरभित्रको गाउँ”को रूपमा विकास गरे । यो स्थान कुनै आधुनिक र भव्य रेस्टुरेन्टजस्तो नभई परम्परागत गाउँको झल्को दिने डिजाइनमा बनाइएको छ — खरको छाना, पुराना लालटिन, रेडियो, बाँसका टोपी, केतली, टायरका सिट र मानिसहरू बस्न, गफ गर्न तथा आराम गर्न मिल्ने खुला ठाउँहरू छन् । सुरज प्रायः आफैं चियाग्राममै बसेर ग्राहकहरूसँग कुरा गर्ने र सुधार गर्दै जाने गर्छन् । यहाँ चुकौनी, चाउचाउ, बटुक, पकौडा र सेलरोटीजस्ता परम्परागत स्थानीय परिकारहरू पाइन्छन्, जुन ग्राहकका मनपर्ने बनेका छन् । चियाग्रामको अर्को विशेषता भनेको खान मिल्ने कपमा चिया हो — चिया पिएपछि कप नै बिस्कुटझैँ खान मिल्छ । यो विचार सुरजले भारतको कोलकातास्थित एउटा क्याफेको भिडियो इन्स्टाग्राममा देखेपछि पाएका हुन् । सुरुमा उनले नेपालगञ्जदेखि काठमाडौंसम्म कप खोजे र अन्ततः काठमाडौंमै आपूर्तिकर्ता भेट्टाए । खान मिल्ने कप निकै लोकप्रिय बनेपछि धेरै ग्राहकले फोटो र भिडियो सामाजिक सञ्जालमा पोस्ट गर्न थाले, जसले चियाग्रामको चर्चा झन् बढायो । हाल उनीहरूले दैनिक करिब २०० वटा खान मिल्ने कपमा चिया बिक्री गर्छन् । आधुनिक शैलीमा परम्परागत स्वाद प्रस्तुत गरेर युवापुस्तालाई नेपाली खानपान संस्कृतिसँग जोड्ने उद्देश्य सुरजको रहेको छ । उनका अनुसार चियाग्रामले सस्तो चिया र खाजा मात्र होइन, परम्परागत स्वादको संरक्षण पनि गर्र्छ । कहिलेकाहीँ विदेशमा बिताएको समयप्रति सोच्ने गरे पनि उनी अहिले नेपाली संस्कृति र चिया खाने सामाजिक शैलीसँग जोडिएको ब्रान्डका रूपमा चियाग्रामलाई अघि बढाउन केन्द्रित छन् । उनले यस व्यवसायमा करिब २५ लाख रुपैयाँ लगानी गरेका छन् र यसको लोकप्रियतामा सामाजिक सञ्जाल तथा इन्फ्लुएन्सरहरूको ठूलो भूमिका रहेको बताउँछन् । भविष्यमा पनि चियाग्रामलाई “सहरभित्रको गाउँ”कै पहिचानसहित विस्तार गर्ने योजना उनको छ ।",
                            textAlign: TextAlign.justify,
                            maxLines: _isExpanded ? null : 4,
                            overflow: _isExpanded
                                ? TextOverflow.visible
                                : TextOverflow.ellipsis,
                            style: GoogleFonts.outfit(
                              fontSize: 15.sp,
                              color: textColor.withValues(alpha: 0.8),
                              height: 1.6,
                            ),
                          ),
                          SizedBox(height: 10.h),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                _isExpanded = !_isExpanded;
                              });
                            },
                            child: Text(
                              _isExpanded ? "Show Less" : "Read More...",
                              style: GoogleFonts.outfit(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.bold,
                                color: subTextColor,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 20.h),

                    // English Nostalgia Section
                    Container(
                      padding: EdgeInsets.all(20.w),
                      decoration: BoxDecoration(
                        color: containerColor,
                        borderRadius: BorderRadius.circular(20.w),
                        border: Border.all(
                          color: textColor.withValues(alpha: 0.1),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "A Glimpse into the 80s & 90s",
                            style: GoogleFonts.philosopher(
                              fontSize: 22.sp,
                              fontWeight: FontWeight.bold,
                              color: textColor,
                            ),
                          ),
                          SizedBox(height: 15.h),
                          Text(
                            "Chiyagram is designed to remind people of the 1980s and 1990s lifestyle, when life was simpler and more connected. The place reflects the old village atmosphere where people used to gather to drink chiya, talk for hours, and enjoy small moments without mobile phones or social media. Items like old radios, lanterns, traditional kettles, bamboo hats, tire seats, and simple décor represent how people lived and relaxed during that time. In the 80’s and 90’s, chiya was not just a drink but a social habit, where friends, neighbors, and elders met to share stories and laughter. Chiyagram recreates that feeling inside the city, allowing today’s generation to experience the warmth, simplicity, and nostalgia of the past while enjoying traditional tea and snacks.",
                            textAlign: TextAlign.justify,
                            maxLines: _isEnglishExpanded ? null : 4,
                            overflow: _isEnglishExpanded
                                ? TextOverflow.visible
                                : TextOverflow.ellipsis,
                            style: GoogleFonts.outfit(
                              fontSize: 15.sp,
                              color: textColor.withValues(alpha: 0.8),
                              height: 1.6,
                            ),
                          ),
                          SizedBox(height: 10.h),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                _isEnglishExpanded = !_isEnglishExpanded;
                              });
                            },
                            child: Text(
                              _isEnglishExpanded ? "Show Less" : "Read More...",
                              style: GoogleFonts.outfit(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.bold,
                                color: subTextColor,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 100.h), // Bottom padding for navbar
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildBackgroundCircle(double size, Color color, double opacity) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
          colors: [
            color.withValues(alpha: opacity),
            color.withValues(alpha: 0.0),
          ],
          stops: const [0.2, 1.0],
        ),
      ),
    );
  }
}
