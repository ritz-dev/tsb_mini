import 'package:tsb_mini/theme/icon_theme.dart';
import 'package:flutter/material.dart';

class FrostedBackButton extends StatelessWidget {
  final VoidCallback? onBack;

  const FrostedBackButton({super.key, this.onBack});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onBack ?? () => Navigator.of(context).pop(),
      borderRadius: BorderRadius.circular(30),
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(
            0.15,
          ), // Semi-transparent for glass effect
          shape: BoxShape.circle,
          // border: Border.all(
          //   color: Colors.white.withOpacity(0.2), // Light border for depth
          //   width: 1.5,
          // ),
          boxShadow: [
            BoxShadow(
              color: Color(0XFF4069A2).withOpacity(0.01),
              offset: const Offset(2, 4),
              blurRadius: 2,
            ),
          ],
        ),
        child: Center(
          child: AppIcons.backButtonIcon(
            color: Color.fromARGB(255, 240, 240, 240),
            size: 20,
          ),
        ),
      ),
    );
  }
}
