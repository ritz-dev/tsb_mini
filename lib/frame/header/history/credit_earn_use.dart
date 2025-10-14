import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:tsb_mini/package_mode.dart';
import 'package:tsb_mini/theme/color_theme.dart';

class CreditEarnUse extends StatefulWidget {
  final String? startDate;
  final String? endDate;
  final List<Map<String, dynamic>>? items;

  const CreditEarnUse({super.key, this.startDate, this.endDate, this.items});

  @override
  State<CreditEarnUse> createState() => _CreditEarnUseState();
}

class _CreditEarnUseState extends State<CreditEarnUse> {
  late int totalEarn;
  late int totalUse;

  @override
  void initState() {
    super.initState();
    // Set initial values if items are empty
    totalEarn = 4550; // initial Total Earn
    totalUse = 2000; // initial Total Use
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double cardWidth = (screenWidth - 15 - 15 - 30) / 2;
    cardWidth = cardWidth > 180 ? 180 : cardWidth;

    // Helper function to format dates
    String getFormattedDate(String? startDate, String? endDate) {
      final now = DateTime.now();
      final defaultText = DateFormat("MMMM yyyy").format(now);

      if ((startDate?.isNotEmpty ?? false) || (endDate?.isNotEmpty ?? false)) {
        String formattedStart = "";
        String formattedEnd = "";

        if (startDate?.isNotEmpty ?? false) {
          try {
            final parsedStart = DateFormat("d MMM, yyyy").parse(startDate!);
            formattedStart = DateFormat("d MMM, yyyy").format(parsedStart);
          } catch (_) {
            formattedStart = startDate!;
          }
        }

        if (endDate?.isNotEmpty ?? false) {
          try {
            final parsedEnd = DateFormat("d MMM, yyyy").parse(endDate!);
            formattedEnd = DateFormat("d MMM, yyyy").format(parsedEnd);
          } catch (_) {
            formattedEnd = endDate!;
          }
        }

        if (formattedStart.isNotEmpty && formattedEnd.isNotEmpty) {
          return "$formattedStart - $formattedEnd";
        } else if (formattedStart.isNotEmpty) {
          return formattedStart;
        } else {
          return formattedEnd;
        }
      }

      return defaultText;
    }

    return Container(
      padding: const EdgeInsets.only(top: 0.0, left: 20, right: 20, bottom: 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title
          Padding(
            padding: const EdgeInsets.only(top: 24.0),
            child: Text(
              getFormattedDate(widget.startDate, widget.endDate),
              style: GoogleFonts.inter(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: AppColors.textBlack,
              ),
            ),
          ),

          const SizedBox(height: 6),

          // replaced Stack with responsive Row so both cards have same size/fit
          SizedBox(
            height: 110,
            width: double.infinity,
            child: Row(
              children: [
                // Card with shadow (Total Earn)
                Container(
                  height: 90,
                  width: cardWidth,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
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
                        // use BoxFit.cover so the background fills the card
                        PackageAssets.image(
                          "assets/image/earn01.png",
                          fit: BoxFit.cover,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 18),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Total Earn",
                                style: GoogleFonts.inter(
                                  color: AppColors.textWhite,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              const SizedBox(height: 6),
                              RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: "+",
                                      style: GoogleFonts.inter(
                                        color: AppColors.textWhite,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    const WidgetSpan(child: SizedBox(width: 2)),
                                    TextSpan(
                                      text: "4,550",
                                      style: GoogleFonts.inter(
                                        color: AppColors.textWhite,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 1,
                                      ),
                                    ),
                                    const WidgetSpan(child: SizedBox(width: 2)),
                                    TextSpan(
                                      text: "CC",
                                      style: GoogleFonts.inter(
                                        color: AppColors.textWhite,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                        letterSpacing: 1,
                                      ),
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

                const SizedBox(width: 14), // spacing between cards

                // Card with shadow (Total Use)
                Container(
                  height: 90,
                  width: cardWidth,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
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
                        // changed to BoxFit.cover to match the first card
                        PackageAssets.image(
                          "assets/image/use.png",
                          fit: BoxFit.cover,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 18),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Total Use",
                                style: GoogleFonts.inter(
                                  color: AppColors.textWhite,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              const SizedBox(height: 6),
                              RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: "-",
                                      style: GoogleFonts.inter(
                                        color: AppColors.textWhite,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    const WidgetSpan(child: SizedBox(width: 2)),
                                    TextSpan(
                                      text: "2,000",
                                      style: GoogleFonts.inter(
                                        color: AppColors.textWhite,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const WidgetSpan(child: SizedBox(width: 2)),
                                    TextSpan(
                                      text: "CC",
                                      style: GoogleFonts.inter(
                                        color: AppColors.textWhite,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                      ),
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
              ],
            ),
          ),
        ],
      ),
    );
  }
}
