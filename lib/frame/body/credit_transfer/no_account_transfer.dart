import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tsb_mini/theme/color_theme.dart';

class NoAccountTransfer extends StatelessWidget {
  const NoAccountTransfer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 32, 24, 24),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Account Doesn’t Exist",
            style: GoogleFonts.inter(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: AppColors.textBluePoint,
            ),
          ),

          const SizedBox(height: 10),

          Text(
            "We couldn’t find an account with that username or ID. Double-check and enter again.",
            style: GoogleFonts.inter(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: Colors.black87,
            ),
          ),

          const SizedBox(height: 20),

          SizedBox(
            width: double.infinity,
            height: 45,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.appBarIconColor,
                shape: RoundedRectangleBorder(
                  side: BorderSide(color: AppColors.progressBar),
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
              onPressed: () => Navigator.pop(context),
              child: Text(
                "Try again",
                style: GoogleFonts.inter(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textBluePoint,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
