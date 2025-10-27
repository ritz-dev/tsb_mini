import 'package:flutter/material.dart';
import 'package:tsb_mini/package_mode.dart';
import 'package:tsb_mini/theme/color_theme.dart';

class CategoryHeader extends StatefulWidget {
  final List<Map<String, dynamic>>? categories;
  final int selected;

  const CategoryHeader({super.key, this.categories, this.selected = 0});

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

    if (categories.isEmpty) {
      return const SizedBox(
        height: 70,
        child: Center(child: Text("No categories")),
      );
    }

    return Container(
      color: Colors.white,
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          final bool isSelected = index == selectedIndex;

          return GestureDetector(
            onTap: () {
              setState(() {
                selectedIndex = index;
              });
            },
            child: Container(
              width: 80,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Category Icon with gradient background
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
                  // Category Name
                  Flexible(
                    child: Text(
                      category["name"] ?? '',
                      style: TextStyle(
                        fontWeight: isSelected
                            ? FontWeight.bold
                            : FontWeight.normal,
                        color: isSelected ? Color(0XFF083F8C) : Color(0XFF083F8C),
                        fontSize: 13,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  // Animated Underline
                  const SizedBox(height: 4), // always reserve space
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    curve: Curves.easeInOut,
                    height: 2,
                    width: isSelected ? 40 : 0,
                    decoration: BoxDecoration(
                      color: Color(0XFF083F8C),
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
