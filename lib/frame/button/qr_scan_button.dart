
import 'package:flutter/material.dart';
import 'package:tsb_mini/package_mode.dart';
import 'package:tsb_mini/screen/coupon/my_coupon.dart';
import 'package:tsb_mini/screen/coupon/reward_merchant_scan.dart';

class ScanButton extends StatelessWidget {
  final VoidCallback? onScan;

  const ScanButton({super.key, this.onScan});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap:
          onScan ??
          () async {
            await Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const RewardMarchantScan(),
              ),
            );
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const MyCouponPage()),
            );
          },
      borderRadius: BorderRadius.circular(30),
      child: Container(
        width: 45,
        height: 45,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(
            0.25,
          ), // Semi-transparent for glass effect
          shape: BoxShape.circle,
          border: Border.all(
            color: Colors.white.withOpacity(0.2), // Light border for depth
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: Color(0XFF4069A2).withOpacity(0.05),
              offset: const Offset(2, 4),
              blurRadius: 8,
            ),
          ],
          backgroundBlendMode: BlendMode.overlay,
        ),
        child: Center(
          child: PackageAssets.image(
            "assets/icon/scan_merchant.png",
            width: 20,
            height: 20,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
