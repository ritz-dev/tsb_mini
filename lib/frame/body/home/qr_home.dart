import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tsb_mini/package_mode.dart';
import 'package:tsb_mini/theme/color_theme.dart';

class QrHome extends StatefulWidget {
  final VoidCallback? onBack;

  const QrHome({super.key, this.onBack});

  @override
  State<QrHome> createState() => _QrHomeState();
}

class _QrHomeState extends State<QrHome> {
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
      isScrollControlled: false,
      enableDrag: true, // allow drag down
      useSafeArea: true,
      backgroundColor: Colors.transparent,
      barrierColor: keepBottomNavVisible
          ? AppColors.barrierBackgroundColor
          : AppColors.barrierBackgroundColor.withOpacity(0.7),
      builder: (context) {
        return _DragDownOnlySheet(
          child: Container(
            width: double.infinity, //  full screen width
            height: MediaQuery.of(context).size.height * 0.45,
            decoration: const BoxDecoration(
              color: AppColors.cardBackground,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(43),
                topRight: Radius.circular(43),
              ),
            ),
            child: _qrBuild(context),
          ),
        );
      },
    );
  }

  Widget _qrBuild(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // drag indicator bar
          Container(
            width: 40,
            height: 4,
            margin: const EdgeInsets.only(bottom: 18),
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          Text(
            'John Doe (10000001100)',
            style: GoogleFonts.inter(
              fontSize: 18,
              color: const Color(0XFF262628),
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'Scan My QR',
            style: GoogleFonts.inter(
              fontSize: 18,
              color: const Color(0XFF083F8C),
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 25),
          PackageAssets.image(
            "assets/image/qr_scan.png",
            height: 150,
            width: 150,
            fit: BoxFit.cover,
          ),
          const SizedBox(height: 25),
          _actionButtons(),
        ],
      ),
    );
  }

  Widget _actionButtons() {
    return SizedBox(
      width: 150,
      child: ElevatedButton(
        onPressed: () {
          // Add your save image logic here
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF083F8C),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          padding: const EdgeInsets.symmetric(vertical: 8),
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
    );
  }
}

/// Custom wrapper to allow drag down only (no upward stretch)
class _DragDownOnlySheet extends StatelessWidget {
  final Widget child;

  const _DragDownOnlySheet({required this.child});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // Detect downward drag → close
      onVerticalDragUpdate: (details) {
        if (details.primaryDelta! > 5) {
          Navigator.of(context).pop();
        }
      },
      // Ignore upward drag (no stretching)
      behavior: HitTestBehavior.opaque,
      child: child,
    );
  }
}
