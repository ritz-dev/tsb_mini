import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tsb_main/utils/localization/app_localizations.dart';
import 'package:tsb_mini/package_mode.dart';
import 'package:tsb_mini/screen/reward/latest_reward_collection.dart';
import 'package:tsb_mini/screen/reward_detail/reward_detail.dart';
import 'package:tsb_mini/theme/color_theme.dart';

class DrinkSlide extends StatefulWidget {
  final String? title;
  const DrinkSlide({super.key, this.title});

  @override
  State<DrinkSlide> createState() => _DrinkSlideState();
}

class _DrinkSlideState extends State<DrinkSlide> {
  List<Map<String, dynamic>> cardImages = [
     {
      "image": "assets/home_images/starbucks2_latest_reward.png",
      "message": "sixty_percent_off",
      "point": "100",
      "name": "Starbucks",
    },
    {
      "image": "assets/home_images/amazon_latest_reward.png",
      "message": "buy_9_get_1",
      "point": "100",
      "name": "Cafe Amazon",
    },
     {
      "image": "assets/home_images/starbucks_latest_reward.png",
      "message": "free_drink",
      "point": "100",
      "name": "Starbucks",
      "link": 1,
    },
    {
      "image": "assets/home_images/kfc2_latest_reward.png",
      "message": "buy_one_get_one",
      "point": "100",
      "name": "KFC",
    },
    {
      "image": "assets/home_images/kfc_latest_reward.png",
      "message": "free_bucket",
      "point": "100",
      "name": "KFC",
    },
    {
      "image": "assets/home_images/mc_latest_reward.png",
      "message": "free_drink",
      "point": "100",
      "name": "McDonald's",
    },   
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Title Row
        Container(
          margin: const EdgeInsets.only(bottom: 14),
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.title != null
                      ? AppLocalizations.of(context)!.translate(widget.title!)
                      : '',
                  style: GoogleFonts.inter(
                    color: const Color(0XFF000000),
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const RewardCollection(
                            selectedIndex: 1,
                        ),
                      ),
                    );
                  },
                  child: Text(
                    AppLocalizations.of(context)!.translate('see_more'),
                    style: GoogleFonts.inter(
                      color: const Color(0XFF083F8C),
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

        // Reward Card List
        Container(
          // color: Colors.purple,
          margin: const EdgeInsets.only(bottom: 15),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 0),
            child: SizedBox(
              height: 240,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: cardImages.length,
                itemBuilder: (context, index) {
                  final item = cardImages[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => RewardDetailTest(status: "Used"),
                        ),
                      );
                    },
                    child: Container(
                      margin: EdgeInsets.only(
                        left: index == 0 ? 20 : 10,
                        right: 10,
                        bottom: 10,
                      ),
                      child: Container(
                        width: 240,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.15),
                              blurRadius: 4,
                              offset: const Offset(0, 4), // shadow goes below
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Stack(
                            fit: StackFit.expand,
                            children: [
                              // Background image
                              PackageAssets.image(
                                item["image"],
                                fit: BoxFit.cover,
                                width: double.infinity,
                                height: double.infinity,
                              ),

                              // Bottom blur info
                              Align(
                                alignment: Alignment.bottomCenter,
                                child: RepaintBoundary(
                                  // Added to improve performance and prevent flicker
                                  child: ClipRect(
                                    child: BackdropFilter(
                                      filter: ImageFilter.blur(
                                        sigmaX: 15,
                                        sigmaY: 15,
                                      ),
                                      child: Container(
                                        color: AppColors.cardBackground
                                            .withOpacity(0.4),
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 16,
                                          vertical: 6,
                                        ),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              AppLocalizations.of(
                                                context,
                                              )!.translate(
                                                item["message"] ?? "",
                                              ),
                                              style: GoogleFonts.inter(
                                                color: AppColors.textBlack,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            const SizedBox(height: 8),
                                            Row(
                                              children: [
                                                Container(
                                                  decoration: BoxDecoration(
                                                    color: AppColors
                                                        .scaffoldBackground,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          20,
                                                        ),
                                                  ),
                                                  padding:
                                                      const EdgeInsets.symmetric(
                                                        horizontal: 12,
                                                        vertical: 6,
                                                      ),
                                                  child: Text(
                                                    "${item["point"]} ${AppLocalizations.of(context)!.translate('points')}",
                                                    style: GoogleFonts.inter(
                                                      color: const Color(
                                                        0xFF083F8B,
                                                      ),
                                                      fontSize: 11,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(width: 10),
                                                Expanded(
                                                  child: Text(
                                                    item["name"] ?? "",
                                                    style: GoogleFonts.inter(
                                                      color: const Color(
                                                        0XFF000000,
                                                      ),
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      letterSpacing: 0.5,
                                                    ),
                                                    maxLines: 2,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}
