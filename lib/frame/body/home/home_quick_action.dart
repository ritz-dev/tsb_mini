import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tsb_main/utils/localization/app_localizations.dart';
import 'package:tsb_mini/package_mode.dart';
import 'package:tsb_mini/screen/coupon/my_coupon_home_page.dart';
import 'package:tsb_mini/screen/history/history_page.dart';
import 'package:tsb_mini/screen/tier/credit_tier.dart';
import 'package:tsb_mini/screen/transfer/credit_transfer.dart';

class QuickActionMenu extends StatelessWidget {
  const QuickActionMenu({super.key});

  @override
  Widget build(BuildContext context) {
    // Get total screen width to calculate equal widths
    final screenWidth = MediaQuery.of(context).size.width;
    final itemWidth = (screenWidth - 32) / 4; // minus padding → 4 equal parts

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildActionContainer(
            context,
            itemWidth,
            iconPath: 'assets/quick_icon/coup1.svg',
            labelKey: 'my_coupon',
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => MyRewardPage()),
            ),
          ),
          _buildActionContainer(
            context,
            itemWidth,
            iconPath: 'assets/quick_icon/tier5.svg',
            labelKey: 'tier',
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => CarbonTierStateCard(userPoints: 6000),
              ),
            ),
          ),
          _buildActionContainer(
            context,
            itemWidth,
            iconPath: 'assets/quick_icon/tran3.svg',
            labelKey: 'transfer',
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => CreditTransferPage()),
            ),
          ),
          _buildActionContainer(
            context,
            itemWidth,
            iconPath: 'assets/quick_icon/recent3.svg',
            labelKey: 'history',
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => CarbonHistoryPage()),
            ),
          ),
        ],
      ),
    );
  }

  /// helper builder for each button
  Widget _buildActionContainer(
    BuildContext context,
    double width, {
    required String iconPath,
    required String labelKey,
    required VoidCallback onTap,
  }) {
    return Container(
      width: width,
      decoration: BoxDecoration(
        // border: Border.all(color: Colors.black12, width: 1),
        // borderRadius: BorderRadius.circular(12),
        // color: Color(0xff00b8d4),
      ),
      child: _QuickActionCard(
        icon: PackageAssets.svg(iconPath, width: 38, height: 38),
        label: AppLocalizations.of(context)!.translate(labelKey),
        onTap: onTap,
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
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            icon,
            const SizedBox(height: 4),
            Text(
              label,
              style: GoogleFonts.inter(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: const Color(0xFF000000),
              ),
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
