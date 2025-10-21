import 'package:flutter/material.dart';
import 'package:tsb_mini/package_mode.dart';
import 'package:tsb_mini/theme/color_theme.dart';
import 'package:google_fonts/google_fonts.dart';

class RewardDetailContent extends StatefulWidget {
  final String title;
  final String merchant;
  final int used;
  final int expired;
  final int active ;
  final String redeemDate;
  final String pointsText;
  final String pointsValue;
  final void Function()? onTapRedeem;

  const RewardDetailContent({
    super.key,
    this.title = 'Free Handcrafted Drink',
    this.merchant = 'Starbucks',
    this.used = 0,
    this.expired = 0,
    this.active = 1,
    this.redeemDate = '22 October 2024',
    this.pointsText = 'Redeemed with',
    this.pointsValue = '200 points',
    this.onTapRedeem,
  });

  @override
  State<RewardDetailContent> createState() => _RewardDetailContentState();
}

class _RewardDetailContentState extends State<RewardDetailContent> {
  bool isHeartFull = false; // initial state

  Widget _statusRow(String text) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: AppColors.filterButtonBackground,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            text,
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.5,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDescription(String title, String text) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.inter(
            fontSize: 17,
            fontWeight: FontWeight.w600,
            color: AppColors.textBlack,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          text,
          style: GoogleFonts.inter(
            fontSize: 13.5,
            color: AppColors.textGrey,
            height: 1.5,
            fontWeight: FontWeight.w500,
          ),
          softWrap: true,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title & merchant
          Text(
            widget.title,
            style: GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 6),
          Text(
            widget.merchant,
            style: GoogleFonts.inter(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: const Color(0XFFACACAC),
              letterSpacing: 0.3,
            ),
          ),
          const SizedBox(height: 14),

          // Expiry info
          Row(
            children: [
              PackageAssets.image(
                'assets/reward/time.png',
                width: 30,
                height: 30,
                fit: BoxFit.contain,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text.rich(
                  TextSpan(
                    style: GoogleFonts.inter(
                      fontSize: 15,
                      color: AppColors.textGrey,
                      fontWeight: FontWeight.w500,
                    ),
                    children: [
                      TextSpan(
                        text: widget.used == 0 && widget.expired == 0
                            ? 'Expired on '
                            : widget.used == 1 && widget.expired == 0
                            ? 'Used on '
                            : 'Expired on ',
                      ),
                      TextSpan(
                        text: widget.redeemDate,
                        style: GoogleFonts.inter(
                          fontSize: 15,
                          color: AppColors.textBlack,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          // Points info
          Row(
            children: [
              PackageAssets.image(
                'assets/reward/star.png',
                width: 30,
                height: 30,
                fit: BoxFit.contain,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text.rich(
                  TextSpan(
                    style: GoogleFonts.inter(
                      fontSize: 15,
                      color: AppColors.textGrey,
                      fontWeight: FontWeight.w500,
                    ),
                    children: [
                      TextSpan(text: '${widget.pointsText} '),
                      TextSpan(
                        text: widget.pointsValue,
                        style: GoogleFonts.inter(
                          fontSize: 15,
                          color: AppColors.textBlack,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          // Status chip and heart with toggle
          Row(
            children: [
              if (widget.used == 1)
                _statusRow('Used')
              else if (widget.active == 1)
                _statusRow('Active')
              else
                _statusRow('Expired'),
              const Spacer(),
              GestureDetector(
                onTap: () {
                  setState(() {
                    isHeartFull = !isHeartFull; // toggle heart
                  });
                  if (widget.onTapRedeem != null) {
                    widget.onTapRedeem!(); // optional callback
                  }
                },
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: const BoxDecoration(shape: BoxShape.circle),
                  padding: const EdgeInsets.all(8),
                  child: PackageAssets.image(
                    isHeartFull
                        ? 'assets/reward/heart_full.png'
                        : 'assets/reward/heart.png',
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),
          const Divider(color: AppColors.divider, thickness: 0.5),
          const SizedBox(height: 20),

          // Description blocks
          _buildDescription(
            "Description",
            "New Starbucks Rewards members who join by Sept 28, 2025 get a one-time coupon for a free handcrafted drink (up to 100THB) at participating stores. The coupon appears in the app within 48 hours, is valid for one week after joining, and requires a qualifying purchase (excluding alcohol, gift cards, and reloads). Not valid for delivery or combined offers.",
          ),
          const SizedBox(height: 12),
          const Divider(color: AppColors.divider, thickness: 0.5),
          const SizedBox(height: 10),

          _buildDescription(
            "Terms and Conditions",
            "You agree to use the Service only for lawful purposes and in a way that does not infringe the rights of, restrict or inhibit anyone else's use and enjoyment of the Service.",
          ),
          const SizedBox(height: 12),
          const Divider(color: AppColors.divider, thickness: 0.5),
          const SizedBox(height: 10),

          _buildDescription(
            "About Merchant",
            "Content created by merchants for their online stores (like product descriptions, images, videos)?",
          ),             // Scan Merchant QR button
         const SizedBox(height: 24), 
        ],
      ),
    );
  }
}
