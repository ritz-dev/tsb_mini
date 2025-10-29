import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tsb_main/utils/localization/app_localizations.dart';
import 'package:tsb_mini/package_mode.dart';

class CreditTransferHeader extends StatelessWidget {
  const CreditTransferHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 30, left: 20, right: 20 , bottom: 5),
      child: SizedBox(
        height: 100,
        width: double.infinity,
        child: Container(
          decoration: BoxDecoration(
          boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.12),
                  blurRadius: 12,
                  spreadRadius: 0,
                  offset: const Offset(0, 4),
                ),
              ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  // Background image
                  PackageAssets.image(
                    "assets/image/transfer.png", // <-- replace with your background image
                    fit: BoxFit.fill,
                  ),
              
                  // Semi-transparent overlay (optional for better text visibility)
                  // Container(color: Colors.black.withOpacity(0.2)),
              
                  //  Content
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20.0,
                      vertical: 0.0,
                    ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Left side (Name + Level)
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0,20,0,20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                 Text(
                                  // 'Mr. John Doe',
                                  AppLocalizations.of(context)!.translate('user_name'),
                                  style: GoogleFonts.inter(
                                    fontSize: 14,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                // const SizedBox(height: 6),
                                Text(
                                  // 'Gold',
                                  AppLocalizations.of(context)!.translate('user_level'),
                                  style: GoogleFonts.inter(
                                    fontSize: 22,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                                  
                          // Right side (Carbon Credit label + Value)
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0,20,0,20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  // 'My Carbon Credit',
                                  AppLocalizations.of(
                                    context,
                                  )!.translate('my_carbon_credit'),
                                  style: GoogleFonts.inter(
                                    fontSize: 14,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    RichText(
                                      text: TextSpan(
                                        children: [
                                          TextSpan(
                                            text: "6,000",
                                            style: GoogleFonts.inter(
                                              fontSize: 20,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          TextSpan(
                                            text: " CC",
                                            style: GoogleFonts.inter(
                                              fontSize: 16,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
            ),
        ),
        ),
      );
    }
  }
