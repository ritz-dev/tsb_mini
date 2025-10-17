import 'package:flutter/material.dart';
import 'package:tsb_mini/package_mode.dart';
import 'package:tsb_mini/theme/color_theme.dart';
import 'package:google_fonts/google_fonts.dart';

class RewardDetailContent extends StatelessWidget {
  final String title;
  final String merchant;
  final int used;
  final int expired;
  final String redeemDate;
  final String pointsText;
  final String pointsValue;
  final void Function()? onTapHeart;
  final void Function()? onTapRedeem;

  const RewardDetailContent({
    super.key,
    this.title = 'Free Handcrafted Drink',
    this.merchant = 'Starbucks',
    this.used = 0,
    this.expired = 0,
    this.redeemDate = '22 October 2024',
    this.pointsText = 'Redeemed with',
    this.pointsValue = '200 points',
    this.onTapHeart,
    this.onTapRedeem,
  });

  Widget _buildSmallText(String text) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: AppColors.textGrey,
      ),
    );
  }

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
              color: AppColors.textBlack
            ),
          ),
          const SizedBox(height: 12), // slightly larger spacing to match reference
          Text(
            text,
            style: GoogleFonts.inter(
              fontSize: 13.5,
              color: AppColors.textGrey,
              height: 1.5,          // line-height for comfortable reading and wrapping
              fontWeight: FontWeight.w500,
            ),
            // makes line endings even like the design
            softWrap: true,
          ),
        ],
      );
    }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 18, 20, 24),
      color: AppColors.cardBackground,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title / Merchant
          Text(title, style: GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.w600)),
          const SizedBox(height: 6),
          Text(merchant,
           style: GoogleFonts.inter
            (
              fontSize: 16, 
              fontWeight: FontWeight.w500, 
              color: Color(0XFFACACAC),
              letterSpacing: 0.3,
            )
           ),
          const SizedBox(height: 14),

          // expiry + points rows
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
                        text: used == 0 && expired == 0
                            ? 'Expired on '
                            : used == 1 && expired == 0
                                ? 'Used on '
                                : 'Expired on ',
                      ),
                      TextSpan(
                        text: redeemDate,
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
          Row(
            children: [
              PackageAssets.image('assets/reward/star.png', width: 30, height: 30, fit: BoxFit.contain),
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
                      TextSpan(text: '$pointsText '),
                      TextSpan(
                        text: pointsValue,
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
          // Status chip and heart aligned: chip left, heart right
          Row(
            children: [
              if (used == 1)
                _statusRow('Used')
              else if (expired == 1)
                _statusRow('Expired')
              else
                _statusRow('Expired'),
              const Spacer(),
              GestureDetector(
                onTap: onTapHeart,
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  padding: const EdgeInsets.all(8), // space inside the border
                  child: PackageAssets.image(
                    'assets/reward/heart_full.png',
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          // Divider
          const Divider(
            color: AppColors.divider, 
            thickness: 0.5
          ),

          const SizedBox(height: 20),

          // Descriptions
          _buildDescription(
            "Description",
            "New Starbucks Rewards members who join by Sept 28, 2025 get a"
            "one-time coupon for a free handcrafted drink (up to 100THB) at "
            "participating stores. The coupon appears in the app within 48 "
            "hours, is valid for one week after joining, and requires a qualifying "
            "purchase (excluding alcohol, gift cards, and reloads). Not valid for "
            "delivery or combined offers.",
          ),
         const SizedBox(height: 12),
         const Divider(
            color: AppColors.divider,
            thickness: 0.5,
          ),
          const SizedBox(height: 10),
          _buildDescription(
            "Terms and Conditions",
            "You agree to use the Service only for lawful purposes and in a way"
            "that does not fringe the rights of, restrict or inhibit anyone else's"
            "use and enjoyment of the Service.",
          ),
          const SizedBox(height: 12),
          const Divider(
           color: AppColors.divider,
           thickness: 0.5
          ),
          const SizedBox(height: 10),
          _buildDescription(
            "About Merchant",
            "Content created by merchants for their online stores (like product descriptions, images, videos)?",
          ),
          // const SizedBox(height: 12),
          // const Divider(
          //   color: Colors.grey, 
          //   thickness: 0.5
          //   ),
          const SizedBox(height: 24), // padding for bottom button / safe area
        ],
      ),
    );
  }
}