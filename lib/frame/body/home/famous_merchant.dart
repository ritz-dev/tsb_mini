import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tsb_mini/package_mode.dart';

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
        Container(
          margin: const EdgeInsets.only(bottom: 20),
          color: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Famous Merchants',
                // AppLocalizations.of(context)!.translate('famous_merchants'),
                style: GoogleFonts.inter(
                  color: const Color(0XFF000000),
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              InkWell(
                onTap: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => const CreditMarchant(),
                  //   ),
                  // );
                },
                child: Text(
                  'See more',
                  // AppLocalizations.of(context)!.translate('see_more'),
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
        // Merchants row
        Container(
          margin: const EdgeInsets.only(bottom: 20),
          child: SizedBox(
            height: 70, // total height of the row
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: merchants.length,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              separatorBuilder: (context, index) => const SizedBox(width: 20),
              itemBuilder: (context, index) {
                return Column(
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
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
