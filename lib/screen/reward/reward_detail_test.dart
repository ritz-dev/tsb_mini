import 'package:flutter/material.dart';
import 'package:tsb_main/frame/navigation/bottom_navigation_frame.dart';
import 'package:tsb_main/package_mode.dart';
import 'package:tsb_main/screen/pass_main.dart';
import 'package:tsb_main/theme/color_theme.dart';
import 'package:tsb_main/utils/localization/app_localizations.dart';
import 'package:tsb_mini/frame/app_bar/credit_app_bar.dart';
import 'package:tsb_mini/frame/app_bar/reward_detail_app_bar.dart';
import 'package:tsb_mini/frame/app_bar/reward_sliver_app_bar.dart';
import 'package:tsb_mini/frame/body/home/famous_merchant.dart';
import 'package:tsb_mini/frame/body/home/food_slide.dart';
import 'package:tsb_mini/frame/body/home/latest_reward_card.dart';
import 'package:tsb_mini/frame/header/home/credit_reward_filter_header.dart';
import 'package:tsb_mini/screen/coupon/my_coupon_home_page.dart';
import 'package:tsb_mini/screen/home/home_page.dart';
import 'package:tsb_mini/screen/merchant/credit_merchant.dart';

class RewardDetailTest extends StatefulWidget {
  

  const  RewardDetailTest({super.key });

  @override
  State<RewardDetailTest> createState() => _RewardDetailTestState();
}

class _RewardDetailTestState extends State<RewardDetailTest> {
  int _selectedIndex = 2;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: RewardDetailAppBar(
        onTapBack: () {
         Navigator.of(context).pop();
        },
      ),
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            child: CustomScrollView(
              physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics(),
              ),
              slivers: [
           SliverPadding(
                  padding: const EdgeInsets.symmetric(),
                  sliver: SliverToBoxAdapter(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 12),

                        // Example reward card - you can replace with ListView.builder if multiple cards
                        GestureDetector(
                          onTap: () {
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //     builder: (_) => const RewardDetail(),
                            //   ),
                            // );
                          },
                          child: Container(
                            margin: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 8,
                            ),
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.05),
                                  blurRadius: 8,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Row(
                              children: [
                                PackageAssets.image(
                                  'assets/icon/starbuck.png',
                                  width: 60,
                                  height: 60,
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Free Handcrafted Drink',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 16,
                                          color: Colors.black,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        'Starbucks',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14,
                                          color: AppColors.textGrey,
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        'Expired on 22 October 2024',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 12,
                                          color: AppColors.textGrey,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 6,
                                  ),
                                  decoration: BoxDecoration(
                                    color: AppColors.textRed,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: const Text(
                                    'Expired',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        const SizedBox(height: 16),

                        // You can add more reward cards here or use a ListView.builder
                      ],
                    ),
                  ),
                ),

              ],
            ),
          ),
        ),
      ),
      // bottomNavigationBar: SafeArea(
      //   child: BottomNavigationFrame(
      //     selectedIndex: _selectedIndex,
      //     onItemTapped: _onItemTapped,
      //   ),
      // ),
    );
  }
}
