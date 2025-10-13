import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tsb_main/utils/localization/app_localizations.dart';
import 'package:tsb_mini/screen/coupon/my_rewards.dart';
import 'package:tsb_mini/screen/tier/credit_tier.dart';
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
            icon: AppIcons.ticketPngIcon(size: 20, color: Color(0XFF083F8C)),
            // label: 'My Coupons',
            label: AppLocalizations.of(context)!.translate('my_coupon'),
            onTap: () {
              //My reward page or coupons page
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) =>  MyRewardPage()),
              );
            },
          ),
          _QuickActionCard(
            icon: AppIcons.tierPngIcon(size: 20, color: Color(0XFF083F8C)),
            // label: 'Tier',
            label: AppLocalizations.of(context)!.translate('tier'),
            onTap: () {
              //Tire page
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CarbonTierStateCard(userPoints: 6000),
                ),
              );
            },
          ),
          _QuickActionCard(
            icon: AppIcons.transferSvgIcon(size: 20, color: Color(0XFF083F8C)),
            // label: 'Transfer',
            label: AppLocalizations.of(context)!.translate('transfer'),
            onTap: () {
              //Tire page
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => CreditTransferPage()),
              // );
            },
          ),
          _QuickActionCard(
            icon: AppIcons.logSvgIcon(size: 20, color: Color(0XFF083F8C)),
            // label: 'History',
            label: AppLocalizations.of(context)!.translate('history'),
            onTap: () {
              //Tire page
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => CarbonHistoryPage()),
              // );
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
          height: 60,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: Color.fromARGB(130, 207, 207, 207),
              width: 1,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 3,
                offset: const Offset(1, 1),
              ),
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 3,
                offset: const Offset(-2, -2),
                spreadRadius: 0,
              ),
            ],
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
                  color: Color(0XFF000000),
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
