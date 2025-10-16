import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:tsb_mini/frame/button/back_button.dart';
import 'package:tsb_mini/frame/button/heart_button.dart';
import 'package:tsb_mini/package_mode.dart';
import 'package:tsb_mini/theme/color_theme.dart';

/// RewardDetailPage
/// - Sliver-based layout with an expandable header image
/// - Rounded white content container that scrolls up under the appbar (sliver behavior)
/// - Sticky redeem button in bottomNavigationBar
class RewardDetailPage extends StatelessWidget {
  final Map<String, dynamic>? item;

  const RewardDetailPage({super.key, this.item});

  String _formatDate(String isoOrDisplay) {
    try {
      final dt = DateTime.parse(isoOrDisplay);
      return DateFormat('MMMM d, y').format(dt);
    } catch (_) {
      return isoOrDisplay;
    }
  }

  @override
  Widget build(BuildContext context) {
    final title = (item?['reward_name'] as String?) ?? 'Free Handcrafted Drink';
    final merchant = (item?['merchant_name'] as String?) ?? 'Starbucks';
    final expiry = (item?['expiry_date'] as String?) ?? '2025-10-22T00:00:00Z';
    final expiryText = 'Expired on ${_formatDate(expiry)}';
    final pointsText = (item?['points'] != null) ? '${item!['points']} Points' : '200 Points';

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 10, 57, 45),
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
        slivers: [
          SliverAppBar(
            pinned: true,
            stretch: true,
            elevation: 0,
            expandedHeight: 200,
            backgroundColor: Colors.transparent,
            leading: FrostedBackButton(onBack: () => Navigator.maybePop(context)),
            actions: [
              // wrap to match previous spacing if needed
              Padding(
                padding: const EdgeInsets.only(right: 12.0),
                child: FrostedHeartButton(onNavigate: () {}),
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              background: Stack(
                fit: StackFit.expand,
                children: [
                  // header artwork (replace asset path with your banner image)
                  PackageAssets.image(
                    'assets/home_images/starbucks_latest_reward.png',
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,
          
                  ),
                  // dark gradient to improve contrast
                  // Container(
                  //   decoration: BoxDecoration(
                  //     gradient: LinearGradient(
                  //       begin: Alignment.topCenter,
                  //       end: Alignment.bottomCenter,
                  //       colors: [
                  //         Colors.transparent,
                  //         Colors.black.withOpacity(0.2),
                  //       ],
                  //     ),
                  //   ),
                  // ),
                  // optional small merchant logo on the left
                  Positioned(
                    top: 180,
                    left: 20,
                    // bottom: 18,
                    child: CircleAvatar(
                      radius: 22,
                      backgroundColor: Colors.white,
                      child: ClipOval(
                        child: PackageAssets.image(
                          (item?['merchant_logo'] as String?) ?? 'assets/home_images/tm.png',
                          width: 36,
                          height: 36,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // when scrolled the white container below should appear attached to the appbar
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(0),
              child: Container(),
            ),
          ),

          // White rounded content container
          SliverToBoxAdapter(
            child: Container(
              width: double.infinity,
              // This white container has rounded top corners and sits under the appbar
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 18, 20, 32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title
                    Text(
                      title,
                      style: GoogleFonts.inter(fontSize: 20, fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      merchant,
                      style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w500, color: AppColors.textGrey),
                    ),
                    const SizedBox(height: 16),

                    // Expiry and points rows
                    Row(
                      children: [
                        PackageAssets.image('assets/reward/time.png', width: 18, height: 18, fit: BoxFit.contain),
                        const SizedBox(width: 8),
                        Expanded(child: Text(expiryText, style: GoogleFonts.inter(color: AppColors.textGrey))),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        PackageAssets.image('assets/reward/star.png', width: 18, height: 18, fit: BoxFit.contain),
                        const SizedBox(width: 8),
                        Expanded(child: Text('Redeemed with $pointsText', style: GoogleFonts.inter(color: AppColors.textGrey))),
                      ],
                    ),
                    const SizedBox(height: 14),

                    // Status chip + spacer heart
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                          decoration: BoxDecoration(
                            color: AppColors.filterButtonBackground,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Text(
                            'Expired',
                            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
                          ),
                        ),
                        PackageAssets.image('assets/reward/heart_blue_circle.png', fit: BoxFit.contain),
                      ],
                    ),

                    const SizedBox(height: 18),

                    // Description sections
                    Text('Description', style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w600)),
                    const SizedBox(height: 8),
                    Text(
                      'New Starbucks Rewards members who join by Sept 28, 2025 get a one-time coupon for a free handcrafted drink (up to 100THB) at participating stores. The coupon appears in the app within 48 hours, is valid for one week after joining, and requires a qualifying purchase (excluding alcohol, gift cards, and reloads). Not valid for delivery or combined offers.',
                      textAlign: TextAlign.justify,
                      style: GoogleFonts.inter(fontSize: 13, color: AppColors.textLight),
                    ),

                    const SizedBox(height: 18),
                    Text('Terms and Conditions', style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w600)),
                    const SizedBox(height: 8),
                    Text(
                      'Offer valid for new Starbucks Rewards members who join by Sept 28, 2025; one free handcrafted drink (up to 100 THB) coupon issued in app within 48 hours, valid 7 days with qualifying purchase; exclusions apply.',
                      textAlign: TextAlign.justify,
                      style: GoogleFonts.inter(fontSize: 13, color: AppColors.textLight),
                    ),

                    const SizedBox(height: 18),
                    Text('About Merchant', style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w600)),
                    const SizedBox(height: 8),
                    Text(
                      'Content created by merchants for their online stores (like product descriptions, images, videos)?',
                      textAlign: TextAlign.justify,
                      style: GoogleFonts.inter(fontSize: 13, color: AppColors.textLight),
                    ),

                    const SizedBox(height: 40), // spacing so content not hidden by bottom button
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}