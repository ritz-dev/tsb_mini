import 'package:flutter/material.dart';
import 'package:tsb_mini/frame/header/history/credit_earn_use.dart';
// for AppColors.filterButtonBackground

class CreditHistoryHeader extends StatelessWidget {
  const CreditHistoryHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
      pinned: true,
      delegate: _FilterHeaderDelegate(),
    );
  }
}

class _FilterHeaderDelegate extends SliverPersistentHeaderDelegate {
  @override
  double get minExtent => 190;

  @override
  double get maxExtent => 190;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    final double currentExtent = (maxExtent - shrinkOffset).clamp(
      minExtent,
      maxExtent,
    );

    return Material(
      color: Colors.transparent,
      elevation: 0,
      child: SizedBox(
        height: currentExtent,
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.white, // or your gradient
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 0),
                child: const CreditEarnUse(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      true;
}
