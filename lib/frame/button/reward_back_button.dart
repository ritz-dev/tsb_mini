import 'package:flutter/material.dart';
import 'package:tsb_main/utils/localization/app_localizations.dart';
import 'package:tsb_mini/screen/home/home_page.dart';
import 'package:tsb_mini/theme/icon_theme.dart';

class RewardBackButton extends StatelessWidget {
  final VoidCallback? onBack;
  final AppLocalizations localize; // required localization

  const RewardBackButton({super.key, this.onBack, required this.localize});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap:
          onBack ??
          () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => RewardPage(localize: localize)),
            );
          },
      borderRadius: BorderRadius.circular(30),
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.15),
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF4069A2).withOpacity(0.01),
              offset: const Offset(2, 4),
              blurRadius: 2,
            ),
          ],
        ),
        child: Center(
          child: AppIcons.backButtonIcon(
            color: const Color.fromARGB(255, 240, 240, 240),
            size: 24,
          ),
        ),
      ),
    );
  }
}
