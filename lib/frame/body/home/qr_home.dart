import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tsb_mini/package_mode.dart';
import 'package:tsb_mini/theme/color_theme.dart';

class QrHome extends StatefulWidget {
  final VoidCallback? onBack;

  const QrHome({super.key, this.onBack});

  @override
  State<QrHome> createState() => _FrostedQrHomeState();
}

class _FrostedQrHomeState extends State<QrHome> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onBack ?? () => _showQrCode(context),
      child: Container(
        height: 50.35,
        width: 52.09,
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.8),
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Icon(Icons.qr_code, color: Colors.white, size: 22),
      ),
    );
  }

  void _showQrCode(BuildContext context, {bool keepBottomNavVisible = false}) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      enableDrag: true, // let user swipe it down
      useSafeArea: true,
      backgroundColor: Colors.transparent,
      barrierColor: keepBottomNavVisible
          ? AppColors.barrierBackgroundColor
          : AppColors.barrierBackgroundColor.withOpacity(0.7),
      transitionAnimationController: AnimationController(
        vsync: Navigator.of(context),
        duration: const Duration(milliseconds: 400), // smoother in
        reverseDuration: const Duration(milliseconds: 350), // smoother out
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
                  child: _qrBuild(context), // your existing content
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
                  'Jonh Doe (10000001100)',
                  style: GoogleFonts.inter(
                    fontSize: 18,
                    color: Color(0XFF262628),
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
                    color: Color(0XFF083F8C),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 15),
                child: PackageAssets.image(
                  "assets/image/qr_scan.png", // <-- replace with your own image
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
        width: 150, // Short width for the button
        child: ElevatedButton(
          onPressed: () {
            // Add your submit/save image logic here
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF083F8C), // Blue color
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20), // Rounded corners
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
