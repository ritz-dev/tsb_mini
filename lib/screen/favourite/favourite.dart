import 'package:flutter/material.dart';
import 'package:tsb_mini/frame/app_bar/credit_app_bar.dart';
import 'package:tsb_mini/frame/body/favourite/favourite_card.dart';
import 'package:tsb_mini/frame/favourite/category_header.dart';
import 'package:tsb_mini/theme/icon_theme.dart';

class Favourite extends StatefulWidget {

  final String? search;
  final double? minPoint;
  final double? maxPoint;

  const Favourite({
    super.key,
    this.search,
    this.minPoint,
    this.maxPoint,
  });

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
    {"icon": AppIcons.drinkPngPath, "name": "Drink"},
    {"icon": AppIcons.foodPngPath, "name": "Food"},
    {"icon": AppIcons.shoppingPngPath, "name": "Shopping"},
    {"icon": AppIcons.fashionPngPath, "name": "Fashion"},
  ];
  
  List<Map<String, dynamic>> data = [
    {
      "image": "assets/home_images/starbucks_latest_reward.png",
      "message": "Free Handcrafted Drink",
      "point": "100",
      "name": "Starbucks",
      "date": "October 27, 2024",
      "status": "End",
      "icon" : "assets/icon/favourite.png"
    },
    {
      "image": "assets/home_images/kfc_latest_reward.png",
      "message": "Free Bucket On Us",
      "point": "100",
      "name": "KFC",
      "date": "October 27, 2024",
      "status": "End",
      "icon" : "assets/icon/favourite.png"
    },
    {
      "image": "assets/home_images/amazon_latest_reward.png",
      "message": "Buy 9 Cups, Get 1 Free",
      "point": "100",
      "name": "Cafe Amazon",
      "date": "October 22, 2024",
      "status": "Expired",
      "icon" : "assets/icon/favourite.png"
    },

    {
      "image": "assets/home_images/kfc2_latest_reward.png",
      "message": "Buy One Get One Free",
      "point": "100",
      "name": "KFC",
      "date": "November 11, 2024",
      "status": "End",
      "icon" : "assets/icon/favourite.png"
    },

    {
      "image": "assets/home_images/mc_latest_reward.png",
      "message": "Free Handcrafted Drink",
      "point": "100",
      "name": "McDonald's",
      "date": "November 11, 2024",
      "status": "End",
      "icon" : "assets/icon/favourite.png"
    },
    {
      "image": "assets/home_images/starbucks2_latest_reward.png",
      "message": "60% Off One Time",
      "point": "100",
      "name": "Starbucks",
      "date": "November 11, 2024",
      "status": "End",
      "icon" : "assets/icon/favourite.png"
    },
  ];

  final int selected = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          CreditHomeAppBar(title: "Favourite", enableFilterPoint: true),
          CategoryHeader(categories: categories, selected: selected),
          FavouriteCard(
            data: data,
            search: widget.search,
            minPoint: widget.minPoint,
            maxPoint: widget.maxPoint,
          ),
        ],
      ),
    );
  }
}
