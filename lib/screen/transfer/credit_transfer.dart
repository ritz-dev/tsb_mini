import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tsb_main/frame/navigation/bottom_navigation_frame.dart';
import 'package:tsb_mini/frame/app_bar/credit_app_bar.dart';
import 'package:tsb_mini/frame/body/credit_transfer/recent_transfer_section.dart';
import 'package:tsb_mini/frame/form/credit_transfer/transfer_form.dart';
import 'package:tsb_mini/frame/header/credit_transfer/credit_transfer_header.dart';
import 'package:tsb_main/utils/localization/app_localizations.dart';

class CreditTransferPage extends StatefulWidget {
  final String? startDate;
  final String? endDate;
  final List<Map<String, dynamic>>? items;

  const CreditTransferPage({
    super.key,
    this.startDate,
    this.endDate,
    this.items,
  });

  @override
  _CreditTransferPageState createState() => _CreditTransferPageState();
}

class _CreditTransferPageState extends State<CreditTransferPage> {
  final TextEditingController _idController =  TextEditingController();
  int _selectedIndex = 2;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: const Color(0xff083f8c),
      appBar: CreditHomeAppBar(title: 'Transfer', enableBack: true),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: SafeArea(
          bottom: true,
          child: SingleChildScrollView(
            child: Column(
              children: [
                // Header scrolls together
                CreditTransferHeader(),

                // Transfer Form
                TransferForm(idController: _idController),

                const SizedBox(height: 5),

                // Divider
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: const Divider(height: 1, color: Color(0xFFE6E5E5)),
                ),
                const SizedBox(height: 5),
                // Recent Transfers title
                Padding(
                  padding: const EdgeInsets.only(left: 20, top: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Recent Transfers",
                        style: GoogleFonts.inter(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF083F8C),
                        ),
                      ),
                    ],
                  ),
                ),
                // Recent Transfers list
                  RecentTransfer(
                  onTapItem: (String id) {
                    _idController.text = id; // auto fill the Personal ID input
                  },
                ),
                
              ],
            ),
          ),
        ),
      ),
      // bottomNavigationBar: BottomNavBarFrame(
      // //   currentIndex: _selectedIndex,
      // //   onTap: _onItemTapped,
      // // 
      // ),
      bottomNavigationBar: SafeArea(
        child: Container(
          color: Colors.white, // Makes bottom bar area solid white
          child: BottomNavigationFrame(
            selectedIndex: _selectedIndex,
            onItemTapped: _onItemTapped,
            localize: AppLocalizations.of(context)!,
          ),
        ),
      ),
    );
  }
}
