import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tsb_mini/package_mode.dart';
import 'package:tsb_mini/theme/color_theme.dart';

class ListViewFrame extends StatelessWidget {
  final List<Map<String, dynamic>> items; // pass items to the widget

  const ListViewFrame({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) {
      return Center(
        child: Container(
          margin: EdgeInsets.only(top: 90),
          child: Column(
            children: [
              PackageAssets.image(
                "assets/image/NoDataFound.png", // replace with your image path
                width: 182,
                height: 169,
                fit: BoxFit.contain,
              ),
            ],
          ),
        ),
      );
    }
    return ListView.builder(
      itemCount: items.length,
      padding: const EdgeInsets.all(20),
      itemBuilder: (context, index) {
        return Container(
          margin: const EdgeInsets.only(bottom: 18),
          decoration: BoxDecoration(
            color: Color(0xFFFFFFFF),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: Color.fromRGBO(231, 230, 230, 1),
              width: 1,
            ),
            // boxShadow: [
            //   BoxShadow(
            //     color: Color(0xFF000000).withOpacity(0.07), // shadow color
            //     blurRadius: 20, // how soft/blurred the shadow is
            //     spreadRadius: 2, // how wide it spreads
            //     offset: Offset(0, 6), // x=0 → centered, y=6 → shadow at bottom
            //   ),
            // ],
          ),
          child: ListTile(
            leading: items[index]['icon'] as Widget,
            title: Padding(
              padding: const EdgeInsets.symmetric(vertical: 3),
              child: Text(
                items[index]['title'], // Title
                style: GoogleFonts.inter(
                  fontSize: 14,
                  height: 1.5,
                  color: AppColors.textdarkblack,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            subtitle: Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: Text(
                items[index]['from_name'], // Sender's name
                style: GoogleFonts.inter(
                  fontSize: 12,
                  color: AppColors.textGrey,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2),
                  child: Text(
                    items[index]['date'], // Date
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      color: AppColors.textGrey,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Sign (+ or -)
                    Text(
                      items[index]['status'] == 'increase' ? '+' : '-',
                      style: GoogleFonts.inter(
                        fontSize: 16, // smaller size for sign
                        fontWeight: FontWeight.w500,
                        color: items[index]['status'] == 'increase'
                            ? AppColors.textgreen
                            : AppColors.textRed,
                      ),
                    ),
                    // Point value
                    Text(
                      items[index]['point'].toString(),
                      style: GoogleFonts.inter(
                        fontSize: 18, // larger size for point
                        fontWeight: FontWeight.w600,
                        color: items[index]['status'] == 'increase'
                            ? AppColors.textgreen
                            : AppColors.textRed,
                      ),
                    ),
                    const SizedBox(width: 5),
                    // CC text
                    Text(
                      'Cc',
                      style: GoogleFonts.inter(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: items[index]['status'] == 'increase'
                            ? AppColors.textgreen
                            : AppColors.textRed,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
