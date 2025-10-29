import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tsb_main/utils/localization/app_localizations.dart';
import 'package:tsb_mini/screen/coupon/my_coupon_home_page.dart';
import 'package:tsb_mini/screen/history/history_page.dart';
import 'package:tsb_mini/screen/tier/credit_tier.dart';
import 'package:tsb_mini/screen/transfer/credit_transfer.dart';

class QuickActionMenu extends StatelessWidget {
  const QuickActionMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _QuickActionCard(
            icon: SvgPicture.asset(
              'assets/quick_icon/my_coupon.svg',
              width: 25,
              height: 25,
              color: const Color(0xFF083F8C),
            ),
            label: AppLocalizations.of(context)!.translate('my_coupon'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MyRewardPage()),
              );
            },
          ),
          _QuickActionCard(
            icon: SvgPicture.asset(
              'assets/quick_icon/tier.svg',
              width: 25,
              height: 25,
              // color: const Color(0xFF083F8C),
            ),
            label: AppLocalizations.of(context)!.translate('tier'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CarbonTierStateCard(userPoints: 6000),
                ),
              );
            },
          ),
          _QuickActionCard(
            icon: SvgPicture.asset(
              'assets/quick_icon/transfer.svg',
              width: 25,
              height: 25,
              color: const Color(0xFF083F8C),
            ),
            label: AppLocalizations.of(context)!.translate('transfer'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CreditTransferPage()),
              );
            },
          ),
          _QuickActionCard(
            icon: SvgPicture.asset(
              'assets/quick_icon/history.svg',
              width: 25,
              height: 25,
              color: const Color(0xFF083F8C),
            ),
            label: AppLocalizations.of(context)!.translate('history'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CarbonHistoryPage()),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _QuickActionCard extends StatelessWidget {
  final Widget icon;
  final String label;
  final VoidCallback onTap;

  const _QuickActionCard({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 4),
          height: 60,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              icon,
              const SizedBox(height: 4),
              Text(
                label,
                style: GoogleFonts.inter(
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF000000),
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
