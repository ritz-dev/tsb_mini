import 'package:flutter/material.dart';
import 'package:tsb_mini/theme/color_theme.dart';
import 'package:tsb_mini/theme/icon_theme.dart';

class FrostedBackButtonBlack extends StatelessWidget {
  final VoidCallback? onBack;

  const FrostedBackButtonBlack({super.key, this.onBack});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onBack ?? () => Navigator.of(context).pop(),
      borderRadius: BorderRadius.circular(30),
      child: Container(
        width: 45,
        height: 45,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(
            0.25,
          ), // Semi-transparent for glass effect
          shape: BoxShape.circle,
          border: Border.all(
            color: Colors.white.withOpacity(0.2), // Light border for depth
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: Color(0XFF4069A2).withOpacity(0.05),
              offset: const Offset(2, 4),
              blurRadius: 8,
            ),
          ],
          backgroundBlendMode: BlendMode.overlay,
        ),
        child: Center(
          child: AppIcons.backButtonIcon(
            color: AppColors
                .iconBottomNav, // White icon for visibility on dark backgrounds
            size: 24,
          ),
        ),
      ),
    );
  }
}
