import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tsb_mini/frame/app_bar/reward_detail_app_bar.dart';
import 'package:tsb_mini/package_mode.dart';
import 'package:tsb_mini/screen/reward_detail/reward_detail_content.dart';

class RewardDetailTest extends StatefulWidget {
  const RewardDetailTest({super.key});

  @override
  State<RewardDetailTest> createState() => _RewardDetailTestState();
}

class _RewardDetailTestState extends State<RewardDetailTest> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Use Stack to make button sticky at the bottom
      body: Stack(
        children: [
          SafeArea(
            top: false,
            child: CustomScrollView(
              slivers: [
                // App bar + floating logo
                SliverToBoxAdapter(
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      // App bar background
                      SizedBox(
                        height: 230,
                        child: RewardDetailAppBar(
                          onTapBack: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ),

                      // Floating circular logo (on top)
                      Positioned(
                        left: 20,
                        bottom: -30,
                        child: Material(
                          elevation: 1,
                          shape: const CircleBorder(),
                          clipBehavior: Clip.antiAlias,
                          child: Container(
                            width: 60,
                            height: 60,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                            ),
                            child: PackageAssets.image(
                              'assets/icon/starbuck_detail.png',
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // White rounded card area (scrollable content)
                SliverToBoxAdapter(
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(22),
                      topRight: Radius.circular(22),
                    ),
                    child: Container(
                      padding: const EdgeInsets.only(
                        top: 40,
                        bottom: 60,
                      ), // extra bottom padding for button
                      color: Colors.white,
                      child: const RewardDetailContent(),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Sticky button at bottom
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: SafeArea(
              top: false,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 8, 20, 12),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF083F8C),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    onPressed: () {
                      // Action for the button
                    },
                    child: Text(
                      "Scan Merchant QR",
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
