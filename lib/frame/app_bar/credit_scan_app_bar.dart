
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tsb_mini/frame/button/back_button.dart';
import 'package:tsb_mini/frame/button/flash_light_button.dart';
import 'package:tsb_mini/theme/color_theme.dart';

class CreditScanAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  final String title;

  // Button actions
  final VoidCallback? onTapBack;
  final VoidCallback? onTapLight;

  // Controls
  final bool enableBack;
  final bool enableLight;

  const CreditScanAppBar({
    super.key,
    required this.title,
    this.onTapBack,
    this.onTapLight,
    this.enableBack = true,
    this.enableLight = false,
  });

  @override
  Size get preferredSize => const Size.fromHeight(70);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: preferredSize.height,
      decoration: const BoxDecoration(
        color: Color(0xFF224474), // Deep blue
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: SafeArea(
        bottom: false,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Back button (left side)
            if (enableBack)
              FrostedBackButton(onBack: onTapBack)
            else
              const SizedBox(width: 40), // placeholder to keep spacing
            // Title (centered)
            Expanded(
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textWhite,
                ),
              ),
            ),

            if (enableLight)
              FlashLightButton(onLight: onTapLight)
            else
              const SizedBox(width: 40), // placeholder for symmetry
          ],
        ),
      ),
    );
  }
}
