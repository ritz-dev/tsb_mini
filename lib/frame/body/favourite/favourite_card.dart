import 'package:flutter/material.dart';
import 'package:tsb_mini/package_mode.dart';
import 'package:tsb_mini/theme/responsive.dart';
import 'package:intl/intl.dart';
import 'package:google_fonts/google_fonts.dart';

class FavouriteCard extends StatefulWidget {
  final List<Map<String, dynamic>>? data;
  final String? search;
  final double? minPoint;
  final double? maxPoint;

  const FavouriteCard({
    super.key,
    this.data,
    this.search,
    this.minPoint,
    this.maxPoint,
  });

  @override
  State<FavouriteCard> createState() => _FavouriteCardState();
}

class _FavouriteCardState extends State<FavouriteCard> {
  String formatDate(String dateStr) {
    try {
      final dt = DateTime.parse(dateStr);
      return DateFormat('d MMM y').format(dt); // e.g., 15 Dec 2025
    } catch (_) {
      return dateStr;
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    final filteredData = widget.data?.where((item) {
      final point = int.tryParse(item["point"].toString()) ?? 0;
      final isInRange =
          point >= (widget.minPoint ?? 0) &&
          point <= (widget.maxPoint ?? double.infinity);

      if (widget.search?.isEmpty ?? true) return isInRange;

      final searchLower = widget.search!.toLowerCase();
      final message = item["message"].toString().toLowerCase();
      final name = item["name"].toString().toLowerCase();
      return (message.contains(searchLower) || name.contains(searchLower)) &&
          isInRange;
    }).toList();

    if (filteredData == null || filteredData.isEmpty) {
      return Expanded(
        child: Center(
          child: PackageAssets.image(
            "assets/image/NoDataFound.png",
            width: 182,
            height: 169,
            fit: BoxFit.contain,
          ),
        ),
      );
    }

    return Expanded(
      child: ListView.builder(
        itemCount: filteredData.length,
        itemBuilder: (context, index) {
          final item = filteredData[index];

          // Format valid date
          final valid = item["date"] != null
              ? 'Valid Until ${formatDate(item["date"].toString())}'
              : '';

          // Split title if too long like RewardCouponCard
          String truncatedTitle;
          String remainingTitle = '';
          final title = item["message"] ?? '';
          if (title.length > 30) {
            truncatedTitle = title.substring(0, 23);
            remainingTitle = title.substring(23);
          } else {
            truncatedTitle = title;
          }

          return Container(
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
            padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
            decoration: BoxDecoration(
              color: Colors.purple,
              borderRadius: BorderRadius.circular(12),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 5,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Left - Image
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(12),
                    bottomLeft: Radius.circular(12),
                  ),
                  child: PackageAssets.image(
                    item["image"], // your image url
                    width: screenWidth * 0.25,
                    height: screenWidth * 0.25,
                    fit: BoxFit.cover,
                  ),
                ),

                const SizedBox(width: 12),

                // Middle - Title, Merchant, Valid, Points
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Title with "..." modal if too long
                      Text.rich(
                        TextSpan(
                          text: truncatedTitle,
                          style: GoogleFonts.inter(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            color: Colors.black,
                          ),
                          children: remainingTitle.isNotEmpty
                              ? [
                                  WidgetSpan(
                                    child: GestureDetector(
                                      onTap: () {
                                        // Optional modal
                                        showModalBottomSheet(
                                          context: context,
                                          backgroundColor: Colors.white,
                                          shape: const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.vertical(
                                              top: Radius.circular(20),
                                            ),
                                          ),
                                          builder: (context) => Padding(
                                            padding: const EdgeInsets.all(16.0),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "Reward Details",
                                                  style: GoogleFonts.inter(
                                                    fontWeight: FontWeight.w700,
                                                    fontSize: 18,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                                const SizedBox(height: 12),
                                                Text(
                                                  title,
                                                  style: GoogleFonts.inter(
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 16,
                                                    color: Colors.black87,
                                                  ),
                                                ),
                                                const SizedBox(height: 30),
                                                Align(
                                                  alignment: Alignment.center,
                                                  child: Material(
                                                    color: Colors.transparent,
                                                    child: InkWell(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            6,
                                                          ),
                                                      onTap: () =>
                                                          Navigator.pop(
                                                            context,
                                                          ),
                                                      child: Container(
                                                        width: double.infinity,
                                                        decoration: BoxDecoration(
                                                          color: const Color(
                                                            0xFF2E3192,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                20,
                                                              ),
                                                        ),
                                                        padding:
                                                            const EdgeInsets.symmetric(
                                                              vertical: 11,
                                                            ),
                                                        child: Center(
                                                          child: Text(
                                                            'Close',
                                                            style:
                                                                GoogleFonts.inter(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w800,
                                                                  fontSize: 14,
                                                                  color: Colors
                                                                      .white,
                                                                ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                      child: Text(
                                        '...',
                                        style: GoogleFonts.inter(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ),
                                ]
                              : [],
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.fade,
                      ),

                      const SizedBox(height: 6),

                      // Merchant
                      Text(
                        item["merchant"] ?? '',
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          color: const Color(0xFFACACAC),
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 8),

                      // Valid date
                      Text(
                        valid,
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                          color: const Color(0xFFACACAC),
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 6),

                      // Points
                      Text(
                        "${item["point"]} Points",
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.green,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(width: 8),

                // Optional right icon
                PackageAssets.image(
                  item["icon"],
                  width: 20,
                  height: 20,
                  fit: BoxFit.contain,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
