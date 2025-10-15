import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tsb_mini/frame/app_bar/credit_app_bar.dart';
import 'package:tsb_mini/package_mode.dart';
import 'package:tsb_mini/theme/color_theme.dart';

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
      "image": "assets/home_images/tm.png",
      "title": "Free Handcrafted Drink",
      "merchant": "Starbucks",
      "valid": "Valid Until 4 October 2025",
      "count": 99,
    },
     {
      "image": "assets/home_images/truesg.png",
      "title": "Prepaid 5G Coupon",
      "merchant": "True",
      "valid": "Valid Until 1 October 2025",
      "count": 1,
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
        title: 'My Coupons',
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
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
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
          height: 120,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: PackageAssets.image(
                "assets/image/reward_card_many.png",
                width: double.infinity,
                fit: BoxFit.contain,

              ).image, // <-- important: access the .image property
              fit: BoxFit.cover,
            ),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 5,
                spreadRadius: 0,
                offset: const Offset( -2 , -4),
              ),
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 14,
                ),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: PackageAssets.image(image, width: 40, height: 40),
                    ),
                    const SizedBox(width: 16),
                    // REPLACED: simple Container -> vertical dashed line widget
                    VerticalDashed(
                      height: 100,
                      dashHeight: 12,
                      dashSpace: 10,
                      thickness: 2,
                      color: AppColors.clearBtn,
                    ),
                    const SizedBox(width: 16),
                    Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            style: GoogleFonts.inter(
                              fontWeight: FontWeight.w700,
                              fontSize: 14,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            merchant,
                            style: GoogleFonts.inter(
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              color: AppColors.textGrey,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            valid,
                            style: GoogleFonts.inter(
                              fontWeight: FontWeight.w500,
                              fontSize: 12,
                              color: AppColors.textGrey,
                            ),
                          ),
                        ],
                      ),
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
            top: 0,
            right: 2,
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

class VerticalDashed extends StatelessWidget {
  final double height;
  /// base dash length for the "long" inside dashes
  final double dashHeight;
  /// space between dashes
  final double dashSpace;
  final double thickness;
  final Color color;

  const VerticalDashed({
    super.key,
    this.height = 50,
    this.dashHeight = 6,
    this.dashSpace = 4,
    this.thickness = 2,
    this.color = Colors.grey,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: thickness,
      height: height,
      child: CustomPaint(
        painter: _VerticalDashedPainter(
          dashHeight: dashHeight,
          dashSpace: dashSpace,
          color: color,
          thickness: thickness,
        ),
      ),
    );
  }
}

class _VerticalDashedPainter extends CustomPainter {
  final double dashHeight;
  final double dashSpace;
  final Color color;
  final double thickness;

  _VerticalDashedPainter({
    required this.dashHeight,
    required this.dashSpace,
    required this.color,
    required this.thickness,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = thickness
      ..strokeCap = StrokeCap.round;

    final centerX = size.width / 2;

    // Short dashes for top & bottom, longer dashes for middle
    final shortDash = (dashHeight * 0.3).clamp(1.0, dashHeight);
    final longDash = (dashHeight * 1.2).clamp(dashHeight, dashHeight * 3);

    double y = 0;

    // draw top short dash
    final topEnd = shortDash.clamp(0.0, size.height);
    if (topEnd > 0) {
      canvas.drawLine(Offset(centerX, 0), Offset(centerX, topEnd), paint);
    }
    y = topEnd + dashSpace;

    // draw middle long dashes
    while (y + longDash + dashSpace < size.height - shortDash) {
      final endY = (y + longDash).clamp(0.0, size.height);
      canvas.drawLine(Offset(centerX, y), Offset(centerX, endY), paint);
      y += longDash + dashSpace;
    }

    // draw remaining long (if space) or short before bottom
    if (y < size.height - shortDash) {
      final endY = (size.height - shortDash).clamp(0.0, size.height);
      if (endY > y) {
        canvas.drawLine(Offset(centerX, y), Offset(centerX, endY), paint);
      }
    }

    // draw bottom short dash
    final bottomStart = (size.height - shortDash).clamp(0.0, size.height);
    if (bottomStart < size.height) {
      canvas.drawLine(Offset(centerX, bottomStart), Offset(centerX, size.height), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

