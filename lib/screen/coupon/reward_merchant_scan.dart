
import 'package:flutter/material.dart';
import 'package:tsb_mini/frame/app_bar/credit_scan_app_bar.dart';
import 'package:tsb_mini/package_mode.dart';
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
        child: Column(
          children: [
            SizedBox(height: height * 0.08), // Responsive spacing
            // QR Frame Box
            Container(
              width: width * 0.6,
              height: width * 0.6, // keep it square
              padding: EdgeInsets.symmetric(vertical: height * 0.04),
              decoration: BoxDecoration(
                color: const Color(0xFFE4E7EC),
                borderRadius: BorderRadius.circular(15),
              ),
              child: PackageAssets.image(
                'assets/image/qr_scan.png',
                fit: BoxFit.contain,
              ),
            ),

            SizedBox(height: height * 0.03),

            // Instruction Text
            Text(
              "Place the code inside the frame",
              style: TextStyle(
                color: AppColors.textFrosted,
                fontSize: width * 0.04, // scale font
              ),
            ),

            const Spacer(), // pushes button to bottom-ish
            // Button
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
                      fontSize: width * 0.04, // responsive font size
                    ),
                  ),
                ),
              ),
            ),

            SizedBox(height: height * 0.05),
          ],
        ),
      ),
    );
  }
}
