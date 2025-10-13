import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tsb_mini/package_mode.dart';

class TransferErrorBanner {
  static OverlayEntry? _currentBanner;

  static void show(BuildContext context) {
    if (_currentBanner != null) return; // Prevent multiple banners

    OverlayState overlayState = Overlay.of(context);
    _currentBanner = OverlayEntry(
      builder: (context) => Positioned(
        top: MediaQuery.of(context).padding.top + 12,
        left: 16,
        right: 16,
        child: Material(
          color: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
            decoration: BoxDecoration(
              color: const Color(0xFFF84A54),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.08),
                  blurRadius: 8,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              children: [
                PackageAssets.image(
                  "assets/image/warning.png",
                  width: 40,
                  height: 40,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Transfer Failed",
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        "You have failed points your transfer.",
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.w500,
                          fontSize: 13,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "Closing in 5 seconds",
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.w400,
                        fontSize: 10,
                        color: Colors.white.withOpacity(0.8),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.close, color: Colors.white, size: 18),
                      padding: EdgeInsets.zero,
                      constraints: BoxConstraints(),
                      onPressed: () => hide(),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );

    overlayState.insert(_currentBanner!);

    Future.delayed(const Duration(seconds: 5), () {
      hide();
    });
  }

  static void hide() {
    _currentBanner?.remove();
    _currentBanner = null;
  }
}
