import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tsb_mini/frame/button/back_button.dart';
import 'package:tsb_mini/frame/button/filter_btn_button.dart';
import 'package:tsb_mini/frame/button/reward_filter_button.dart';
import 'package:tsb_mini/frame/button/heart_button.dart';
import 'package:tsb_mini/frame/button/qr_scan_button.dart';
import 'package:tsb_mini/theme/color_theme.dart';

class MerchantAppBar extends StatelessWidget {
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

  const MerchantAppBar({
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
    this.enableFilterPoint = false,
    this.enableSearch = false,
    this.searchController,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity, // make background full width
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/image/app_bar_01.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: SafeArea(
        bottom: false, // prevents double padding
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // 🔹 Top Row (Back, Title, Right Icon)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (enableBack) FrostedBackButton(onBack: onTapBack),
                  Expanded(
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

              // 🔹 Second Row — Search Bar (only if enabled)
              if (enableSearch) ...[
                const SizedBox(height: 15),
                Container(
                  height: 42,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: TextField(
                    controller: searchController,
                    style: const TextStyle(fontSize: 14),
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.search, color: Colors.black54),
                      hintText: "Search merchant",
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(vertical: 10),
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
