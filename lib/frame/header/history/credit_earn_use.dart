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

    // If no date filter is provided, show the default totals (normal condition)
    final hasStart = (widget.startDate != null && widget.startDate!.isNotEmpty);
    final hasEnd = (widget.endDate != null && widget.endDate!.isNotEmpty);

    if (!hasStart && !hasEnd) {
      totalEarn = 4550; // default shown when not filtering by date
      totalUse = 2000;  // default shown when not filtering by date
      return;
    }

    // Otherwise compute totals from provided items and optional start/end date filters
    int earn = 0;
    int use = 0;

    if (widget.items != null && widget.items!.isNotEmpty) {
      DateTime? start;
      DateTime? end;

      String? rawStart = widget.startDate;
      String? rawEnd = widget.endDate;

      // if start/end include newline (calendar controllers use "EEEE\ndd MMM, yyyy"), take last line
      if (rawStart != null && rawStart.contains('\n')) rawStart = rawStart.split('\n').last;
      if (rawEnd != null && rawEnd.contains('\n')) rawEnd = rawEnd.split('\n').last;

      try {
        if (rawStart != null && rawStart.isNotEmpty) {
          start = DateFormat("d MMM, yyyy").parse(rawStart);
        }
      } catch (_) {
        start = null;
      }
      try {
        if (rawEnd != null && rawEnd.isNotEmpty) {
          end = DateFormat("d MMM, yyyy").parse(rawEnd);
        }
      } catch (_) {
        end = null;
      }

      for (final item in widget.items!) {
        // read points safely (accept int or numeric string with commas)
        int pts = 0;
        try {
          final p = item['point'];
          if (p is int) pts = p;
          else if (p is String) pts = int.parse(p.replaceAll(',', ''));
        } catch (_) {
          pts = 0;
        }

        // date filtering: only apply when item has a parseable date field
        bool inRange = true;
        if ((start != null || end != null) &&
            (item.containsKey('date') || item.containsKey('createdAt') || item.containsKey('created_at'))) {
          String? rawItemDate;
          if (item.containsKey('date')) rawItemDate = item['date']?.toString();
          else if (item.containsKey('createdAt')) rawItemDate = item['createdAt']?.toString();
          else rawItemDate = item['created_at']?.toString();

          if (rawItemDate == null || rawItemDate.isEmpty) {
            inRange = false;
          } else {
            try {
              if (rawItemDate.contains('\n')) rawItemDate = rawItemDate.split('\n').last;
              // if item date contains time, extract date part like "dd MMM, yyyy"
              final match = RegExp(r'\d{1,2}\s+\w{3},\s*\d{4}').firstMatch(rawItemDate);
              final datePart = match?.group(0) ?? rawItemDate;
              final itemDate = DateFormat("d MMM, yyyy").parse(datePart);
              if (start != null && end != null) {
                inRange = !(itemDate.isBefore(start) || itemDate.isAfter(end));
              } else if (start != null) {
                inRange = itemDate.year == start.year &&
                          itemDate.month == start.month &&
                          itemDate.day == start.day;
              } else if (end != null) {
                inRange = itemDate.year == end.year &&
                          itemDate.month == end.month &&
                          itemDate.day == end.day;
              }
            } catch (_) {
              inRange = false;
            }
          }
        }

        if (!inRange) continue;

        final status = (item['status'] ?? '').toString();
        if (status == 'increase') earn += pts;
        else use += pts;
      }
    }

    // When filtering is applied: if no items matched, totals stay 0
    totalEarn = earn;
    totalUse = use;
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double cardWidth = (screenWidth - 15 - 15 - 30) / 2;
    cardWidth = cardWidth > 180 ? 180 : cardWidth;

    // detect whether user applied a date filter
    final bool isFiltered = (widget.startDate?.isNotEmpty ?? false) ||
        (widget.endDate?.isNotEmpty ?? false);

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
                                    // show '+' when filtered OR when value != 0 (keeps previous behavior)
                                    if (isFiltered || totalEarn != 0)
                                      TextSpan(
                                        text: "+",
                                        style: GoogleFonts.inter(
                                          color: AppColors.textWhite,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    if (isFiltered || totalEarn != 0)
                                      const WidgetSpan(child: SizedBox(width: 2)),
                                    TextSpan(
                                      text: NumberFormat.decimalPattern().format(totalEarn),
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
                                        fontSize: 14,
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
                                    // show '-' when filtered OR when value != 0 (keeps previous behavior)
                                    if (isFiltered || totalUse != 0)
                                      TextSpan(
                                        text: "-",
                                        style: GoogleFonts.inter(
                                          color: AppColors.textWhite,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    if (isFiltered || totalUse != 0)
                                      const WidgetSpan(child: SizedBox(width: 2)),
                                    TextSpan(
                                      text: NumberFormat.decimalPattern().format(totalUse),
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
                                        fontSize: 14,
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
