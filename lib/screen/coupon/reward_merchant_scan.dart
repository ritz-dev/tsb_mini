
import 'package:flutter/material.dart';
import 'package:tsb_mini/frame/app_bar/credit_scan_app_bar.dart';
import 'package:tsb_mini/package_mode.dart';
import 'package:tsb_mini/screen/coupon/qr_scan_card.dart';
import 'package:tsb_mini/theme/color_theme.dart';

class RewardMarchantScan extends StatefulWidget {
  const RewardMarchantScan({super.key});

  @override
  State<RewardMarchantScan> createState() => _RewardMarchantScanState();
}

class _RewardMarchantScanState extends State<RewardMarchantScan> {
  @override
  Widget build(BuildContext context) {
    // Get screen size
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;

    return Scaffold(
      appBar: CreditScanAppBar(
        title: "Scan Merchant QR",
        enableBack: true,
        enableLight: true,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: const Color(0xFF224474),
        child:Padding(
        padding: const EdgeInsets.only(top: 0, bottom: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Center the QR frame column vertically
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center, // center vertically
                mainAxisSize: MainAxisSize.min,
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        width: width * 0.7,
                        height: width * 0.7,
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          color: const Color(0xFFE4E7EC),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Center(
                          child: PackageAssets.image(
                            'assets/image/qr_scan.png',
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      // QR corner border overlay
                      CustomPaint(
                        size: Size(width * 0.78, width * 0.78),
                        painter: QRCornersPainter(
                          color: const Color(0XFF5E7699),
                          strokeWidth: 3,
                          cornerLength: width * 0.08,
                          borderRadius: 20,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    "Place the code inside the frame",
                    style: TextStyle(
                      color: AppColors.textFrosted,
                      fontSize: width * 0.04,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),

            // Button stays at the bottom
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.1),
              child: SizedBox(
                width: double.infinity,
                height: height * 0.07,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF224474),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                      side: BorderSide(color: AppColors.textFrosted, width: 2),
                    ),
                  ),
                  onPressed: () {},
                  child: Text(
                    "Or Select from gallery",
                    style: TextStyle(
                      color: AppColors.textFrosted,
                      fontSize: width * 0.04,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),

      ),
    );
  }
}
