import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  final Color buttonColor;
  final Color textColor;
  final String buttonTitle;
  final VoidCallback? onPressed;

  const CustomElevatedButton({
    super.key,
    required this.textColor,
    required this.buttonColor,
    required this.buttonTitle,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: buttonColor, // button color
        padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(43),
          side: BorderSide.none,
        ),
        elevation: 0,
      ),
      onPressed: onPressed ?? () => Navigator.pop(context),
      child: Text(
        buttonTitle,
        style: TextStyle(
          color: textColor,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
