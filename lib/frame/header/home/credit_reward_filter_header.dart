import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tsb_main/utils/localization/app_localizations.dart';
import 'package:tsb_mini/frame/body/home/home_quick_action.dart';
import 'package:tsb_mini/package_mode.dart';
import 'package:tsb_mini/screen/reward/latest_reward_collection.dart';
import 'package:tsb_mini/theme/color_theme.dart';

final List<Map<String, dynamic>> categories = [
  {"icon": "assets/category/all.svg", "name": "all"},
  {"icon": "assets/category/dr1.svg", "name": "drink"},
  {"icon": "assets/category/food2.svg", "name": "food"},
  {"icon": "assets/category/fashion5.svg", "name": "shopping"},
  {"icon": "assets/category/Cloth.svg", "name": "fashion"},
];

class RewardFilterHeader extends StatelessWidget {
  const RewardFilterHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 0 , bottom: 15),
            child: QuickActionMenu(),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10 , right: 10),
            child: const Divider(height: 0.5 , color: Color.fromARGB(40, 167, 167, 167)),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, top: 5),
            child: SizedBox(
              height: 90,
              child: _CategorySelector(categories: categories),
            ),
          ),
        ],
      ),
    );
  }
}

class _CategorySelector extends StatefulWidget {
  final List<Map<String, dynamic>> categories;

  const _CategorySelector({required this.categories});

  @override
  State<_CategorySelector> createState() => _CategorySelectorState();
}

class _CategorySelectorState extends State<_CategorySelector> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      physics: const ClampingScrollPhysics(),
      itemCount: widget.categories.length,
      itemBuilder: (context, index) {
        final category = widget.categories[index];
        final bool isSelected = index == selectedIndex;

        return GestureDetector(
          onTap: () {
            setState(() {
              selectedIndex = index;
            });

            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => RewardCollection(selectedIndex: index),
              ),
            );
          },
          child: SizedBox(
            width: 80,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 2),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.topRight,
                      colors: [
                        AppColors.filterButtonBackground,
                        const Color.fromARGB(255, 64, 135, 234),
                      ],
                    ),
                  ),
                  child: PackageAssets.svg(
                    category["icon"] ?? '',
                    width: 25,
                    height: 25,
                    fit: BoxFit.contain,
                    color: Colors.white,
                  ),
                ),
                Flexible(
                  child: AnimatedDefaultTextStyle(
                    duration: const Duration(milliseconds: 250),
                    curve: Curves.easeInOut,
                    style: GoogleFonts.inter(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: isSelected
                          ? AppColors.textdarkblack
                          : AppColors.textdarkblack,
                    ),
                    child: Text(
                      AppLocalizations.of(
                        context,
                      )!.translate(category["name"] ?? ''),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                    ),
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
