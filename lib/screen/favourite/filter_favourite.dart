
import 'package:flutter/material.dart';
import 'package:tsb_mini/frame/button/custom_elevated_button.dart';
import 'package:tsb_mini/screen/favourite/favourite.dart';
import 'package:tsb_mini/theme/color_theme.dart';

class FilterFavourite extends StatefulWidget {
  const FilterFavourite({super.key});

  @override
  State<FilterFavourite> createState() => _FilterFavouriteState();
}

class _FilterFavouriteState extends State<FilterFavourite> {

  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _showFilterSheet(context);
    });
  }

  void _showFilterSheet(BuildContext context, {bool keepBottomNavVisible = false}) {
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
          padding: EdgeInsets.only(
            bottom: keepBottomNavVisible ? 70 : 0,
          ),
          child: _filterSearchForm(context),
        );
      },
    );
  }

  Widget _filterSearchForm(BuildContext context) {
    double minValue = 100;
    double maxValue = 10000;

    return StatefulBuilder(
      builder: (context, setState) {
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
              top: 50,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Search TextField
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.scaffoldBackground,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: TextField(
                    controller: _searchController, // ✅ Assign controller
                    decoration: InputDecoration(
                      labelText: "Search...",
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 20,
                        horizontal: 22,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(43),
                        borderSide: BorderSide(
                          color: const Color(0xFF83848B).withOpacity(0.2),
                          width: 1.5,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(43),
                        borderSide: BorderSide(
                          color: const Color(0xFF83848B).withOpacity(0.2),
                          width: 2,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 30),

                // Range Slider
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: SizedBox(
                    width: 350,
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
                        rangeThumbShape: const RoundRangeSliderThumbShape(
                          enabledThumbRadius: 12,
                          pressedElevation: 6,
                        ),
                        rangeTrackShape: const RoundedRectRangeSliderTrackShape(),
                        valueIndicatorShape: const PaddleSliderValueIndicatorShape(),
                        valueIndicatorColor: const Color(0XFF2E3192),
                        valueIndicatorTextStyle: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      child: RangeSlider(
                        values: RangeValues(minValue, maxValue),
                        min: 100,
                        max: 10000,
                        divisions: 100,
                        labels: RangeLabels(
                          "${minValue.toInt()} points",
                          maxValue >= 10000
                              ? "10000+ points"
                              : "${maxValue.toInt()} points",
                        ),
                        onChanged: (RangeValues values) {
                          setState(() {
                            minValue = values.start;
                            maxValue = values.end;
                          });
                        },
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "${minValue.toInt()} points",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      maxValue >= 10000
                          ? "10000+ points"
                          : "${maxValue.toInt()} points",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),

                // Filter Button
                CustomElevatedButton(
                  buttonColor: const Color(0XFF083F8C),
                  textColor: AppColors.textFrosted,
                  buttonTitle: 'Filter',
                  onPressed: () {
                    String search = _searchController.text;
                    // Return search and range to RewardFavouriteCard
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (_) => Favourite(
                          search: search,
                          minPoint: minValue,
                          maxPoint: maxValue,
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
                      minValue = 100;
                      maxValue = 10000;
                      _searchController.clear();

                      Navigator.pop(context);
                    });
                  },
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        );
      },
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return Favourite();
  }
}