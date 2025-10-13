import 'package:tsb_mini/theme/icon_theme.dart';
import 'package:flutter/material.dart';

class FrostedHeartButton extends StatelessWidget {
  final VoidCallback? onNavigate;

  const FrostedHeartButton({super.key, this.onNavigate});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      // onTap: onNavigate ?? () => Navigator.of(context).pop(),
      borderRadius: BorderRadius.circular(30),
      child: Container(
        width: 45,
        height: 45,
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
              color: Color(0XFF4069A2).withOpacity(0.05),
              offset: const Offset(2, 4),
              blurRadius: 8,
            ),
          ],
          // backgroundBlendMode: BlendMode.overlay,
        ),
        child: IconButton(
          icon: AppIcons.heartSvgIcon(
            size: 18,
            color: Color.fromARGB(255, 240, 240, 240),
          ),
          onPressed: () {
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(builder: (context) => Favourite()),
            // );
          },
          padding: EdgeInsets.zero, // removes default padding
          constraints: const BoxConstraints(), // removes min size
        ),
      ),
    );
  }
}
