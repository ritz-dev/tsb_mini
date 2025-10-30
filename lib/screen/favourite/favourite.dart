import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tsb_main/frame/navigation/bottom_navigation_frame.dart';
import 'package:tsb_main/utils/localization/app_localizations.dart';
import 'package:tsb_mini/frame/app_bar/credit_app_bar.dart';
import 'package:tsb_mini/frame/body/favourite/favourite_card.dart';
import 'package:tsb_mini/frame/favourite/category_header.dart';
import 'package:tsb_mini/package_mode.dart';
import 'package:tsb_mini/theme/icon_theme.dart';

class Favourite extends StatefulWidget {
  final String? search;
  final double? minPoint;
  final double? maxPoint;

  const Favourite({super.key, this.search, this.minPoint, this.maxPoint});

  @override
  State<Favourite> createState() => _FavouriteState();
}

class _FavouriteState extends State<Favourite> {
  final List<Map<String, dynamic>> categories = [
    {"icon": AppIcons.allPngPath, "name": "All"},
    {"icon": AppIcons.drinkPngPath, "name": "Drink"},
    {"icon": AppIcons.foodPngPath, "name": "Food"},
    {"icon": AppIcons.shoppingPngPath, "name": "Shopping"},
    {"icon": AppIcons.fashionPngPath, "name": "Fashion"},
  ];

  final List<Map<String, dynamic>> data = [
    {
      "image": "assets/home_images/kfc2_latest_reward.png",
      "message": "Buy One Get One Free",
      "point": "150",
      "name": "KFC",
      "date": "2025-12-10",
      "status": "Active",
      "type": "Food",
    },
    {
      "image": "assets/home_images/mc_latest_reward.png",
      "message": "Free Fries With Meal",
      "point": "90",
      "name": "McDonald's",
      "date": "2025-12-20",
      "status": "Active",
      "type": "Food",
    },
    {
      "image": "assets/home_images/starbucks_latest_reward.png",
      "message": "Free Handcrafted Drink",
      "point": "100",
      "name": "Starbucks",
      "date": "2025-12-15",
      "status": "Active",
      "type": "Drink",
    },
    {
      "image": "assets/home_images/kfc_latest_reward.png",
      "message": "Free Bucket On Us",
      "point": "120",
      "name": "KFC",
      "date": "2025-12-25",
      "status": "Active",
      "type": "Food",
    },
    {
      "image": "assets/home_images/amazon_latest_reward.png",
      "message": "Buy 9 Cups, Get 1 Free",
      "point": "110",
      "name": "Cafe Amazon",
      "date": "2025-10-20",
      "status": "Expired",
      "type": "Drink",
    },
    {
      "image": "assets/home_images/starbucks2_latest_reward.png",
      "message": "60% Off One Time",
      "point": "130",
      "name": "Starbucks",
      "date": "2025-12-30",
      "status": "Active",
      "type": "Drink",
    },
  ];

  int selected = 0;
  int _selectedIndex = 2;
  List<Map<String, dynamic>> filteredData = [];

  @override
  void initState() {
    super.initState();
    _filterData(categories[selected]["name"]);
  }

  /// Handle bottom navigation tap
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  /// Filter data by category
  void _filterData(String categoryName) {
    setState(() {
      if (categoryName == "All") {
        filteredData = data;
      } else {
        filteredData = data
            .where((item) => item["type"] == categoryName)
            .toList();
      }
    });
  }

  /// Format date dynamically (e.g. “End on 25 Dec 2025” or “Expired on 22 Oct 2025”)
  String formatDate(String dateStr) {
    try {
      final date = DateTime.parse(dateStr);
      final formattedDate = DateFormat("dd MMM yyyy").format(date);
      if (date.isBefore(DateTime.now())) {
        return "Expired on $formattedDate";
      } else {
        return "End on $formattedDate";
      }
    } catch (e) {
      return dateStr;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff083f8c),
      body: Column(
        children: [
          const CreditHomeAppBar(title: "Favourite", enableFilterPoint: true),
          CategoryHeader(
            categories: categories,
            selected: selected,
            onCategorySelected: (index, name) {
              _filterData(name);
              setState(() => selected = index);
            },
          ),
          Expanded(
            child: Container(
              width: double.infinity,
              color: Colors.white,
              child: filteredData.isEmpty
                  ? Center(
                      child: PackageAssets.image(
                        "assets/image/NoDataFound.png",
                        width: 182,
                        height: 169,
                        fit: BoxFit.contain,
                      ),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.symmetric(
                        vertical: 12,
                        horizontal: 16,
                      ),
                      itemCount: filteredData.length,
                      itemBuilder: (context, index) {
                        final item = filteredData[index];
                        final validDate = item["date"] != null
                            ? formatDate(item["date"])
                            : '';

                        return Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: FavouriteCard(
                            image: item["image"],
                            title: item["message"],
                            merchant: item["name"],
                            valid: validDate,
                            point: item["point"],
                            status: (item['status'] ?? 'used'),
                            onTap: () {
                              // Optional navigation
                            },
                          ),
                        );
                      },
                    ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          color: Colors.white,
          child: BottomNavigationFrame(
            selectedIndex: _selectedIndex,
            onItemTapped: _onItemTapped,
            localize: AppLocalizations.of(context)!,
          ),
        ),
      ),
    );
  }
}
