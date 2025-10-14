import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tsb_mini/frame/button/back_button.dart';
import 'package:tsb_mini/frame/button/filter_btn_button.dart';
import 'package:tsb_mini/frame/button/frosted_filter_button.dart';
import 'package:tsb_mini/frame/button/heart_button.dart';
import 'package:tsb_mini/frame/button/qr_scan_button.dart';
import 'package:tsb_mini/package_mode.dart';
import 'package:tsb_mini/theme/color_theme.dart';

class CreditHomeAppBar extends StatelessWidget
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

  const CreditHomeAppBar({
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
  });

  @override
  Size get preferredSize => const Size.fromHeight(115);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: preferredSize.height,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: PackageAssets.image(
            "assets/image/app_bar_bg.png",
            fit: BoxFit.cover,
          ).image, // <-- important: access the .image property
          fit: BoxFit.cover,
        ),
      ),

      padding: const EdgeInsets.only(left: 20, right: 20),
      child: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Back button (left side)
            if (enableBack)
              FrostedBackButton(onBack: onTapBack), // placeholder to keep spacing
            // Title (centered)
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

            // Filter button (right side)
            if (enableHeart)
              FrostedHeartButton(onNavigate: onTapHeart)
            else if (enableFilter)
              // for history page
              FilterButton(onFilter: onTapFilter) // placeholder for symmetry
            else if (enableScan)
              ScanButton(onScan: onTapScan)
            else if (enableFilterPoint)
              FrostedFilterButton(onFilterPoint: onTapFilterPoint)
            else
              const SizedBox(width: 40),
          ],
        ),
      ),
    );
  }
}
