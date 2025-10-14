import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tsb_mini/frame/button/back_button.dart';
import 'package:tsb_mini/frame/button/filter_button.dart';
import 'package:tsb_mini/theme/color_theme.dart';

class CreditMerchantAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  final String title;

  // Button actions
  final VoidCallback? onTapBack;
  final VoidCallback? onTapFilter;

  // Controls
  final bool enableBack;
  final bool enableFilter;
  final bool enableSearch; // NEW toggle for search box
  final TextEditingController? searchController;

  const CreditMerchantAppBar({
    super.key,
    required this.title,
    this.onTapBack,
    this.onTapFilter,
    this.enableBack = true,
    this.enableFilter = false,
    this.enableSearch = false,
    this.searchController,
  });

  @override
  Size get preferredSize => Size.fromHeight(enableSearch ? 130 : 70); // taller if search enabled

  @override
  Widget build(BuildContext context) {
    return Container(
      height: preferredSize.height,
      decoration: const BoxDecoration(
        color: Color(0xFF0D47A1),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(15),
          bottomRight: Radius.circular(15),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
      child: SafeArea(
        bottom: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // --- Top row with Back / Title / Filter ---
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (enableBack)
                  FrostedBackButton(onBack: onTapBack)
                else
                  const SizedBox(width: 40),

                Expanded(
                  child: Text(
                    title,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inter(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textWhite,
                    ),
                  ),
                ),

                if (enableFilter)
                  FilterButton(onFilter: onTapFilter)
                else
                  const SizedBox(width: 40),
              ],
            ),

            // --- Search box below ---
            if (enableSearch) ...[
              const SizedBox(height: 15),
              Container(
                height: 42,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: TextField(
                  controller: searchController,
                  style: const TextStyle(fontSize: 14),
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.search, color: Colors.black54),
                    hintText: "Search merchant",
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(vertical: 10),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
