import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tsb_main/frame/navigation/bottom_navigation_frame.dart';
import 'package:tsb_mini/frame/app_bar/reward_detail_app_bar.dart';
import 'package:tsb_mini/package_mode.dart';
import 'package:tsb_mini/qr_scan_page.dart';
import 'package:tsb_mini/screen/coupon/redeem_success_sheet.dart';
import 'package:tsb_mini/screen/reward_detail/reward_detail_content.dart';
import 'package:tsb_main/utils/localization/app_localizations.dart';
import 'package:tsb_mini/frame/button/reward_back_button.dart';
import 'package:tsb_mini/theme/color_theme.dart';
import 'package:tsb_mini/screen/coupon/comfirm_and_success_sheet.dart';

class RewardDetailTest extends StatefulWidget {
  final String status; // Active | Used | Expired
  const RewardDetailTest({super.key, this.status = "Active"});

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
    // Determine button text based on status
    String? buttonText;
    if (widget.status == "Active") {
      buttonText = "Scan Merchant QR";
    } else if (widget.status == "Used") {
      buttonText = "Redeem";
    } else if (widget.status == "Expired") {
      buttonText = null; // No button
    }

    return Scaffold(
      body: Stack(
        children: [
          // 🔹 Scrollable content
          SafeArea(
            top: false,
            child: CustomScrollView(
              slivers: [
                // App bar + logo
                SliverToBoxAdapter(
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      SizedBox(height: 230, child: const RewardDetailAppBar()),
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

                // 🔹 White rounded content area
                SliverToBoxAdapter(
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(22),
                      topRight: Radius.circular(22),
                    ),
                    child: Container(
                      padding: const EdgeInsets.only(top: 40, bottom: 60),
                      color: Colors.white,
                      child: RewardDetailContent(
                        used: widget.status == "Used" ? 1 : 0,
                        expired: widget.status == "Expired" ? 1 : 0,
                        active: widget.status == "Active" ? 1 : 0,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // 🔹 Fixed back button
          Positioned(
            top: 15,
            left: 20,
            child: SafeArea(
              bottom: false,
              child: RewardBackButton(
                onBack: () {
                  Navigator.of(context).pop();
                },
                localize: AppLocalizations.of(context)!,
              ),
            ),
          ),

          // 🔹 Conditional bottom button (Active / Used only)
          if (buttonText != null)
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
                        if (widget.status == "Used") {
                          // 🔹 Show success sheet for "Used"
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            backgroundColor: Colors.transparent,
                            builder: (context) => SuccessGetRewardSheet(
                              onBackToReward: () {
                                Navigator.pop(context);
                              },
                            ),
                          );
                        } else if (widget.status == "Active") {
                          // 🔹 Navigate to QRScannerPage
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const QRScannerPage(),
                            ),
                          );
                        }
                      },
                      child: Text(
                        buttonText,
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
      bottomNavigationBar: SafeArea(
        child: BottomNavigationFrame(
          selectedIndex: _selectedIndex,
          onItemTapped: _onItemTapped,
          localize: AppLocalizations.of(context)!,
        ),
      ),
    );
  }
}
