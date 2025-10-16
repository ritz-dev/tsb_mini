import 'package:flutter/material.dart';
import 'package:tsb_main/utils/localization/app_localizations.dart';
import 'package:tsb_mini/frame/button/reward_back_button.dart';

class RewardDetailAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  // Button actions
  final VoidCallback? onTapBack;

  // Controls
  final bool enableBack;

  const RewardDetailAppBar({super.key, this.onTapBack, this.enableBack = true});

  @override
  Size get preferredSize => const Size.fromHeight(230);

  @override
  Widget build(BuildContext context) {
    final localize = AppLocalizations.of(context)!;

    return Container(
      height: preferredSize.height,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/image/starbucks_main.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: SafeArea(
        top: true,
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.only(top: 8.0, left: 12.0, right: 12.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Back button (top-left)
              if (enableBack)
              RewardBackButton(
                    onBack: onTapBack,
                    localize: localize, // localization passed correctly
                  ),
            ],
          ),
        ),
      ),
    );
  }
}
