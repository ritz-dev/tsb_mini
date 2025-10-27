import 'package:flutter/material.dart';
import 'package:tsb_main/frame/navigation/bottom_navigation_frame.dart';
import 'package:tsb_main/screen/pass_main.dart';
import 'package:tsb_main/utils/localization/app_localizations.dart';
import 'package:tsb_mini/frame/app_bar/credit_app_bar.dart';
import 'package:tsb_mini/frame/app_bar/reward_sliver_app_bar.dart';
import 'package:tsb_mini/frame/body/home/famous_merchant.dart';
import 'package:tsb_mini/frame/body/home/food_slide.dart';
import 'package:tsb_mini/frame/body/home/latest_reward_card.dart';
import 'package:tsb_mini/frame/header/home/credit_reward_filter_header.dart';

class RewardPage extends StatefulWidget {
  const RewardPage({super.key, required this.localize});

  final AppLocalizations localize;

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
    final localize = widget.localize;

    return Scaffold(
      // backgroundColor: const Color(0xff083f8c),
      appBar: CreditHomeAppBar(
        title: localize.translate('rewards'),
        enableBack: true,
        enableHeart: true,
        onTapBack: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => CarbonPassingPage(localize: localize),
            ),
          );
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
              physics: const ClampingScrollPhysics(), // Smooth, no bounce
              slivers: [
                const RewardAppBar(),
                const RewardFilterHeader(),
                SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 0.0),
                  sliver: SliverToBoxAdapter(
                    child: AnimatedSmoothScrollWrapper(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 18),
                          LatestRewardCard(
                            title: localize.translate('latest_rewards'),
                          ),
                          const SizedBox(height: 18),
                          const FamousMerchant(),
                          const SizedBox(height: 18),
                          FoodSlideCard(title: localize.translate('food')),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: BottomNavigationFrame(
          selectedIndex: _selectedIndex,
          onItemTapped: _onItemTapped,
          localize: widget.localize,
        ),
      ),
    );
  }
}

/// A smooth transition animation wrapper for fade + slide-in effects.
class AnimatedSmoothScrollWrapper extends StatefulWidget {
  final Widget child;

  const AnimatedSmoothScrollWrapper({super.key, required this.child});

  @override
  State<AnimatedSmoothScrollWrapper> createState() =>
      _AnimatedSmoothScrollWrapperState();
}

class _AnimatedSmoothScrollWrapperState
    extends State<AnimatedSmoothScrollWrapper>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 001), // smooth transition speed
    );

    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.ease, // smooth easing
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.01),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: SlideTransition(position: _slideAnimation, child: widget.child),
    );
  }
}
