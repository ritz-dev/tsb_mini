import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tsb_mini/frame/button/back_button.dart';
import 'package:tsb_mini/theme/color_theme.dart';

class RewardDetailAppBar extends StatelessWidget implements PreferredSizeWidget {

  // Button actions
  final VoidCallback? onTapBack;

  // Controls
  final bool enableBack;

  const RewardDetailAppBar({
    super.key,
    this.onTapBack,
    this.enableBack = true,
  });

  @override
  Size get preferredSize => const Size.fromHeight(115);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: preferredSize.height,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/home_images/starbucks_lastest.png'),
          fit: BoxFit.cover,
        ),
      ),
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Back button (left side)
            if (enableBack)
              FrostedBackButton(
                onBack: onTapBack,
              ), // placeholder to keep spacing
            // Title (centered)
          ],
        ),
      ),
    );
  }
}
