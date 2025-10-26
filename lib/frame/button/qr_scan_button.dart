import 'package:flutter/material.dart';
import 'package:tsb_mini/package_mode.dart';
import 'package:tsb_mini/theme/color_theme.dart';
import 'package:google_fonts/google_fonts.dart';

class ScanButton extends StatelessWidget {
  final VoidCallback? onScan;

  const ScanButton({super.key, this.onScan});

  // @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (onScan != null) {
          onScan!();
        } else {
          _showQrCode(context);
        }
      },
      borderRadius: BorderRadius.circular(30),
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.25), // Frosted glass effect
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

  void _showQrCode(BuildContext context, {bool keepBottomNavVisible = false}) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      enableDrag: true,
      useSafeArea: true,
      backgroundColor: Colors.transparent,
      barrierColor: keepBottomNavVisible
          ? AppColors.barrierBackgroundColor
          : AppColors.barrierBackgroundColor.withOpacity(0.7),
      transitionAnimationController: AnimationController(
        vsync: Navigator.of(context),
        duration: const Duration(milliseconds: 400),
        reverseDuration: const Duration(milliseconds: 350),
      ),
      builder: (context) {
        return DraggableScrollableSheet(
          expand: false,
          initialChildSize: 0.45,
          minChildSize: 0.3,
          maxChildSize: 0.9,
          builder: (context, scrollController) {
            return Container(
              decoration: const BoxDecoration(
                color: AppColors.cardBackground,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(43),
                  topRight: Radius.circular(43),
                ),
              ),
              child: SingleChildScrollView(
                controller: scrollController,
                child: Padding(
                  padding: EdgeInsets.only(
                    left: 20,
                    right: 20,
                    bottom: MediaQuery.of(context).viewInsets.bottom,
                    top: 0,
                  ),
                  child: _qrBuild(context),
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _qrBuild(BuildContext context) {
    return Container(
      height: 350,
      decoration: const BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(43),
          topRight: Radius.circular(43),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.only(
          left: 20,
          right: 20,
          bottom: MediaQuery.of(context).viewInsets.bottom,
          top: 0,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 10, top: 20),
                child: Text(
                  'John Doe (10000001100)',
                  style: GoogleFonts.inter(
                    fontSize: 18,
                    color: const Color(0XFF262628),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Text(
                  'Scan My QR',
                  style: GoogleFonts.inter(
                    fontSize: 18,
                    color: const Color(0XFF083F8C),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 15),
                child: PackageAssets.image(
                  "assets/image/qr_scan.png",
                  height: 150,
                  width: 150,
                  fit: BoxFit.cover,
                ),
              ),
              _actionButtons(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _actionButtons() {
    return Center(
      child: SizedBox(
        width: 150,
        child: ElevatedButton(
          onPressed: () {
            // Save QR image logic here
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF083F8C),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            padding: const EdgeInsets.symmetric(vertical: 5),
            elevation: 0,
          ),
          child: Text(
            'Save Image',
            style: GoogleFonts.inter(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
