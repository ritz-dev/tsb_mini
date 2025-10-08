import 'package:flutter/material.dart';
import 'package:tsb_mini/frame/app_bar/credit_app_bar.dart';
import 'package:tsb_mini/frame/app_bar/reward_sliver_app_bar.dart';
import 'package:tsb_mini/frame/body/home/famous_merchant.dart';
import 'package:tsb_mini/frame/body/home/food_slide.dart';
import 'package:tsb_mini/frame/body/home/latest_reward_card.dart';
import 'package:tsb_mini/frame/header/home/credit_reward_filter_header.dart';

class RewardPage extends StatefulWidget {
  const RewardPage({super.key,
  //  required this.localize
   });
  // #############################
  // final AppLocalizations localize;

  @override
  State<RewardPage> createState() => _RewardPageState();
}

class _RewardPageState extends State<RewardPage> {
  int _selectedIndex = 2;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // USE THE PASSED localize FROM WIDGET
    //###################################
    // final localize = widget.localize;

    return Scaffold(
      backgroundColor: const Color(0xFF0A4DA2),
      appBar: CreditHomeAppBar(
        // title: localize.translate('rewards'),
        title: 'Rewards',
        enableBack: true,
        enableHeart: true,
        onTapBack: () {
          // Navigator.pushReplacement(
          //   context,
          //   MaterialPageRoute(
          //     builder: (context) => CarbonPassingPage(
          //       // localize: localize
          //       ),
          //   ),
          // );
        },
      ),
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            child: CustomScrollView(
              physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics(),
              ),
              slivers: [
                const RewardAppBar(),
                const RewardFilterHeader(),
                SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 0.0),
                  sliver: SliverToBoxAdapter(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 12),
                        LatestRewardCard(
                          title: 'Latest Rewards',
                          // title: localize.translate('latest_rewards'),
                        ),
                        const FamousMerchant(),
                        const SizedBox(height: 16),
                        FoodSlideCard(
                          title: 'Food',
                          // title: localize.translate('food')),
                        ),
                        const SizedBox(height: 24),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      // bottomNavigationBar: SafeArea(
      //   child: BottomNavigationFrame(
      //     selectedIndex: _selectedIndex,
      //     onItemTapped: _onItemTapped,
      //     localize: widget.localize,
      //   ),
      // ),
    );
  }
}
