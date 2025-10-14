
import 'package:flutter/material.dart';
import 'package:tsb_mini/frame/app_bar/credit_app_bar.dart';
import 'package:tsb_mini/frame/body/credit_history/credit_list.dart';
import 'package:tsb_mini/frame/header/credit_history/credit_earn_use.dart';

class CarbonHistoryPage extends StatefulWidget {
  final String? startDate;
  final String? endDate;
  final List<Map<String, dynamic>>? items;

  const CarbonHistoryPage({
    super.key,
    this.startDate,
    this.endDate,
    this.items,
  });

  @override
  _CarbonHistoryPageState createState() => _CarbonHistoryPageState();
}

class _CarbonHistoryPageState extends State<CarbonHistoryPage> {
  int _selectedIndex = 4; // Default active is "List"

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: const Color(0xFF0D47A1),
      appBar: CreditHomeAppBar(
        title: 'History',
        enableBack: true,
        enableFilter: true,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Column(
            children: [
              CreditEarnUse(
                startDate: widget.startDate,
                endDate: widget.endDate,
                items: widget.items,
              ),
              Expanded(
                child: SafeArea(
                  bottom: true,
                  child: CreditList(
                    startDate: widget.startDate,
                    endDate: widget.endDate,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      // bottomNavigationBar: BottomNavBarFrame(
      //   currentIndex: _selectedIndex,
      //   onTap: _onItemTapped,
      // ),
    );
  }
}
