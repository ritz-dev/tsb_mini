import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tsb_main/frame/navigation/bottom_navigation_frame.dart';
import 'package:tsb_mini/frame/app_bar/credit_app_bar.dart';
import 'package:tsb_mini/frame/body/favourite/latest_reward_point_card.dart';
import 'package:tsb_mini/frame/favourite/category_header.dart';
import 'package:tsb_mini/package_mode.dart';
import 'package:tsb_mini/theme/icon_theme.dart';
import 'package:tsb_main/utils/localization/app_localizations.dart';

class RewardCollection extends StatefulWidget {
  final String? search;
  final double? minPoint;
  final double? maxPoint;
  final int selectedIndex;

  const RewardCollection({
    super.key,
    this.search,
    this.minPoint,
    this.maxPoint,
    this.selectedIndex = 0,
  });

  @override
  State<RewardCollection> createState() => _RewardCollectionState();
}

class _RewardCollectionState extends State<RewardCollection> {
  late int selectedIndex;

  final List<Map<String, dynamic>> categories = [
    {"icon": AppIcons.allPngPath, "name": "All"},
    {"icon": AppIcons.drinkPngPath, "name": "Drink"},
    {"icon": AppIcons.foodPngPath, "name": "Food"},
    {"icon": AppIcons.shoppingPngPath, "name": "Shopping"},
    {"icon": AppIcons.fashionPngPath, "name": "Fashion"},
  ];

  final List<Map<String, dynamic>> data = [
    {
      "image": "assets/home_images/kfc_latest_reward.png",
      "message": "Free Bucket On Us",
      "point": "100",
      "name": "KFC",
      "date": "2025-12-15",
      "status": "Active",
      "icon": "assets/icon/favourite.png",
      "type": "Food",
    },
    {
      "image": "assets/home_images/mc_latest_reward.png",
      "message": "Free Handcrafted Drink",
      "point": "120",
      "name": "McDonald's",
      "date": "2025-11-28",
      "status": "Active",
      "icon": "assets/icon/favourite.png",
      "type": "Drink",
    },
    {
      "image": "assets/home_images/kfc2_latest_reward.png",
      "message": "Buy One Get One Free",
      "point": "150",
      "name": "KFC",
      "date": "2025-11-30",
      "status": "Active",
      "icon": "assets/icon/favourite.png",
      "type": "Food",
    },
    {
      "image": "assets/home_images/starbucks_latest_reward.png",
      "message": "Free Handcrafted Drink",
      "point": "130",
      "name": "Starbucks",
      "date": "2025-10-05",
      "status": "Expired",
      "icon": "assets/icon/favourite.png",
      "type": "Drink",
    },
    {
      "image": "assets/home_images/amazon_latest_reward.png",
      "message": "Buy 9 Cups, Get 1 Free",
      "point": "140",
      "name": "Cafe Amazon",
      "date": "2025-12-18",
      "status": "Active",
      "icon": "assets/icon/favourite.png",
      "type": "Drink",
    },
    {
      "image": "assets/home_images/starbucks2_latest_reward.png",
      "message": "60% Off One Time",
      "point": "110",
      "name": "Starbucks",
      "date": "2025-10-25",
      "status": "Active",
      "icon": "assets/icon/favourite.png",
      "type": "Drink",
    },
    {
      "image": "assets/home_images/kfc_latest_reward.png",
      "message": "Free Fries With Meal",
      "point": "90",
      "name": "KFC",
      "date": "2025-12-20",
      "status": "Active",
      "icon": "assets/icon/favourite.png",
      "type": "Food",
    },
    {
      "image": "assets/home_images/mc_latest_reward.png",
      "message": "50% Off Ice Cream",
      "point": "80",
      "name": "McDonald's",
      "date": "2025-12-05",
      "status": "Active",
      "icon": "assets/icon/favourite.png",
      "type": "Food",
    },
    {
      "image": "assets/home_images/starbucks_latest_reward.png",
      "message": "Buy 2 Get 1 Free Coffee",
      "point": "160",
      "name": "Starbucks",
      "date": "2025-11-15",
      "status": "Active",
      "icon": "assets/icon/favourite.png",
      "type": "Drink",
    },
    {
      "image": "assets/home_images/amazon_latest_reward.png",
      "message": "Free Coffee ",
      "point": "200",
      "name": "Cafe Amazon",
      "date": "2025-12-22",
      "status": "Active",
      "icon": "assets/icon/favourite.png",
      "type": "Drink",
    },
    {
      "image": "assets/home_images/kfc2_latest_reward.png",
      "message": "Free Dessert With Meal",
      "point": "130",
      "name": "KFC",
      "date": "2025-12-30",
      "status": "Active",
      "icon": "assets/icon/favourite.png",
      "type": "Food",
    },
    {
      "image": "assets/home_images/mc_latest_reward.png",
      "message": "Free Coffee Shot",
      "point": "100",
      "name": "McDonald's",
      "date": "2025-12-12",
      "status": "Active",
      "icon": "assets/icon/favourite.png",
      "type": "Drink",
    },
  ];

  late int selected;
  int _navSelectedIndex = 2;
  List<Map<String, dynamic>> filteredData = [];

  void _onNavItemTapped(int index) {
    setState(() {
      _navSelectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    selected = widget.selectedIndex;
    _filterData(categories[selected]["name"]);
  }

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
          const CreditHomeAppBar(title: "Rewards", enableFilterPoint: true),
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
                          child: RewardMerchantCard(
                            image: item["image"],
                            title: item["message"],
                            merchant: item["name"],
                            valid: validDate,
                            point: item["point"],
                            onTap: () {},
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
            selectedIndex: _navSelectedIndex,
            onItemTapped: _onNavItemTapped,
            localize: AppLocalizations.of(context)!,
          ),
        ),
      ),
    );
  }
}
