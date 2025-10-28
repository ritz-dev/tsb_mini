import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tsb_main/utils/localization/app_localizations.dart';
import 'package:tsb_mini/frame/body/home/home_quick_action.dart';
import 'package:tsb_mini/package_mode.dart';
import 'package:tsb_mini/theme/color_theme.dart';
import 'package:tsb_mini/theme/icon_theme.dart';

// Example categories (icon path + name)
final List<Map<String, dynamic>> categories = [
  {"icon": AppIcons.allPngPath, "name": "all"},
  {"icon": AppIcons.drinkPngPath, "name": "drink"},
  {"icon": AppIcons.foodPngPath, "name": "food"},
  {"icon": AppIcons.shoppingPngPath, "name": "shopping"},
  {"icon": AppIcons.fashionPngPath, "name": "fashion"},
];

class RewardFilterHeader extends StatelessWidget {
  const RewardFilterHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
      pinned: true,
      delegate: _FilterHeaderDelegate(),
    );
  }
}

class _FilterHeaderDelegate extends SliverPersistentHeaderDelegate {
  @override
  double get minExtent => 180;

  @override
  double get maxExtent => 180;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    final double currentExtent = (maxExtent - shrinkOffset).clamp(
      minExtent,
      maxExtent,
    );

    return Material(
      color: Colors.transparent,
      elevation: 0,
      child: SizedBox(
        height: currentExtent,
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 0),
                child: QuickActionMenu(),
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
        ),
      ),
    );
  }

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      true;
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
          },
          child: SizedBox(
            width: 80,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Icon area (no animation)
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
                  child: PackageAssets.image(
                    category["icon"] ?? '',
                    width: 25,
                    height: 25,
                    fit: BoxFit.contain,
                    color: Colors.white,
                  ),
                ),

                // Text area (only animated color transition)
                Flexible(
                  child: AnimatedDefaultTextStyle(
                    duration: const Duration(milliseconds: 250),
                    curve: Curves.easeInOut,
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: isSelected
                          ? const Color(0xFF083F8C)
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
