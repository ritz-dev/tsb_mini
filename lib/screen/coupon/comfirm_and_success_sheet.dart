import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tsb_mini/package_mode.dart';
import 'package:tsb_mini/theme/color_theme.dart';

class ConfirmCouponSheet extends StatelessWidget {
  final VoidCallback onUse;
  const ConfirmCouponSheet({required this.onUse, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 32, 24, 24),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Confirm Coupon Redemption",
            style: GoogleFonts.inter(
              fontWeight: FontWeight.w600,
              fontSize: 18,
              color: Colors.black,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 12),
          Text(
            "Are you sure you want to redeem this coupon?\nIt will no longer be available for future use.",
            style: GoogleFonts.inter(
              fontWeight: FontWeight.w500,
              fontSize: 12,
              color: AppColors.textLightFrosted,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 28),
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
              onPressed: onUse,
              child: Text(
                "Use",
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                backgroundColor: Color(0XFFEAEAEA) ,
                side: BorderSide(color: Colors.transparent),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                "Cancel",
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SuccessCouponSheet extends StatelessWidget {
  final VoidCallback onGoToReward;
  final VoidCallback onUseAgain;
  const SuccessCouponSheet({
    required this.onGoToReward,
    required this.onUseAgain,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 32, 24, 24),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
        PackageAssets.image(
            'assets/reward/correct_sign.png',
            width: 55,
            height: 55,
            fit: BoxFit.contain,
          ),

          const SizedBox(height: 16),
          Text(
            "Coupon Applied Successfully at Merchant Checkout",
            style: GoogleFonts.inter(
              fontWeight: FontWeight.w600,
              fontSize: 18,
              color: Colors.black,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 12),
          Text(
            "The coupon was successfully redeemed at the merchant's platform during checkout.",
            style: GoogleFonts.inter(
              fontWeight: FontWeight.w500,
              fontSize: 12,
              color: AppColors.textLightFrosted,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 28),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF0D47A1),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
              onPressed: onGoToReward,
              child: Text(
                "Go To My Reward",
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          // SizedBox(
          //   width: double.infinity,
          //   child: ElevatedButton(
          //     style: ElevatedButton.styleFrom(
          //       backgroundColor: const Color(0xFF083F8C),
          //       shape: RoundedRectangleBorder(
          //         borderRadius: BorderRadius.circular(24),
          //       ),
          //       padding: const EdgeInsets.symmetric(vertical: 12),
          //     ),
          //     onPressed: onUseAgain,
          //     child: Text(
          //       "Use Coupon Again",
          //       style: GoogleFonts.inter(
          //         fontWeight: FontWeight.w600,
          //         fontSize: 16,
          //         color: Colors.white,
          //       ),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
