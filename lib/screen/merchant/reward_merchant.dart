import 'package:flutter/material.dart';
import 'package:tsb_mini/frame/app_bar/credit_app_bar.dart';
import 'package:tsb_mini/frame/body/favourite/reward_favourite_card.dart';
import 'package:intl/intl.dart';
import 'package:tsb_mini/frame/favourite/category_header.dart';
import 'package:tsb_mini/theme/icon_theme.dart';

class RewardMarchant extends StatefulWidget {
  final String? search;
  final double? minPoint;
  final double? maxPoint;

  const RewardMarchant({super.key, this.search, this.minPoint, this.maxPoint});

  @override
  State<RewardMarchant> createState() => _RewardMarchantState();
}

class _RewardMarchantState extends State<RewardMarchant> {
  final List<Map<String, dynamic>> categories = [
    {"icon": AppIcons.allPngPath, "name": "All"},
    {"icon": AppIcons.drinkPngPath, "name": "Drink"},
    {"icon": AppIcons.foodPngPath, "name": "Food"},
    {"icon": AppIcons.shoppingPngPath, "name": "Shopping"},
    {"icon": AppIcons.fashionPngPath, "name": "Fashion"},
  ];

final List<Map<String, dynamic>> data = [
    {
      "image": "assets/home_images/starbucks_latest_reward.png",
      "message": "Free Handcrafted Drink with Seasonal Flavors Included",
      "point": "100",
      "name": "Starbucks",
      "date": "2025-12-15",
      "status": "Active",
      "icon": "assets/icon/favourite.png",
    },
    {
      "image": "assets/home_images/truesg.png",
      "message": "Prepaid 5G Coupon (True 5G Bonus Pack)",
      "point": "120",
      "name": "True",
      "date": "2025-11-30",
      "status": "Active",
      "icon": "assets/home_image/amazon_latest_reward.png",
    },
    {
      "image": "assets/home_images/kfc_latest_reward.png",
      "message": "Buy 1 Get 1 Free Meal Combo Special Offer",
      "point": "90",
      "name": "KFC",
      "date": "2025-11-30",
      "status": "Active",
      "icon": "assets/icon/favourite.png",
    },
    {
      "image": "assets/home_images/adidas.png",
      "message": "15% Off Voucher for All Footwear and Apparel",
      "point": "150",
      "name": "Adidas",
      "date": "2025-09-30",
      "status": "Expired",
      "icon": "assets/icon/favourite.png",
    },
    {
      "image": "assets/home_images/starbucks_latest_reward.png",
      "message": "Free Handcrafted Drink with Extra Shot and Syrup",
      "point": "100",
      "name": "Starbucks",
      "date": "2025-12-15",
      "status": "Active",
      "icon": "assets/icon/favourite.png",
    },
    {
      "image": "assets/home_images/kfc_latest_reward.png",
      "message": "Free Bucket On Us with Extra Spicy Sauce",
      "point": "80",
      "name": "KFC",
      "date": "2025-10-25",
      "status": "Active",
      "icon": "assets/icon/favourite.png",
    },
    {
      "image": "assets/home_images/truesg.png",
      "message": "True 5G Premium Data Booster Coupon",
      "point": "70",
      "name": "True",
      "date": "2025-11-30",
      "status": "Active",
      "icon": "assets/icon/favourite.png",
    },
    {
      "image": "assets/home_images/adidas.png",
      "message": "10% Off Select Items – Adidas Exclusive",
      "point": "110",
      "name": "Adidas",
      "date": "2025-12-01",
      "status": "Active",
      "icon": "assets/icon/favourite.png",
    },
    {
      "image": "assets/home_images/starbucks_latest_reward.png",
      "message": "Free Iced Americano or Latte (Member Special)",
      "point": "95",
      "name": "Starbucks",
      "date": "2025-11-10",
      "status": "Active",
      "icon": "assets/icon/favourite.png",
    },
    {
      "image": "assets/home_images/kfc_latest_reward.png",
      "message": "Snack Box Free Upgrade Coupon",
      "point": "85",
      "name": "KFC",
      "date": "2025-10-28",
      "status": "Active",
      "icon": "assets/icon/favourite.png",
    },
    {
      "image": "assets/home_images/truesg.png",
      "message": "Free 2GB Data Add-On (True Bonus)",
      "point": "60",
      "name": "True",
      "date": "2025-11-25",
      "status": "Active",
      "icon": "assets/icon/favourite.png",
    },
    {
      "image": "assets/home_images/adidas.png",
      "message": "20% Off Running Gear Limited Coupon",
      "point": "130",
      "name": "Adidas",
      "date": "2025-10-31",
      "status": "Active",
      "icon": "assets/icon/favourite.png",
    },
    {
      "image": "assets/home_images/starbucks_latest_reward.png",
      "message": "Buy 1 Get 1 Free Frappuccino Offer",
      "point": "90",
      "name": "Starbucks",
      "date": "2025-11-05",
      "status": "Active",
      "icon": "assets/icon/favourite.png",
    },
    {
      "image": "assets/home_images/kfc_latest_reward.png",
      "message": "Free Crispy Fries with Chicken Combo",
      "point": "75",
      "name": "KFC",
      "date": "2025-10-30",
      "status": "Active",
      "icon": "assets/icon/favourite.png",
    },
    {
      "image": "assets/home_images/truesg.png",
      "message": "True 5G Holiday Internet Booster Coupon",
      "point": "105",
      "name": "True",
      "date": "2025-12-20",
      "status": "Active",
      "icon": "assets/icon/favourite.png",
    },
  ];

  int selected = 0;

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          CreditHomeAppBar(title: "Rewards", enableFilterPoint: true),
          CategoryHeader(categories: categories, selected: selected),
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
    );
  }
}
