import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tsb_mini/frame/button/back_button.dart';
import 'package:tsb_mini/frame/button/filter_btn_button.dart';
import 'package:tsb_mini/frame/button/reward_filter_button.dart';
import 'package:tsb_mini/frame/button/heart_button.dart';
import 'package:tsb_mini/frame/button/qr_scan_button.dart';
import 'package:tsb_mini/theme/color_theme.dart';

class CreditMerchantAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  // Button actions
  final VoidCallback? onTapBack;
  final VoidCallback? onTapHeart;
  final VoidCallback? onTapFilter;
  final VoidCallback? onTapScan;
  final VoidCallback? onTapFilterPoint;

  // Controls
  final bool enableBack;
  final bool enableHeart;
  final bool enableFilter;
  final bool enableScan;
  final bool enableFilterPoint;
  final bool enableSearch;
  final TextEditingController? searchController;

  const CreditMerchantAppBar({
    super.key,
    required this.title,
    this.onTapBack,
    this.onTapHeart,
    this.onTapFilter,
    this.onTapScan,
    this.onTapFilterPoint,
    this.enableBack = true,
    this.enableHeart = false,
    this.enableFilter = false,
    this.enableScan = false,
    this.enableSearch = false,
    this.enableFilterPoint = false, // For Reward Card
    this.searchController,
  });

  @override
  Size get preferredSize => const Size.fromHeight(115);

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: preferredSize.height,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/image/app_bar_bg.png'),
          fit: BoxFit.cover,
        ),
      ),
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: SafeArea(
        child: Container(
          decoration:BoxDecoration(
            border: Border.all(color: Colors.cyanAccent ,  width: 1),
          ),
          child: Padding(
            padding: const EdgeInsets.only(top: 15, bottom: 15),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.purpleAccent , width: 1),
              ),
            child: Column(
                mainAxisSize:
                    MainAxisSize.min, // Important to avoid taking full height
                children: [
                  // Top Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      if (enableBack)
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.limeAccent,
                              width: 1,
                            ),
                          ),
                          child: FrostedBackButton(onBack: onTapBack),
                        ),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.deepOrangeAccent,
                              width: 1,
                            ),
                          ),
                          child: Text(
                            title,
                            textAlign: TextAlign.center,
                            style: GoogleFonts.inter(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: AppColors.textWhite,
                            ),
                          ),
                        ),
                      ),
                      if (enableHeart)
                        FrostedHeartButton(onNavigate: onTapHeart)
                      else if (enableFilter)
                        FilterButton(onFilter: onTapFilter)
                      else if (enableScan)
                        ScanButton(onScan: onTapScan)
                      else if (enableFilterPoint)
                        RewardFilterButton(onFilterPoint: onTapFilterPoint)
                      else
                        const SizedBox(width: 40),
                    ],
                  ),

                  const SizedBox(height: 10),
                       Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      if (enableBack)
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.limeAccent,
                              width: 1,
                            ),
                          ),
                          child: FrostedBackButton(onBack: onTapBack),
                        ),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.deepOrangeAccent,
                              width: 1,
                            ),
                          ),
                          child: Text(
                            title,
                            textAlign: TextAlign.center,
                            style: GoogleFonts.inter(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: AppColors.textWhite,
                            ),
                          ),
                        ),
                      ),
                      if (enableHeart)
                        FrostedHeartButton(onNavigate: onTapHeart)
                      else if (enableFilter)
                        FilterButton(onFilter: onTapFilter)
                      else if (enableScan)
                        ScanButton(onScan: onTapScan)
                      else if (enableFilterPoint)
                        RewardFilterButton(onFilterPoint: onTapFilterPoint)
                      else
                        const SizedBox(width: 40),
                    ],
                  ),
                  // spacing between rows
                  // New Row under the top row
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                  //   children: [
                  //     Container(
                  //       padding: const EdgeInsets.all(8),
                  //       color: Colors.blueAccent,
                  //       child: const Text(
                  //         'Button 1',
                  //         style: TextStyle(color: Colors.white),
                  //       ),
                  //     ),
                  //     Container(
                  //       padding: const EdgeInsets.all(8),
                  //       color: Colors.greenAccent,
                  //       child: const Text(
                  //         'Button 2',
                  //         style: TextStyle(color: Colors.white),
                  //       ),
                  //     ),
                  //     Container(
                  //       padding: const EdgeInsets.all(8),
                  //       color: Colors.redAccent,
                  //       child: const Text(
                  //         'Button 3',
                  //         style: TextStyle(color: Colors.white),
                  //       ),
                  //     ),
                  //   ],
                  // ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
