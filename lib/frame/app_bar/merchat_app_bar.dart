import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tsb_mini/frame/button/back_button.dart';
import 'package:tsb_mini/theme/color_theme.dart';

class MerchatAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  // Button actions
  final VoidCallback? onTapBack;

  // Controls
  final bool enableBack;

  const MerchatAppBar({
    super.key,
    required this.title,
    this.onTapBack,
    this.enableBack = true,
  });

  @override
  Size get preferredSize => const Size.fromHeight(115);

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: preferredSize.height,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/image/app_bar_bg.png'),
          fit: BoxFit.cover,
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.orange , width: 1),
          ),
          child: Padding(
            padding: const EdgeInsets.only(top:  15 , bottom: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // Back button (left side)
                if (enableBack)
                  FrostedBackButton(onBack: onTapBack)
                else
                  const SizedBox(width: 40), // keep spacing if no back button
                // Title (centered)
                Expanded(
                  child: Text(
                    title,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inter(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textWhite,
                    ),
                  ),
                ),
            
                // Placeholder for right spacing
                const SizedBox(width: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
