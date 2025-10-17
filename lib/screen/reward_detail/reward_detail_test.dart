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
import 'package:tsb_mini/screen/reward_detail/reward_detail_content.dart';

class RewardDetailTest extends StatefulWidget {
  const RewardDetailTest({super.key});

  @override
  State<RewardDetailTest> createState() => _RewardDetailTestState();
}

class _RewardDetailTestState extends State<RewardDetailTest> {
  int _selectedIndex = 2;
  bool _isFavorited = false; // for future toggle state

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        top: false,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            // ─── Gradient Background ───────────────────────────────
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.topRight,
                  colors: [Color(0xFF0F533E), Color(0xFF0F533E)],
                ),
              ),
            ),

            // ─── Content Column (AppBar + Body) ───────────────────
            Column(
              children: [
                // Top image AppBar
                RewardDetailAppBar(
                  onTapBack: () {
                    Navigator.of(context).pop();
                  },
                ),

                // Body white card with rounded corners
                Expanded(
                  child: Container(
                    decoration:  BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(22),
                        topRight: Radius.circular(22),
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
                            padding: const EdgeInsets.only(top: 30),
                            // space for floating logo overlap
                            sliver: SliverToBoxAdapter(
                              child: RewardDetailContent(),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),

            // ─── Floating circular logo overlapping border ─────────
            Positioned(
              top: 200, // adjust this to align with card border visually
              left: 20,
              child: Material(
                elevation: 2,
                shape: const CircleBorder(),
                clipBehavior: Clip.antiAlias,
                child: Container(
                  width: 55,
                  height: 55,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: Image.asset(
                    'assets/icon/starbuck_detail.png',
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
          ],
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
