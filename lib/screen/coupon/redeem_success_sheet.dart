import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tsb_main/utils/localization/app_localizations.dart';
import 'package:tsb_mini/frame/app_bar/reward_sliver_app_bar.dart';
import 'package:tsb_mini/package_mode.dart';
import 'package:tsb_mini/screen/coupon/my_coupon_home_page.dart';
import 'package:tsb_mini/screen/home/home_page.dart';
import 'package:tsb_mini/theme/color_theme.dart';

class SuccessGetRewardSheet extends StatelessWidget {
  final VoidCallback onBackToReward;

  const SuccessGetRewardSheet({required this.onBackToReward, super.key});

  @override
  Widget build(BuildContext context) {
    //  Get localization instance
    final localize = AppLocalizations.of(context)!;

    return Container(
      padding: const EdgeInsets.fromLTRB(24, 32, 24, 24),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          //  Success icon
          PackageAssets.image(
            'assets/reward/correct_sign.png',
            width: 55,
            height: 55,
            fit: BoxFit.contain,
          ),

          const SizedBox(height: 16),

          // Title
          Text(
            "Get Reward Successfully!",
            style: GoogleFonts.inter(
              fontWeight: FontWeight.w600,
              fontSize: 18,
              color: Colors.black,
            ),
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: 12),

          // Description
          Text(
            "You've successfully to get reward.\n"
            "Check your inbox or reward history for more details.",
            style: GoogleFonts.inter(
              fontWeight: FontWeight.w500,
              fontSize: 12,
              color: AppColors.textLightFrosted,
            ),
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: 28),

          // Button
          SizedBox(
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
                Navigator.pop(context); // Close sheet first
                // Navigator.pushReplacement(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => RewardPage(
                //       localize: localize, // Correct instance
                //     ),
                //   ),
                // );
              },
              child: Text(
                "Back To Reward",
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
