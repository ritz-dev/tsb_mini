import 'package:flutter/material.dart';
import 'package:tsb_main/utils/localization/app_localizations.dart';
import 'package:tsb_mini/frame/button/reward_back_button.dart';

class RewardDetailAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  final VoidCallback? onTapBack;
  final bool enableBack;

  const RewardDetailAppBar({super.key, this.onTapBack, this.enableBack = true});

  @override
  Size get preferredSize => const Size.fromHeight(230);

  @override
  Widget build(BuildContext context) {
    final localize = AppLocalizations.of(context)!;

    return Stack(
      clipBehavior: Clip.none,
      children: [
        // Background image
        Container(
          height: preferredSize.height,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/image/starbucks_main.png'),
              fit: BoxFit.cover,
            ),
          ),
        ),

        // Sticky back button
        if (enableBack)
          Positioned(
            top: 15,
            left: 20,
            child: SafeArea(
              bottom: false,
              child: RewardBackButton(onBack: onTapBack, localize: localize),
            ),
          ),
      ],
    );
  }
}
