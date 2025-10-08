import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tsb_main/utils/localization/app_localizations.dart';
import 'package:tsb_mini/package_mode.dart';
import 'package:tsb_mini/theme/color_theme.dart';

class FoodSlideCard extends StatefulWidget {
  final String? title;
  const FoodSlideCard({super.key, this.title});

  @override
  State<FoodSlideCard> createState() => _FoodSlideCardState();
}

class _FoodSlideCardState extends State<FoodSlideCard> {
  List<Map<String, dynamic>> cardImages = [
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
    {
      "image": "assets/home_images/kfc2_latest_reward.png",
      "message": "buy_one_get_one",
      "point": "100",
      "name": "KFC",
    },
    {
      "image": "assets/home_images/starbucks_latest_reward.png",
      "message": "free_drink",
      "point": "100",
      "name": "Starbucks",
      "link": 1,
    },
    {
      "image": "assets/home_images/amazon_latest_reward.png",
      "message": "buy_9_get_1",
      "point": "100",
      "name": "Cafe Amazon",
    },
    {
      "image": "assets/home_images/starbucks2_latest_reward.png",
      "message": "sixty_percent_off",
      "point": "100",
      "name": "Starbucks",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 30),
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  // 'Food',
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
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => const RewardMarchant(),
                    //   ),
                    // );
                  },
                  child: Text(
                    // 'See more',
                    AppLocalizations.of(context)!.translate('see_more'),
                    style: GoogleFonts.inter(
                      color: const Color(0XFF1F258D),
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

        Container(
          margin: const EdgeInsets.only(bottom: 30),
          child: SizedBox(
            height: 230, // card height
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: cardImages.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(builder: (_) => RewardDetail()),
                    // );
                  },
                  child: Container(
                    margin: EdgeInsets.only(
                      left: index == 0 ? 20 : 10,
                      right: 10,
                      top: 0,
                      bottom: 0,
                    ),
                    width: 240, // card width
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.06),
                          blurRadius: 6,
                          offset: const Offset(0, 2),
                        ),
                      ],
                      color: Colors.white,
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        PackageAssets.image(
                          cardImages[index]["image"],
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: double.infinity,
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: ClipRRect(
                            borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(0),
                              bottomRight: Radius.circular(0),
                            ),
                            child: ClipRect(
                              child: BackdropFilter(
                                filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                                child: Container(
                                  color: AppColors.cardBackground.withOpacity(
                                    0.6,
                                  ),
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
                                        // cardImages[index]["message"] ?? "",
                                        AppLocalizations.of(context)!.translate(
                                          cardImages[index]["message"] ?? "",
                                        ),
                                        style: GoogleFonts.inter(
                                          color: const Color(0xFF083F8B),
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      Row(
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                              color:
                                                  AppColors.scaffoldBackground,
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                            margin: const EdgeInsets.symmetric(
                                              horizontal: 0,
                                              vertical: 0,
                                            ),
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 12,
                                              vertical: 6,
                                            ),
                                            child: Text(
                                              // "${cardImages[index]["point"]} points",
                                              "${cardImages[index]["point"]} ${AppLocalizations.of(context)!.translate('points')}",
                                              style: GoogleFonts.inter(
                                                color: const Color(0xFF083F8B),
                                                fontSize: 11,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 10),
                                          Expanded(
                                            child: Text(
                                              cardImages[index]["name"] ?? "",
                                              style: GoogleFonts.inter(
                                                color: const Color(0XFF000000),
                                                fontSize: 12,
                                                fontWeight: FontWeight.w500,
                                                letterSpacing: 0.5,
                                              ),
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
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
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
