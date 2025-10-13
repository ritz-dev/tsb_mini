
import 'package:flutter/material.dart';
import 'package:tsb_mini/package_mode.dart';
import 'package:tsb_mini/theme/color_theme.dart';

class CategoryHeader extends StatefulWidget {
  final List<Map<String, dynamic>>? categories;
  final int selected;

  const CategoryHeader({
    super.key,
    this.categories,
    this.selected = 0,
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
    
    // debugPrint('Categories length: ${widget.categories?.length ?? 0}');
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
      height: 120,
      margin: const EdgeInsets.only(top: 10),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
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
            child: Padding(
              padding: const EdgeInsets.only(left: 20,top: 20,bottom: 20),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        begin: Alignment.centerLeft,  // left side
                        end: Alignment.centerRight,   // right side
                        colors: [
                          AppColors.filterButtonBackground,
                          const Color.fromARGB(255, 53, 115, 202),
                        ],
                      ),
                    ),
                    child: PackageAssets.image(
                      category["icon"] ?? '',
                      width: 20,
                      height: 20,
                      fit: BoxFit.contain,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        category["name"] ?? '',
                        style: TextStyle(
                          fontWeight: isSelected
                              ? FontWeight.bold
                              : FontWeight.normal,
                          color: isSelected ? Colors.black : Colors.grey[700],
                        ),
                      ),
                      if (isSelected) ...[
                        const SizedBox(height: 4),
                        Container(
                          height: 2,
                          width: 40,
                          color: Colors.black,
                        ),
                      ],
                    ],
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
