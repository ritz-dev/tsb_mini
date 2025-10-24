import 'package:flutter/material.dart';
import 'package:tsb_mini/package_mode.dart';
import 'package:tsb_mini/qr_scan_page.dart';
import 'package:tsb_mini/theme/color_theme.dart';
import 'package:google_fonts/google_fonts.dart';

class Scanner extends StatelessWidget {
  final VoidCallback? onScan;

  const Scanner({super.key, this.onScan});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        if (onScan != null) {
          onScan!();
        } else {
          // Navigate to QRScannerPage instead of showing the QR code bottom sheet
          final scannedValue = await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const QRScannerPage()),
          );

          // Optional: handle the scanned value here
          if (scannedValue != null) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text('Scanned: $scannedValue')));
          }
        }
      },
      borderRadius: BorderRadius.circular(30),
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.25),
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: const Color(0XFF4069A2).withOpacity(0.01),
              offset: const Offset(2, 4),
              blurRadius: 8,
            ),
          ],
          backgroundBlendMode: BlendMode.overlay,
        ),
        child: Center(
          child: PackageAssets.image(
            "assets/icon/scan_merchant.png",
            width: 22,
            height: 22,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
