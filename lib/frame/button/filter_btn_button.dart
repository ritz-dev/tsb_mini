import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:heroicons/heroicons.dart';
import 'package:tsb_mini/frame/button/custom_elevated_button.dart';
import 'package:tsb_mini/frame/form/credit_history/calendar.dart';
import 'package:tsb_mini/frame/form/credit_history/checkbox_circle.dart';
import 'package:tsb_mini/screen/history/history_page.dart';
import 'package:tsb_mini/theme/color_theme.dart';
import 'package:tsb_mini/theme/icon_theme.dart';

class FilterButton extends StatefulWidget {
  final VoidCallback? onFilter;

  const FilterButton({super.key, this.onFilter});

  @override
  State<FilterButton> createState() => _FrostedFilterButtonState();
}

class _FrostedFilterButtonState extends State<FilterButton> {
  final TextEditingController _startDateController = TextEditingController();
  final TextEditingController _endDateController = TextEditingController();

  // add search controller and checkbox key
  final TextEditingController _searchController = TextEditingController();
  final GlobalKey<CheckboxCircleState> _checkboxKey = GlobalKey<CheckboxCircleState>();

  @override
  void dispose() {
    _startDateController.dispose();
    _endDateController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onFilter ?? () => _showFilterSheet(context),
      borderRadius: BorderRadius.circular(30),
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.15), // Glassmorphic effect
          shape: BoxShape.circle,
          // border: Border.all(color: Colors.white.withOpacity(0.2), width: 1.5),
          boxShadow: [
            BoxShadow(
              color: Colors.white.withOpacity(0.01),
              offset: const Offset(2, 4),
              blurRadius: 2,
            ),
          ],
          backgroundBlendMode: BlendMode.overlay,
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
          ? AppColors
                .barrierBackgroundColor // transparent background when keeping nav
          : AppColors.barrierBackgroundColor.withOpacity(
              0.7,
            ), // default dim overlay
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: keepBottomNavVisible ? 70 : 0, // reserve space if needed
          ),
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
          top: 10,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              // Search Field
              const SizedBox(height: 20),
              _searchTextField(),
              const SizedBox(height: 20),
              // Type Selection
              Text(
                'Transcation Type',
                style: GoogleFonts.inter(
                  fontSize: 14,
                  color: AppColors.textBlack,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 14),
              // pass the GlobalKey so we can clear selection from parent
              CheckboxCircle(key: _checkboxKey),
              
              //Date Selection
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'From',
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          color: AppColors.textBlack,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12), // small gap between labels
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'To',
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          color: AppColors.textBlack,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Calendar(
                startDateController: _startDateController,
                endDateController: _endDateController,
              ),
              const SizedBox(height: 22),
              _actionButtons(),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _searchTextField() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.scaffoldBackground,
        borderRadius: BorderRadius.circular(43),
      ),
      child: TextField(
        controller: _searchController, // <- wired controller
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

  Widget _actionButtons() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        CustomElevatedButton(
          buttonColor: AppColors.filterButtonBackground,
          textColor: AppColors.textFrosted,
          buttonTitle: 'Filter',
          onPressed: () {
            String start = _startDateController.text
                .split('\n')
                .last; // "dd MMM, yyyy"
            String end = _endDateController.text.split('\n').last;

            print("Start is $start");

            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (_) =>
                    CarbonHistoryPage(startDate: start, endDate: end),
              ),
            );
          },
        ),

        SizedBox(height: 10),

        CustomElevatedButton(
          buttonColor: AppColors.clearTextBtn,
          textColor: AppColors.clearBtn,
          buttonTitle: 'Clear',
          onPressed: () {
            // clear search text
            _searchController.clear();
            // clear checkbox selection if available
            _checkboxKey.currentState?.clearSelection();
          },
        ),
      ],
    );
  }

  Widget _textBuilder(String text) {
    return Text(
      text,
      style: GoogleFonts.inter(
        fontSize: 16,
        color: AppColors.textLight,
        fontWeight: FontWeight.w900,
      ),
    );
  }
}
