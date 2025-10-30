import 'package:flutter/material.dart';
import 'package:tsb_mini/package_mode.dart';
import 'package:tsb_mini/theme/color_theme.dart';

class CategoryHeader extends StatefulWidget {
  final List<Map<String, dynamic>>? categories;
  final int selected;
  final Function(int index, String name)? onCategorySelected;

  const CategoryHeader({
    super.key,
    this.categories,
    this.selected = 0,
    this.onCategorySelected,
  });

  @override
  State<CategoryHeader> createState() => _CategoryHeaderState();
}

class _CategoryHeaderState extends State<CategoryHeader> {
  late int selectedIndex;

  @override
  void initState() {
    super.initState();
    selectedIndex = widget.selected;
  }

  @override
  Widget build(BuildContext context) {
    final categories = widget.categories ?? [];

    // Show "No Data Found" image if no categories
    if (categories.isEmpty) {
      return Container(
        height: 200,
        color: Colors.white,
        alignment: Alignment.center,
        child: PackageAssets.image(
          "assets/image/NoDataFound.png",
          width: 182,
          height: 169,
          fit: BoxFit.contain,
        ),
      );
    }

    //  Normal category list
    return Container(
      height: 120,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          final bool isSelected = index == selectedIndex;

          return GestureDetector(
            onTap: () {
              setState(() => selectedIndex = index);
              widget.onCategorySelected?.call(index, category["name"]);
            },
            child: Container(
              width: 80,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
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
                  const SizedBox(height: 4),
                  Flexible(
                    child: Text(
                      category["name"] ?? '',
                      style: TextStyle(
                        fontWeight: isSelected
                            ? FontWeight.bold
                            : FontWeight.normal,
                        color: const Color(0XFF000000),
                        fontSize: 13,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 4),
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    curve: Curves.easeInOut,
                    height: 2,
                    width: isSelected ? 40 : 0,
                    decoration: BoxDecoration(
                      color: const Color(0XFF083F8C),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
