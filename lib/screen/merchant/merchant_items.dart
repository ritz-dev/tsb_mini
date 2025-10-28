import 'package:flutter/material.dart';
import 'package:tsb_main/frame/navigation/bottom_navigation_frame.dart';
import 'package:tsb_mini/frame/app_bar/credit_app_bar.dart';
import 'package:tsb_mini/frame/body/favourite/latest_reward_point_card.dart';
import 'package:intl/intl.dart';
import 'package:tsb_main/utils/localization/app_localizations.dart';

class MerchantItems extends StatefulWidget {
  final String? search;
  final double? minPoint;
  final double? maxPoint;

  const MerchantItems({
    super.key,
    this.search,
    this.minPoint,
    this.maxPoint,
  });

  @override
  State<MerchantItems> createState() => _MerchantItemsState();
}

class _MerchantItemsState extends State<MerchantItems> {
  int _selectedIndex = 2;

  final List<Map<String, dynamic>> data = [
    {
      "image": "assets/home_images/amazon_latest_reward.png",
      "message": "Buy 9 Cups, Get 1 Free",
      "point": "140",
      "name": "Cafe Amazon",
      "date": "2025-12-18",
      "status": "Active",
      "icon": "assets/icon/favourite.png",
    },
    {
      "image": "assets/home_images/mc_latest_reward.png",
      "message": "Free Handcrafted Drink",
      "point": "120",
      "name": "McDonald's",
      "date": "2025-11-28",
      "status": "Active",
      "icon": "assets/icon/favourite.png",
    },
    {
      "image": "assets/home_images/kfc2_latest_reward.png",
      "message": "Buy One Get One Free",
      "point": "150",
      "name": "KFC",
      "date": "2025-11-30",
      "status": "Active",
      "icon": "assets/icon/favourite.png",
    },
      {
      "image": "assets/home_images/kfc_latest_reward.png",
      "message": "Free Bucket On Us",
      "point": "100",
      "name": "KFC",
      "date": "2025-12-15",
      "status": "Active",
      "icon": "assets/icon/favourite.png",
    },
    {
      "image": "assets/home_images/amazon_latest_reward.png",
      "message": "Free Coffee ",
      "point": "200",
      "name": "Cafe Amazon",
      "date": "2025-12-22",
      "status": "Active",
      "icon": "assets/icon/favourite.png",
    },
    {
      "image": "assets/home_images/starbucks2_latest_reward.png",
      "message": "60% Off One Time",
      "point": "110",
      "name": "Starbucks",
      "date": "2025-10-25",
      "status": "Active",
      "icon": "assets/icon/favourite.png",
    },
    // New unique rewards
    {
      "image": "assets/home_images/kfc_latest_reward.png",
      "message": "Free Fries With Meal",
      "point": "90",
      "name": "KFC",
      "date": "2025-12-20",
      "status": "Active",
      "icon": "assets/icon/favourite.png",
    },
    {
      "image": "assets/home_images/mc_latest_reward.png",
      "message": "50% Off Ice Cream",
      "point": "80",
      "name": "McDonald's",
      "date": "2025-12-05",
      "status": "Active",
      "icon": "assets/icon/favourite.png",
    },
    {
      "image": "assets/home_images/starbucks_latest_reward.png",
      "message": "Buy 2 Get 1 Free Coffee",
      "point": "160",
      "name": "Starbucks",
      "date": "2025-11-15",
      "status": "Active",
      "icon": "assets/icon/favourite.png",
    },
    {
      "image": "assets/home_images/kfc2_latest_reward.png",
      "message": "Free Dessert With Meal",
      "point": "130",
      "name": "KFC",
      "date": "2025-12-30",
      "status": "Active",
      "icon": "assets/icon/favourite.png",
    },
  ];

  /// Format date to "dd MMM yyyy" (e.g. 27 Oct 2025)
  /// and show "Expired on" if already past
  String formatDate(String dateStr) {
    try {
      final date = DateTime.parse(dateStr);
      final formattedDate = DateFormat("dd MMM yyyy").format(date);

      // Compare with today's date
      if (date.isBefore(DateTime.now())) {
        return "Expired on $formattedDate";
      } else {
        return "End on $formattedDate";
      }
    } catch (e) {
      return dateStr;
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          CreditHomeAppBar(
            title: "Merchants"
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  // borderRadius: BorderRadius.only(
                  //   topLeft: Radius.circular(20),
                  //   topRight: Radius.circular(20),
                  // ),
                ),
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(
                    vertical: 12,
                    horizontal: 16,
                  ),
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    final item = data[index];
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
                        // icon: item["icon"],
                        onTap: () {
                          // Navigate to detail page if needed
                        },
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: BottomNavigationFrame(
          selectedIndex: _selectedIndex,
          onItemTapped: _onItemTapped,
          localize: AppLocalizations.of(context)!,
        ),
      ),
    );
  }
}
