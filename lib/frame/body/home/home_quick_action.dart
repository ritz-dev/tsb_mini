import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tsb_main/utils/localization/app_localizations.dart';
import 'package:tsb_mini/screen/coupon/my_coupon_home_page.dart';
import 'package:tsb_mini/screen/history/history_page.dart';
import 'package:tsb_mini/screen/tier/credit_tier.dart';
import 'package:tsb_mini/screen/transfer/credit_transfer.dart';
import 'package:tsb_mini/theme/icon_theme.dart';

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
              'assets/quick_icon/c1.svg',
              width: 38,
              height: 38,
              // color: const Color(0xFF083F8C),
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
              'assets/tier/d1.svg',
              width: 38,
              height: 38,
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
              'assets/quick_icon/tr1.svg',
              width: 38,
              height: 38,
              // color: const Color(0xFF083F8C),
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
              'assets/quick_icon/rc1.svg',
              width: 38,
              height: 38,
              // color: const Color(0xFF083F8C),
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
  final VoidCallback onTap; // added

  const _QuickActionCard({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap, // added
        borderRadius: BorderRadius.circular(16),
        child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 4),
            padding: const EdgeInsets.symmetric(vertical: 8), // gives some spacing
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min, // <<< important
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                icon,
                const SizedBox(height: 4),
                Flexible( // <<< prevents overflow
                  child: Text(
                    label,
                    style: GoogleFonts.inter(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: const Color(0XFF000000),
                    ),
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }
  }
