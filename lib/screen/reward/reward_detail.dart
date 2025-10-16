import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tsb_mini/frame/body/credit_reward/reward_detail_card.dart';
import 'package:tsb_mini/package_mode.dart';
import 'package:tsb_mini/theme/color_theme.dart';

class RewardDetail extends StatefulWidget {
  const RewardDetail({super.key});

  @override
  State<RewardDetail> createState() => _RewardDetailState();
}

class _RewardDetailState extends State<RewardDetail> {
  int redeemStatus = 1;
  int used = 0;
  int expired = 0;
  String redeemDate = "October 22, 2024";

  @override
  void initState() {
    super.initState();
    // Example logic to set expired if redeemDate is in the past

    DateTime redeemDateTime = DateFormat('MMMM d, y').parse(redeemDate);
    if (redeemDateTime.isBefore(DateTime.now())) {
      setState(() {
        expired = 1;
        used = 0;
        redeemStatus = 0;
      });
    }
  }

  void _showRedeemReward(
    BuildContext context, {
    bool keepBottomNavVisible = false,
  }) {
    showModalBottomSheet( 
      context: context,
      isScrollControlled: true,
      useRootNavigator: false,
      backgroundColor: Colors.transparent,
      barrierColor: keepBottomNavVisible
          ? AppColors.barrierBackgroundColor
          : AppColors.barrierBackgroundColor.withOpacity(0.7),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(bottom: keepBottomNavVisible ? 100 : 0),
          child: _redeemBuild(),
        );
      },
    );
  }

  Widget _redeemBuild() {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.amber,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(43),
          topRight: Radius.circular(43),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.only(
          left: 20,
          right: 20,
          bottom: MediaQuery.of(context).viewInsets.bottom,
          top: 20,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              PackageAssets.image(
                "assets/reward/correct_sign.png",
                width: 65,
                height: 65,
                fit: BoxFit.contain,
              ),
              const SizedBox(height: 20),
              _buildText("Get Reward Successfully!"),
              const SizedBox(height: 20),
              _buildSmallText("You’ve successfully got a reward."),
              _buildSmallText(
                "Check your inbox or reward history for more details.",
              ),
              const SizedBox(height: 15),
              _buildGoRewardButton(),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.only(
              bottom: 0,
            ), // leave space for the sticky button
            child: Column(
              children: [
                RewardDetailCard(),
                Container(
                  padding: const EdgeInsets.fromLTRB(32, 0, 32, 0),
                  color: AppColors.error,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          PackageAssets.image(
                            'assets/reward/time.png',
                            fit: BoxFit.contain,
                            width: 20,
                            height: 20,
                          ),
                          const SizedBox(width: 6),
                          if (used == 0 && expired == 0)
                            _buildSmallText("End on $redeemDate"),
                          if (used == 1 && expired == 0)
                            _buildSmallText("Used on $redeemDate"),
                          if (expired == 1 && used == 0)
                            _buildSmallText("Expired on $redeemDate"),
                        ],
                      ),
                      const SizedBox(height: 15),
                      Row(
                        children: [
                          PackageAssets.image(
                            'assets/reward/star.png',
                            fit: BoxFit.contain,
                            width: 20,
                            height: 20,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            '200 Points',
                            style: TextStyle(
                              color: AppColors.textLight,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 15),

                      // Progress or Status Row
                      if (used == 0 && expired == 0)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  LinearProgressIndicator(
                                    value: 14550 / 100,
                                    minHeight: 3,
                                    backgroundColor: Colors.grey.shade300,
                                    valueColor:
                                        const AlwaysStoppedAnimation<Color>(
                                          AppColors.filterButtonBackground,
                                        ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    '14,550 / 100 points',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey.shade600,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 12),
                            Container(
                              margin: const EdgeInsets.fromLTRB(40, 0, 0, 10),
                              width: 36,
                              height: 36,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Colors.grey.shade400,
                                  width: 1.5,
                                ),
                              ),
                              child: const Icon(
                                Icons.favorite_border,
                                color: Colors.black54,
                                size: 20,
                              ),
                            ),
                          ],
                        ),

                      if (used == 1 && expired == 0) _statusRow("Used"),
                      if (used == 0 && expired == 1) _statusRow("Expired"),

                      const SizedBox(height: 10),
                      _buildDescription(
                        "Description",
                        "New Starbucks Rewards members who join by Sept 28, 2025 get a one-time coupon for a free handcrafted drink (up to 100THB) at participating stores. The coupon appears in the app within 48 hours, is valid for one week after joining, and requires a qualifying purchase (excluding alcohol, gift cards, and reloads). Not valid for delivery or combined offers.",
                      ),
                      const SizedBox(height: 10),
                      _buildDescription(
                        "Terms and Conditions",
                        "Offer valid for new Starbucks Rewards members who join by Sept 28, 2025; one free handcrafted drink (up to 100 THB) coupon issued in app within 48 hours, valid 7 days with qualifying purchase; exclusions apply.",
                      ),
                      const SizedBox(height: 10),
                      _buildDescription(
                        "About Merchant",
                        "Content created by merchants for their online stores (like product descriptions, images, videos)?",
                      ),
                      const SizedBox(
                        height: 10,
                      ), // Extra space so last text is not hidden behind button
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Sticky Redeem Button
          if (redeemStatus == 1)
            Positioned(
              bottom: 20,
              left: 20,
              right: 20,
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.filterButtonBackground,
                    padding: const EdgeInsets.symmetric(vertical: 18),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  onPressed: () {
                    _showRedeemReward(context);
                  },
                  child: const Text(
                    "Redeem",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _statusRow(String text) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          padding: const EdgeInsets.fromLTRB(12, 6, 12, 6),
          decoration: BoxDecoration(
            color: AppColors.filterButtonBackground,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            text,
            style: const TextStyle(color: Colors.white, fontSize: 14),
          ),
        ),
        PackageAssets.image('assets/reward/heart_blue_circle.png', fit: BoxFit.contain),
      ],
    );
  }

  Widget _buildDescription(String title, String text) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 10),
        Text(
          text,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: AppColors.textLight,
          ),
          textAlign: TextAlign.justify,
        ),
      ],
    );
  }

  Widget _buildText(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: AppColors.badgeCardBackground,
      ),
    );
  }

  Widget _buildSmallText(String text) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: AppColors.textGrey,
      ),
    );
  }

  Widget _buildGoRewardButton() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.filterButtonBackground,
        padding: const EdgeInsets.symmetric(vertical: 18),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
      ),
      onPressed: () {
        setState(() {
          redeemStatus = 0;
          used = 1;
          expired = 0;
          final now = DateTime.now();
          redeemDate = DateFormat('MMMM d, y').format(now);
        });
        Navigator.pop(context);
      },
      child: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 50),
        child: Text(
          "Go To My Reward",
          style: TextStyle(fontSize: 18, color: Colors.white),
        ),
      ),
    );
  }
}
