import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tsb_mini/frame/app_bar/credit_app_bar.dart';
import 'package:tsb_mini/package_mode.dart';
import 'package:tsb_mini/screen/reward/reward_detail_page.dart';
import 'package:tsb_mini/screen/reward/reward_detail_test.dart';
import 'package:tsb_mini/theme/color_theme.dart';
import 'package:intl/intl.dart'; // <-- added for date formatting

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
  // == STARBUCKS 1 COUNT ===
  {
    "slug": "1000100010007000",
    "status": "active",
    "datetime": "2025-07-20T09:00:00Z",
    "expiry_date": "2025-12-15T23:59:59Z",
    "merchant_logo": "assets/home_images/tm.png",
    "merchant_name": "Starbucks",
    "reward_name": "Free Handcrafted Drink",
  },

  // === TRUE (3 duplicates) ===
  {
    "slug": "1000100010001000",
    "status": "active",
    "datetime": "2025-08-10T10:00:00Z",
    "expiry_date": "2025-11-30T23:59:59Z",
    "merchant_logo": "assets/home_images/truesg.png",
    "merchant_name": "True",
    "reward_name": "Prepaid 5G Coupon",
  },
  {
    "slug": "1000100010001000",
    "status": "active",
    "datetime": "2025-08-12T11:00:00Z",
    "expiry_date": "2025-11-30T23:59:59Z",
    "merchant_logo": "assets/home_images/truesg.png",
    "merchant_name": "True",
    "reward_name": "Prepaid 5G Coupon",
  },
  {
    "slug": "1000100010001000",
    "status": "active",
    "datetime": "2025-08-15T09:30:00Z",
    "expiry_date": "2025-11-30T23:59:59Z",
    "merchant_logo": "assets/home_images/truesg.png",
    "merchant_name": "True",
    "reward_name": "Prepaid 5G Coupon",
  },
  // === KFC (1 count) ===
  {
  "slug": "1000100010008000", 
  "status": "active",
  "datetime": "2025-09-05T12:00:00Z",
  "expiry_date": "2025-11-30T23:59:59Z",
  "merchant_logo": "assets/home_images/kfc.png",
  "merchant_name": "Uniqlo",
  "reward_name": "Buy 1 Get 1 Free",
},  

  // === STARBUCKS (5 duplicates) ===
  {
    "slug": "1000100010002000",
    "status": "active",
    "datetime": "2025-07-20T09:00:00Z",
    "expiry_date": "2025-12-15T23:59:59Z",
    "merchant_logo": "assets/home_images/tm.png",
    "merchant_name": "Starbucks",
    "reward_name": "Free Handcrafted Drink",
  },
  {
    "slug": "1000100010002000",
    "status": "active",
    "datetime": "2025-07-22T09:45:00Z",
    "expiry_date": "2025-12-15T23:59:59Z",
    "merchant_logo": "assets/home_images/tm.png",
    "merchant_name": "Starbucks",
    "reward_name": "Free Handcrafted Drink",
  },
  {
    "slug": "1000100010002000",
    "status": "active",
    "datetime": "2025-07-25T08:15:00Z",
    "expiry_date": "2025-12-15T23:59:59Z",
    "merchant_logo": "assets/home_images/tm.png",
    "merchant_name": "Starbucks",
    "reward_name": "Free Handcrafted Drink",
  },
  {
    "slug": "1000100010002000",
    "status": "active",
    "datetime": "2025-07-28T10:00:00Z",
    "expiry_date": "2025-12-15T23:59:59Z",
    "merchant_logo": "assets/home_images/tm.png",
    "merchant_name": "Starbucks",
    "reward_name": "Free Handcrafted Drink",
  },
  {
    "slug": "1000100010002000",
    "status": "active",
    "datetime": "2025-07-30T11:30:00Z",
    "expiry_date": "2025-12-15T23:59:59Z",
    "merchant_logo": "assets/home_images/tm.png",
    "merchant_name": "Starbucks",
    "reward_name": "Free Handcrafted Drink",
  },

  // === KFC (2 duplicates) ===
  {
    "slug": "1000100010003000",
    "status": "active",
    "datetime": "2025-06-18T13:00:00Z",
    "expiry_date": "2025-10-25T23:59:59Z",
    "merchant_logo": "assets/home_images/kfc.png",
    "merchant_name": "KFC",
    "reward_name": "Free Bucket On Us",
  },
  {
    "slug": "1000100010003000",
    "status": "active",
    "datetime": "2025-06-20T14:15:00Z",
    "expiry_date": "2025-10-25T23:59:59Z",
    "merchant_logo": "assets/home_images/kfc.png",
    "merchant_name": "KFC",
    "reward_name": "Free Bucket On Us",
  },

  // === ADIDAS (3 duplicates, 1 expired) ===
  {
    "slug": "1000100010004000",
    "status": "expired",
    "datetime": "2025-05-01T08:30:00Z",
    "expiry_date": "2025-09-30T23:59:59Z",
    "merchant_logo": "assets/home_images/adidas.png",
    "merchant_name": "Adidas",
    "reward_name": "15% Off Voucher",
  },
  {
    "slug": "1000100010004000",
    "status": "expired",
    "datetime": "2025-05-03T08:45:00Z",
    "expiry_date": "2025-09-30T23:59:59Z",
    "merchant_logo": "assets/home_images/adidas.png",
    "merchant_name": "Adidas",
    "reward_name": "15% Off Voucher",
  },
  {
    "slug": "1000100010004000",
    "status": "expired",
    "datetime": "2025-05-05T09:10:00Z",
    "expiry_date": "2025-09-30T23:59:59Z",
    "merchant_logo": "assets/home_images/adidas.png",
    "merchant_name": "Adidas",
    "reward_name": "15% Off Voucher",
  },

  // === SINGLE-COUNT EXAMPLES (will show "one" background) ===
  {
    "slug": "1000100010005000",
    "status": "active",
    "datetime": "2025-09-01T10:00:00Z",
    "expiry_date": "2025-12-01T23:59:59Z",
    "merchant_logo": "assets/home_images/adidas.png",
    "merchant_name": "Zara",
    "reward_name": "10% Off Select Items",
  },

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
                    horizontal: 10,
                    vertical: 0,
                  ),
                  itemCount: coupons.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 16),
                  itemBuilder: (context, index) {
                    final coupon = coupons[index];

                    // safe values with fallbacks to avoid null runtime errors
                    final image = (coupon['merchant_logo'] as String?) ??
                        'assets/home_images/default.png';
                    final title =
                        (coupon['reward_name'] as String?) ?? 'Unknown Reward';
                    final merchant = (coupon['merchant_name'] as String?) ?? '';

                    // format expiry date if present
                    String valid = '';
                    final expiry = coupon['expiry_date'];
                    if (expiry != null) {
                      try {
                        final dt = DateTime.parse(expiry.toString());
                        valid = 'Valid Until ${DateFormat('d MMMM y').format(dt)}';
                      } catch (_) {
                        valid = expiry.toString();
                      }
                    }

                    // compute duplicate count by slug (fallback to reward_name)
                    final key = (coupon['slug'] ?? coupon['reward_name']).toString();
                    final count = coupons
                        .where((c) => (c['slug'] ?? c['reward_name']).toString() == key)
                        .length;

                    return RewardCouponCard(
                      image: image,
                      title: title,
                      merchant: merchant,
                      valid: valid,
                      count: count,
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
// Coupon card widget
class RewardCouponCard extends StatelessWidget {
  final String image;
  final String title;
  final String merchant;
  final String valid;
  final int count;

  /// New callback for when the card is tapped
  final VoidCallback? onTap;

  const RewardCouponCard({
    required this.image,
    required this.title,
    required this.merchant,
    required this.valid,
    required this.count,
    this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final bgAsset = count > 1
        ? "assets/image/reward_card_many.png"
        : "assets/image/reward_card_one.png";

    return SizedBox(
      height: 140,
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => RewardDetailTest(),
            ),
          );
        }, // <-- Trigger navigation when tapped
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            // Card background + content
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: PackageAssets.image(bgAsset, fit: BoxFit.fill).image,
                  fit: BoxFit.fill,
                ),
                borderRadius: BorderRadius.circular(12),
                color: Colors.white,
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 12,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 56,
                      child: Center(
                        child: PackageAssets.image(
                          image,
                          width: 40,
                          height: 40,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    VerticalDashed(
                      height: 96,
                      dashHeight: 10,
                      dashSpace: 8,
                      thickness: 2,
                      color: AppColors.clearBtn,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.inter(
                              fontWeight: FontWeight.w700,
                              fontSize: 16,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            merchant,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.inter(
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              color: AppColors.textGrey,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  valid,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.inter(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 12,
                                    color: AppColors.textGrey,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  borderRadius: BorderRadius.circular(6),
                                  onTap: () {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text('Use tapped for: $title'),
                                      ),
                                    );
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0,
                                      vertical: 4.0,
                                    ),
                                    child: Text(
                                      'Use',
                                      style: GoogleFonts.inter(
                                        fontWeight: FontWeight.w800,
                                        fontSize: 12,
                                        color: const Color(0xFF2E3192),
                                      ),
                                    ),
                                  ),
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
            ),
            if (count > 1)
              Positioned(
                top: 2,
                right: 2,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFF2E3192),
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.12),
                        blurRadius: 6,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Text(
                    "x$count",
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
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

