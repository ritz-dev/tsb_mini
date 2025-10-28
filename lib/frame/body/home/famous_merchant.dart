import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tsb_main/utils/localization/app_localizations.dart';
import 'package:tsb_mini/package_mode.dart';
import 'package:tsb_mini/screen/merchant/merchant.dart';
import 'package:tsb_mini/screen/merchant/merchant_items.dart';

class FamousMerchant extends StatefulWidget {
  const FamousMerchant({super.key});

  @override
  State<FamousMerchant> createState() => _FamousMerchantState();
}

class _FamousMerchantState extends State<FamousMerchant> {
  final List<Map<String, dynamic>> merchants = [
    {"image": "assets/home_images/truesg.png"},
    {"image": "assets/home_images/kfc.png"},
    {"image": "assets/home_images/tm.png"},
    {"image": "assets/home_images/m.png"},
    {"image": "assets/home_images/cafe_amazon.png"},
    {"image": "assets/home_images/truesg.png"},
    {"image": "assets/home_images/kfc.png"},
    {"image": "assets/home_images/tm.png"},
    {"image": "assets/home_images/m.png"},
    {"image": "assets/home_images/cafe_amazon.png"},
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Header
        Container(
          margin: const EdgeInsets.only(bottom: 14),
          color: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                AppLocalizations.of(context)!.translate('famous_merchants'),
                style: GoogleFonts.inter(
                  color: const Color(0XFF000000),
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const MerchantPage(),
                    ),
                  );
                },
                child: Text(
                  AppLocalizations.of(context)!.translate('see_more'),
                  style: GoogleFonts.inter(
                    color: const Color(0XFF1F258D),
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),

        // Merchants horizontal list
        Container(
          margin: const EdgeInsets.only(bottom: 20),
          child: SizedBox(
            height: 70,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: merchants.length,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              separatorBuilder: (context, index) => const SizedBox(width: 20),
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    // Navigate to MerchantPage when tapping merchant image
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const MerchantItems(),
                      ),
                    );
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 4,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: ClipOval(
                          child: PackageAssets.image(
                            merchants[index]['image'],
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
