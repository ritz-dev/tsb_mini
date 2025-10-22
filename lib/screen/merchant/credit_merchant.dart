import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tsb_mini/frame/app_bar/credit_app_bar.dart';
import 'package:tsb_mini/frame/app_bar/credit_merchant_app_bar.dart';
import 'package:tsb_mini/frame/app_bar/merchat_app_bar.dart';
import 'package:tsb_mini/package_mode.dart';
import 'package:tsb_mini/screen/reward/latest_reward_collection.dart';

class CreditMarchant extends StatefulWidget {
  const CreditMarchant({super.key});

  @override
  State<CreditMarchant> createState() => _CreditMarchantState();
}

class _CreditMarchantState extends State<CreditMarchant> {
  final TextEditingController _searchController = TextEditingController();
  String searchText = "";

  // At the top-level (outside any class)
  List<Map<String, dynamic>> merchants = [
    {"name": "True 5G", "image": "assets/home_images/truesg.png"},
    {"name": "KFC", "image": "assets/home_images/kfc.png"},
    {"name": "Starbucks", "image": "assets/home_images/tm.png"},
    {"name": "McDonald's", "image": "assets/home_images/m.png"},
    {"name": "Cafe Amazon", "image": "assets/home_images/cafe_amazon.png"},
    {"name": "Adidas", "image": "assets/home_images/adidas.png"},
    {"name": "NIKE", "image": "assets/home_images/nike.png"},
    {"name": "True 5G", "image": "assets/home_images/truesg.png"},
    {"name": "KFC", "image": "assets/home_images/kfc.png"},
    {"name": "Starbucks", "image": "assets/home_images/tm.png"},
    {"name": "McDonald's", "image": "assets/home_images/m.png"},
    {"name": "Cafe Amazon", "image": "assets/home_images/cafe_amazon.png"},
    {"name": "Adidas", "image": "assets/home_images/adidas.png"},
    {"name": "NIKE", "image": "assets/home_images/nike.png"},
    {"name": "True 5G", "image": "assets/home_images/truesg.png"},
    {"name": "KFC", "image": "assets/home_images/kfc.png"},
    {"name": "Starbucks", "image": "assets/home_images/tm.png"},
    {"name": "McDonald's", "image": "assets/home_images/m.png"},
    {"name": "Cafe Amazon", "image": "assets/home_images/cafe_amazon.png"},
    {"name": "Adidas", "image": "assets/home_images/adidas.png"},
    {"name": "NIKE", "image": "assets/home_images/nike.png"},
    {"name": "True 5G", "image": "assets/home_images/truesg.png"},
    {"name": "KFC", "image": "assets/home_images/kfc.png"},
    {"name": "Starbucks", "image": "assets/home_images/tm.png"},
    {"name": "McDonald's", "image": "assets/home_images/m.png"},
    {"name": "Cafe Amazon", "image": "assets/home_images/cafe_amazon.png"},
    {"name": "Adidas", "image": "assets/home_images/adidas.png"},
    {"name": "NIKE", "image": "assets/home_images/nike.png"},
    // ...add more as needed
  ];

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      setState(() {
        searchText = _searchController.text;
      });
    });
  }

  int _selectedIndex = 0; // Default active is "List"

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Filter merchants by search text
    final filteredMerchants = merchants
        .where(
          (merchant) =>
              merchant["name"].toLowerCase().contains(searchText.toLowerCase()),
        )
        .toList();

    return Scaffold(
      appBar: 
        // preferredSize: const Size.fromHeight(130),
        // child: 
        CreditMerchantAppBar(
          title: 'Merchants',
          enableBack: true,
          // enableSearch: true,
        ),
      // ),
      body: Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: GridView.builder(
          itemCount: filteredMerchants.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            mainAxisSpacing: 18,
            crossAxisSpacing: 8,
            childAspectRatio: 0.8,
          ),
          itemBuilder: (context, index) {
            final merchant = filteredMerchants[index];
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        RewardCollection(), // Go to merchant detail page
                  ),
                );
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircleAvatar(
                    radius: 28,
                    backgroundImage: PackageAssets.image(merchant["image"]).image,
                    backgroundColor: Colors.white,
                  ),
                  const SizedBox(height: 6),
                  Text(
                    merchant["name"],
                    style: GoogleFonts.inter(
                      fontWeight: FontWeight.w600,
                      fontSize: 13,
                      color: Colors.black87,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 2,
                  ),
                ],
              ),
            );
          },
        ),
      ),
      // bottomNavigationBar: BottomNavBarFrame(
      //   currentIndex: _selectedIndex,
      //   onTap: _onItemTapped,
      // ),
    );
  }
}

// Simple merchant detail page
class MerchantDetailPage extends StatelessWidget {
  final Map<String, dynamic> merchant;
  const MerchantDetailPage({required this.merchant, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(merchant["name"])),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            PackageAssets.image(
              merchant["image"], 
              width: 100, 
              height: 100,
            ),
            const SizedBox(height: 20),
            Text(
              merchant["name"],
              style: GoogleFonts.inter(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
