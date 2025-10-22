import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tsb_mini/frame/button/custom_elevated_button.dart';
import 'package:tsb_mini/screen/merchant/reward_collection.dart';
import 'package:tsb_mini/theme/color_theme.dart';
import 'package:tsb_mini/theme/icon_theme.dart';

class RewardFilterButton extends StatefulWidget {
  final VoidCallback? onFilterPoint;

  const RewardFilterButton({super.key, this.onFilterPoint});

  @override
  State<RewardFilterButton> createState() => _RewardFilterButtonState();
}

class _RewardFilterButtonState extends State<RewardFilterButton> {
  final TextEditingController _searchController = TextEditingController();
  double _minValue = 0;
  double _maxValue = 10000;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onFilterPoint ?? () => _showFilterSheet(context),
      borderRadius: BorderRadius.circular(30),
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.15),
          shape: BoxShape.circle,
          // border: Border.all(color: Colors.white.withOpacity(0.2), width: 1.5),
          boxShadow: [
            BoxShadow(
              color: const Color(0XFF4069A2).withOpacity(0.05),
              offset: const Offset(2, 4),
              blurRadius: 8,
            ),
          ],
          // backgroundBlendMode: BlendMode.overlay,
        ),
        child: Center(
          child: AppIcons.filterSvgIcon(
            color: AppColors.appBarIconColor,
            size: 20,
          ),
        ),
      ),
    );
  }

  void _showFilterSheet(
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
          padding: EdgeInsets.only(bottom: keepBottomNavVisible ? 70 : 0),
          child: _filterSearchForm(context),
        );
      },
    );
  }

  Widget _filterSearchForm(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.cardBackground,
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
          top: 30,
        ),
        child: StatefulBuilder(
          builder: (context, setState) {
            return SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // -----------------------------
                  // Search By Name Column
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Search By Name',
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 10),
                      _searchTextField(),
                    ],
                  ),

                  const SizedBox(height: 30),

                  // -----------------------------
                  // Point Range Column
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Point Range',
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 6),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: SizedBox(
                          width: min(320, 320),
                          child: SliderTheme(
                            data: SliderTheme.of(context).copyWith(
                              trackHeight: 3,
                              activeTrackColor: const Color(0XFF2E3192),
                              inactiveTrackColor: Colors.grey.shade400,
                              thumbShape: const RoundSliderThumbShape(
                                enabledThumbRadius: 12,
                                pressedElevation: 6,
                              ),
                              thumbColor: const Color(0XFF2E3192),
                              overlayColor: const Color(0XFF2E3192),
                              valueIndicatorShape:
                                  const PaddleSliderValueIndicatorShape(),
                              valueIndicatorColor: const Color(0XFF2E3192),
                              valueIndicatorTextStyle: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            child: RangeSlider(
                              values: RangeValues(_minValue, _maxValue),
                              min: 0,
                              max: 10000,
                              divisions: 100,
                              labels: RangeLabels(
                                "${_minValue.toInt()} points",
                                _maxValue >= 10000
                                    ? "10000+ points"
                                    : "${_maxValue.toInt()} points",
                              ),
                              onChanged: (values) {
                                setState(() {
                                  _minValue = values.start;
                                  _maxValue = values.end;
                                });
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  // Filter Button
                  CustomElevatedButton(
                    buttonColor: const Color(0XFF083F8C),
                    textColor: AppColors.textFrosted,
                    buttonTitle: 'Filter',
                    onPressed: () {
                      String search = _searchController.text;
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (_) => RewardCollection(
                            search: search,
                            minPoint: _minValue,
                            maxPoint: _maxValue,
                          ),
                        ),
                      );
                    },
                  ),

                  const SizedBox(height: 15),

                  // Clear Button
                  CustomElevatedButton(
                    buttonColor: AppColors.clearTextBtn,
                    textColor: AppColors.clearBtn,
                    buttonTitle: 'Clear',
                    onPressed: () {
                      setState(() {
                        _minValue = 100;
                        _maxValue = 10000;
                        _searchController.clear();
                      });
                      Navigator.pop(context);
                    },
                  ),

                  const SizedBox(height: 20),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  // -----------------------------
  // Reusable Search TextField Widget
  Widget _searchTextField() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.scaffoldBackground,
        borderRadius: BorderRadius.circular(43),
      ),
      child: TextField(
        controller: _searchController,
        decoration: InputDecoration(
          labelText: "Search...",
          labelStyle: GoogleFonts.inter(
            fontSize: 14,
            color: AppColors.textGrey,
            fontWeight: FontWeight.w600,
          ),
          contentPadding: const EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 22,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(43),
            borderSide: BorderSide(
              color: const Color(0xFF959595).withOpacity(0.5),
              width: 1.5,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(43),
            borderSide: BorderSide(
              color: const Color(0xFF959595).withOpacity(0.5),
              width: 2,
            ),
          ),
        ),
        style: GoogleFonts.inter(
          fontSize: 14,
          color: AppColors.textBlack,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}
