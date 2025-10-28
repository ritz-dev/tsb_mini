import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tsb_main/frame/navigation/bottom_navigation_frame.dart';
import 'package:tsb_mini/frame/app_bar/merchat_app_bar.dart';
import 'package:tsb_mini/package_mode.dart';
import 'package:tsb_mini/screen/merchant/merchant_items.dart';
import 'package:tsb_main/utils/localization/app_localizations.dart';

class MerchantPage extends StatefulWidget {
  const MerchantPage({super.key});

  @override
  State<MerchantPage> createState() => _MerchantPagetState();
}

class _MerchantPagetState extends State<MerchantPage> {
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

  int _selectedIndex = 2; // Default active is "List"

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
      // backgroundColor: const Color(0XFF083F8C),
      body: Column(
        children: [
          MerchantAppBar(
            title: 'Merchants', 
            enableBack: true,
            enableSearch: true,
            searchController: _searchController,
          ),
          Expanded(
            child: Container(
              color: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 0),
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
                          builder: (context) => MerchantItems(),
                        ),
                      );
                    },
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CircleAvatar(
                          radius: 28,
                          backgroundImage: PackageAssets.image(
                            merchant["image"],
                          ).image,
                          backgroundColor: Colors.white,
                        ),
                        const SizedBox(height: 6),
                        Text(
                          merchant["name"],
                          style: GoogleFonts.inter(
                            fontWeight: FontWeight.w600,
                            fontSize: 12,
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
            PackageAssets.image(merchant["image"], width: 100, height: 100),
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
