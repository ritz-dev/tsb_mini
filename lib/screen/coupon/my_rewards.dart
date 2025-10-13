
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tsb_mini/frame/app_bar/credit_app_bar.dart';
import 'package:tsb_mini/package_mode.dart';

class MyRewardPage extends StatefulWidget {
  final String? startDate;
  final String? endDate;
  final List<Map<String, dynamic>>? items;

  const MyRewardPage({super.key, this.startDate, this.endDate, this.items});

  @override
  _MyRewardPageState createState() => _MyRewardPageState();
}

class _MyRewardPageState extends State<MyRewardPage> {
  int _selectedIndex = 1;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // Example coupon data
  final List<Map<String, dynamic>> coupons = [
    {
      "image": "assets/home_images/truesg.png",
      "title": "Prepaid 5G Coupon",
      "merchant": "True",
      "valid": "Valid Until 1 October 2025",
      "count": 1,
    },
    {
      "image": "assets/home_images/tm.png",
      "title": "Free Handcrafted Drink",
      "merchant": "Starbucks",
      "valid": "Valid Until 4 October 2025",
      "count": 99,
    },
    {
      "image": "assets/home_images/kfc.png",
      "title": "Free Bucket On Us",
      "merchant": "KFC",
      "valid": "Valid Until 5 October 2025",
      "count": 99,
    },
    {
      "image": "assets/home_images/adidas.png",
      "title": "15% Off Voucher",
      "merchant": "Adidas",
      "valid": "Valid Until 10 October 2025",
      "count": 1,
    },
    {
      "image": "assets/home_images/truesg.png",
      "title": "Prepaid 5G Coupon",
      "merchant": "True",
      "valid": "Valid Until 1 October 2025",
      "count": 1,
    },
    {
      "image": "assets/home_images/tm.png",
      "title": "Free Handcrafted Drink",
      "merchant": "Starbucks",
      "valid": "Valid Until 4 October 2025",
      "count": 99,
    },
    {
      "image": "assets/home_images/kfc.png",
      "title": "Free Bucket On Us",
      "merchant": "KFC",
      "valid": "Valid Until 5 October 2025",
      "count": 99,
    },
    {
      "image": "assets/home_images/adidas.png",
      "title": "15% Off Voucher",
      "merchant": "Adidas",
      "valid": "Valid Until 10 October 2025",
      "count": 1,
    },
    // Add more coupons as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: const Color(0xFF0D47A1),
      appBar: CreditHomeAppBar(
        title: 'My Rewards',
        enableBack: true,
        enableScan: true,
        // need to be change with qr scan
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Center(
                  child: Text(
                    'Scan the merchant’s QR code to apply your coupons.',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inter(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: ListView.separated(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  itemCount: coupons.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 16),
                  itemBuilder: (context, index) {
                    final coupon = coupons[index];
                    return RewardCouponCard(
                      image: coupon["image"],
                      title: coupon["title"],
                      merchant: coupon["merchant"],
                      valid: coupon["valid"],
                      count: coupon["count"],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      // bottomNavigationBar: BottomNavBarFrame(
      //   currentIndex: _selectedIndex,
      //   onTap: _onItemTapped,
      // ),
    );
  }
}

// Coupon card widget
class RewardCouponCard extends StatelessWidget {
  final String image;
  final String title;
  final String merchant;
  final String valid;
  final int count;

  const RewardCouponCard({
    required this.image,
    required this.title,
    required this.merchant,
    required this.valid,
    required this.count,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.04),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            children: [
              // Left "ticket" edge
              ClipPath(
                clipper: _TicketEdgeClipper(),
                child: Container(width: 16, height: 90, color: Colors.white),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 14,
                ),
                child: Row(
                  children: [
                    PackageAssets.image(image, width: 40, height: 40),
                    const SizedBox(width: 16),
                    Container(
                      width: 2,
                      height: 50,
                      color: Colors.grey.shade300,
                    ),
                    const SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: GoogleFonts.inter(
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          merchant,
                          style: GoogleFonts.inter(
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            color: Colors.grey[700],
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          valid,
                          style: GoogleFonts.inter(
                            fontWeight: FontWeight.w400,
                            fontSize: 13,
                            color: Colors.grey[500],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        // Coupon count badge
        if (count > 1)
          Positioned(
            top: 10,
            right: 18,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: const Color(0xFF2E3192),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                "x$count",
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 13,
                ),
              ),
            ),
          ),
      ],
    );
  }
}

// Custom clipper for ticket edge
class _TicketEdgeClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.moveTo(0, 0);
    path.lineTo(size.width, 0);
    path.arcToPoint(
      Offset(size.width, size.height),
      radius: Radius.circular(size.width / 2),
      clockwise: false,
    );
    path.lineTo(0, size.height);
    path.arcToPoint(
      Offset(0, 0),
      radius: Radius.circular(size.width / 2),
      clockwise: false,
    );
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
