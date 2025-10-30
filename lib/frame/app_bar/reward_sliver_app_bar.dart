import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tree_circle_progress/tree_circle_point_progress_card.dart';
import 'package:tsb_mini/frame/header/home/credit_home_qr_card.dart';

class RewardAppBar extends StatelessWidget {
  const RewardAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.only(top: 15, bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AnnotatedRegion<SystemUiOverlayStyle>(
            value: SystemUiOverlayStyle.dark,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: TreeCirclePointProgressCard(
                    treesPlanted: 30,
                    pointsRemaining: 495,
                    assetPackage: 'tree_circle_progress',
                  ),
                ),
                const CreditHomeQrCard(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
