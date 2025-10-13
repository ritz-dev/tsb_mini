
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tsb_mini/frame/app_bar/credit_app_bar.dart';
import 'package:tsb_mini/package_mode.dart';

class MyCouponPage extends StatefulWidget {
  final String? startDate;
  final String? endDate;
  final List<Map<String, dynamic>>? items;

  const MyCouponPage({super.key, this.startDate, this.endDate, this.items});

  @override
  _MyCouponPageState createState() => _MyCouponPageState();
}

class _MyCouponPageState extends State<MyCouponPage> {
  int _selectedIndex = 1;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // Café Amazon coupon data for the UI design
  final List<Map<String, dynamic>> coupons = [
    {
      "image": "assets/home_images/cafe_amazon.png",
      "title": "Buy 9 Cups, Get 1 Free",
      "merchant": "Café Amazon",
      "valid": "Valid Until 10 October 2025",
      "count": 1,
    },
    {
      "image": "assets/home_images/cafe_amazon.png",
      "title": "50% Discount Off",
      "merchant": "Café Amazon",
      "valid": "Valid Until 21 October 2025",
      "count": 1,
    },
    {
      "image": "assets/home_images/cafe_amazon.png",
      "title": "Buy 1 Cup, Get 1 Free",
      "merchant": "Café Amazon",
      "valid": "Valid Until 10 October 2025",
      "count": 1,
    },
    {
      "image": "assets/home_images/cafe_amazon.png",
      "title": "30% Discount For One Drink",
      "merchant": "Café Amazon",
      "valid": "Valid Until 10 October 2025",
      "count": 1,
    },
    {
      "image": "assets/home_images/cafe_amazon.png",
      "title": "30% Discount For One Drink",
      "merchant": "Café Amazon",
      "valid": "Valid Until 10 October 2025",
      "count": 1,
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
        enableFilter: false,
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
                    'Select Your Coupon',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inter(
                      color: Colors.black,
                      fontSize: 20,
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
                  separatorBuilder: (_, __) => const SizedBox(height: 30),
                  itemBuilder: (context, index) {
                    final coupon = coupons[index];
                    return GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          backgroundColor: Colors.transparent,
                          builder: (_) => ConfirmCouponSheet(
                            onUse: () {
                              Navigator.of(context).pop();
                              showModalBottomSheet(
                                context: context,
                                isScrollControlled: true,
                                backgroundColor: Colors.transparent,
                                builder: (_) => SuccessCouponSheet(
                                  onGoToReward: () {
                                    Navigator.of(context).pop();
                                    // Navigate to MyRewardPage or any other page if needed
                                  },
                                  onUseAgain: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              );
                            },
                          ),
                        );
                      },
                      child: RewardCouponCard(
                        image: coupon["image"],
                        title: coupon["title"],
                        merchant: coupon["merchant"],
                        valid: coupon["valid"],
                        count: coupon["count"],
                      ),
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
      clockwise: true,
    );
    path.lineTo(0, size.height);
    path.arcToPoint(
      Offset(0, 0),
      radius: Radius.circular(size.width / 2),
      clockwise: true,
    );
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

// --- Bottom Sheet Widgets ---

class ConfirmCouponSheet extends StatelessWidget {
  final VoidCallback onUse;
  const ConfirmCouponSheet({required this.onUse, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 32, 24, 24),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Confirm Coupon Redemption",
            style: GoogleFonts.inter(
              fontWeight: FontWeight.w700,
              fontSize: 18,
              color: Colors.black,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 12),
          Text(
            "Are you sure you want to redeem this coupon?\nIt will no longer be available for future use.",
            style: GoogleFonts.inter(
              fontWeight: FontWeight.w400,
              fontSize: 12,
              color: Colors.grey[700],
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 28),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF0D47A1),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                padding: const EdgeInsets.symmetric(vertical: 20),
              ),
              onPressed: onUse,
              child: Text(
                "Use",
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                side: BorderSide(color: Colors.grey.shade300),
                padding: const EdgeInsets.symmetric(vertical: 20),
              ),
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                "Cancel",
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  color: Colors.grey[700],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SuccessCouponSheet extends StatelessWidget {
  final VoidCallback onGoToReward;
  final VoidCallback onUseAgain;
  const SuccessCouponSheet({
    required this.onGoToReward,
    required this.onUseAgain,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 32, 24, 24),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.check_circle, color: Color(0xFF0D47A1), size: 48),
          const SizedBox(height: 16),
          Text(
            "Coupon Applied Successfully at Merchant Checkout",
            style: GoogleFonts.inter(
              fontWeight: FontWeight.w700,
              fontSize: 18,
              color: Colors.black,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 12),
          Text(
            "The coupon was successfully redeemed at the merchant's platform during checkout.",
            style: GoogleFonts.inter(
              fontWeight: FontWeight.w400,
              fontSize: 12,
              color: Colors.grey[700],
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 28),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF0D47A1),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                padding: const EdgeInsets.symmetric(vertical: 20),
              ),
              onPressed: onGoToReward,
              child: Text(
                "Go To My Reward",
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF0D47A1),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
              onPressed: onUseAgain,
              child: Text(
                "Use Coupon Again",
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
