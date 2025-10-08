import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tsb_mini/frame/body/home/home_quick_action.dart';
import 'package:tsb_mini/package_mode.dart';
import 'package:tsb_mini/theme/color_theme.dart';
import 'package:tsb_mini/theme/icon_theme.dart'; // for AppColors.filterButtonBackground

// Example categories (icon path + name)
final List<Map<String, dynamic>> categories = [
  // The "name" field is a translation key, not a visible string!
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
  double get minExtent => 190;

  @override
  double get maxExtent => 190;

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
            color: Colors.white, // or your gradient
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: const QuickActionMenu(),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, top: 10),
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

/// Stateful widget for category selection
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
      physics: const BouncingScrollPhysics(), // smooth scroll
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
            width: 80, // increased width for longer text
            child: Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(bottom: 2),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.topRight,
                          colors: [
                            AppColors.filterButtonBackground,
                            const Color.fromARGB(255, 53, 115, 202),
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
                    Flexible(
                      child: Text(
                        'category["name"]',
                        // AppLocalizations.of(
                        //   context,
                        // )!.translate(category["name"] ?? ''),
                        style: GoogleFonts.inter(
                          fontSize: 13,
                          color: isSelected
                              ? const Color(0XFF000000)
                              : Colors.grey[700],
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
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
