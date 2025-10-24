import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tsb_mini/package_mode.dart';
import 'package:tsb_mini/theme/color_theme.dart';

class ListViewFrame extends StatelessWidget {
  final List<Map<String, dynamic>> items;
  final bool shrinkWrap; // NEW
  final ScrollPhysics? physics; // NEW

  const ListViewFrame({
    super.key,
    required this.items,
    this.shrinkWrap = false, // default false
    this.physics,
  });

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) {
      return Center(
        child: Container(
          margin: const EdgeInsets.only(top: 90),
          child: Column(
            children: [
              PackageAssets.image(
                "assets/image/NoDataFound.png",
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
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
      shrinkWrap: shrinkWrap, // USE IT
      physics: physics, // USE IT
      itemBuilder: (context, index) {
        return Container(
          margin: const EdgeInsets.only(bottom: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: const Color.fromRGBO(231, 230, 230, 1),
              width: 0.5,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.07),
                blurRadius: 8,
                spreadRadius: 0,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: ListTile(
            leading: items[index]['icon'] as Widget,
            title: Padding(
              padding: const EdgeInsets.symmetric(vertical: 3),
              child: Text(
                items[index]['title'],
                style: GoogleFonts.inter(
                  fontSize: 13,
                  height: 1.5,
                  color: AppColors.textdarkblack,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            subtitle: Text(
              items[index]['from_name'],
              style: GoogleFonts.inter(fontSize: 12, color: AppColors.textGrey),
            ),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: Text(
                    items[index]['date'],
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      color: AppColors.textGrey,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: items[index]['status'] == 'increase' ? '+' : '-',
                        style: GoogleFonts.inter(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: items[index]['status'] == 'increase'
                              ? AppColors.textgreen
                              : AppColors.textRed,
                        ),
                      ),
                      TextSpan(
                        text: items[index]['point'].toString(),
                        style: GoogleFonts.inter(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: items[index]['status'] == 'increase'
                              ? AppColors.textgreen
                              : AppColors.textRed,
                        ),
                      ),
                        TextSpan(
                        text: ' CC',
                        style: GoogleFonts.inter(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: items[index]['status'] == 'increase'
                              ? AppColors.textgreen
                              : AppColors.textRed, // You can change the color
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
