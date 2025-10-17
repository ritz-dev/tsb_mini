import 'package:flutter/material.dart';
import 'package:tsb_mini/frame/app_bar/reward_detail_app_bar.dart';
import 'package:tsb_mini/screen/reward_detail/reward_detail_content.dart';

class RewardDetailTest extends StatefulWidget {
  const RewardDetailTest({super.key});

  @override
  State<RewardDetailTest> createState() => _RewardDetailTestState();
}

class _RewardDetailTestState extends State<RewardDetailTest> {
  int _selectedIndex = 2;
  bool _isFavorited = false; // for future toggle state

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Use a CustomScrollView with slivers so header can scroll away and the white card reaches top
    return Scaffold(
      body: SafeArea(
        top: false,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            // Use a sliver-based scroll view so the header can collapse/scroll away
            CustomScrollView(
              slivers: [
                // Header: use the existing RewardDetailAppBar as a sliver-sized box
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: 230, // match RewardDetailAppBar preferredSize
                    child: RewardDetailAppBar(
                      onTapBack: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                ),

                // White rounded card that will scroll up beneath/above the header
                SliverToBoxAdapter(
                  child: Container(
                    // Visual card container
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(22),
                        topRight: Radius.circular(22),
                      ),
                    ),
                    // ClipRRect to keep child contents rounded
                    child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                      child: Padding(
                        // space for the floating logo overlap and visual spacing
                        padding: const EdgeInsets.only(top: 30),
                        child: RewardDetailContent(),
                      ),
                    ),
                  ),
                ),

                // Add some extra space at the bottom so content can scroll above the header
                SliverToBoxAdapter(
                  child: SizedBox(height: 200),
                ),
              ],
            ),

            // Floating circular logo overlapping border (adjust top value as needed)
            Positioned(
              top: 200, // adjust this to align with card border visually
              left: 20,
              child: Material(
                elevation: 2,
                shape: const CircleBorder(),
                clipBehavior: Clip.antiAlias,
                child: Container(
                  width: 55,
                  height: 55,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                  ),
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
      // bottomNavigationBar: SafeArea(
      //   child: BottomNavigationFrame(
      //     selectedIndex: _selectedIndex,
      //     onItemTapped: _onItemTapped,
      //   ),
      // ),
    );
  }
}
