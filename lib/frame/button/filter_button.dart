
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tsb_mini/frame/button/custom_elevated_button.dart';
import 'package:tsb_mini/frame/form/credit_history/calendar.dart';
import 'package:tsb_mini/frame/form/credit_history/checkbox_circle.dart';
import 'package:tsb_mini/screen/history/credit_history.dart';
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

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onFilter ?? () => _showFilterSheet(context),
      borderRadius: BorderRadius.circular(30),
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.25), // Glassmorphic effect
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white.withOpacity(0.2), width: 1.5),
          boxShadow: [
            BoxShadow(
              color: Colors.white.withOpacity(0.05),
              offset: const Offset(2, 4),
              blurRadius: 8,
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
              const SizedBox(height: 30),
              _searchTextField(),
              const SizedBox(height: 20),
              const CheckboxCircle(),
              SizedBox(height: 20),
              Calendar(
                startDateController: _startDateController,
                endDateController: _endDateController,
              ),
              const SizedBox(height: 20),
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
        decoration: InputDecoration(
          labelText: "Search . . .",
          contentPadding: const EdgeInsets.symmetric(
            vertical: 16,
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

        SizedBox(height: 19),

        CustomElevatedButton(
          buttonColor: AppColors.clearTextBtn,
          textColor: AppColors.clearBtn,
          buttonTitle: 'Clear',
          onPressed: () => print('Button Clear pressed'),
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
