import 'package:flutter/material.dart';
import 'package:tsb_mini/frame/app_bar/reward_detail_app_bar.dart';
import 'package:tsb_mini/screen/reward_detail/reward_detail_content.dart';

class RewardDetailTest extends StatefulWidget {
  const RewardDetailTest({super.key});

  @override
  State<RewardDetailTest> createState() => _RewardDetailTestState();
}

class _RewardDetailTestState extends State<RewardDetailTest> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: false,
        child: CustomScrollView(
          slivers: [
            // Use SliverToBoxAdapter to hold a Stack
            SliverToBoxAdapter(
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  // App bar background
                  SizedBox(
                    height: 230,
                    child: RewardDetailAppBar(
                      onTapBack: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ),

                  // Floating circular logo (on top)
                  Positioned(
                    left: 20,
                    bottom: -30, // moves it overlapping the content below
                    child: Material(
                      elevation: 6,
                      shape: const CircleBorder(),
                      clipBehavior: Clip.antiAlias,
                      child: Container(
                        width: 60,
                        height: 60,
                        decoration: const BoxDecoration(shape: BoxShape.circle),
                        child: Image.asset(
                          'assets/icon/starbuck_detail.png',
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            /// White rounded card area (scrollable content)
            SliverToBoxAdapter(
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(22),
                  topRight: Radius.circular(22),
                ),
                child: Container(
                  padding: EdgeInsets.only(top: 30),
                  color: Colors.white,
                  child: const RewardDetailContent(),
                ),
              ),
            ),

            /// Optional bottom padding
            const SliverToBoxAdapter(child: SizedBox(height: 100)),
          ],
        ),
      ),
    );
  }
}
