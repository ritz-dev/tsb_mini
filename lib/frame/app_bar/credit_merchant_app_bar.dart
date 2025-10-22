import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tsb_mini/frame/button/back_button.dart';
import 'package:tsb_mini/frame/button/filter_btn_button.dart';
import 'package:tsb_mini/frame/button/reward_filter_button.dart';
import 'package:tsb_mini/frame/button/heart_button.dart';
import 'package:tsb_mini/frame/button/qr_scan_button.dart';
import 'package:tsb_mini/theme/color_theme.dart';

class CreditMerchantAppBar extends StatelessWidget
    implements PreferredSizeWidget {
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
  Size get preferredSize => const Size.fromHeight(140); // increased for 2 rows

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/image/app_bar_bg.png'),
          fit: BoxFit.cover,
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Top Row: Back button, title, right buttons
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.deepPurpleAccent, width: 1),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (enableBack)
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.orange , width: 1),
                      ),
                      child: FrostedBackButton(onBack: onTapBack))
                  else
                    const SizedBox(width: 40),
              
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
            ),

            const SizedBox(height: 10),

              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.deepPurpleAccent , width: 1),
                ),
                child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (enableBack)
                    FrostedBackButton(onBack: onTapBack)
                  else
                    const SizedBox(width: 40),
                
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
              ),
            

            
            // spacing between rows
            // Bottom Row: Optional search bar or other controls
            // if (enableSearch)
            //   Container(
            //     height: 40,
            //     padding: const EdgeInsets.symmetric(horizontal: 10),
            //     decoration: BoxDecoration(
            //       color: Colors.white.withOpacity(0.2),
            //       borderRadius: BorderRadius.circular(10),
            //     ),
            //     child: TextField(
            //       controller: searchController,
            //       style: const TextStyle(color: Colors.white),
            //       decoration: const InputDecoration(
            //         hintText: "Search",
            //         hintStyle: TextStyle(color: Colors.white70),
            //         border: InputBorder.none,
            //         icon: Icon(Icons.search, color: Colors.white),
            //       ),
            //     ),
            //   ),
          ],
        ),
      ),
    );
  }
}
