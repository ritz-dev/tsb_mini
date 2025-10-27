import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tree_circle_progress/tree_circle_point_progress_card.dart';
import 'package:tsb_mini/frame/header/home/credit_home_qr_card.dart';
import 'package:tree_circle_progress/main.dart';

class RewardAppBar extends StatelessWidget {
  const RewardAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 520,
      floating: false,
      pinned: false,
      backgroundColor: Colors.white, // Make sure this is transparent
      elevation: 0, // Remove shadow if you want a flat look
      systemOverlayStyle: SystemUiOverlayStyle.light,
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          margin: const EdgeInsets.only(top: 15),
          decoration: const BoxDecoration(
            color: Colors.white, // No color here
          ),
          child: SafeArea(
            top: false,
            child: Padding(
              padding: const EdgeInsets.symmetric(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: TreeCirclePointProgressCard(
                      treesPlanted: 30,
                      pointsRemaining: 495,
                      assetPackage: 'tree_circle_progress',
                    ),
                    // child: TreeCirclePointProgressCard(
                    //   treesPlanted: 30,
                    //   pointsRemaining: 495,
                    // ),
                  ),
                  const CreditHomeQrCard(),
                ],
              ),
            ),  
          ),
        ),
      ),
    );
  }
}
