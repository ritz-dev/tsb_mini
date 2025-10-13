import 'package:flutter/material.dart';
import 'package:tsb_mini/frame/app_bar/credit_app_bar.dart';
import 'package:tsb_mini/frame/body/credit_transfer/recent_transfer.dart';
import 'package:tsb_mini/frame/form/credit_transfer/transfer_form.dart';
import 'package:tsb_mini/frame/header/credit_transfer/credit_transfer_header.dart';
/// Credit Transfer Page
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
  
  // int _selectedIndex = 3; // Default active is "List"

  // void _onItemTapped(int index) {
  //   setState(() {
  //     _selectedIndex = index;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: const Color(0xFF0D47A1),
      // Need to be change a AppBar name from history to normal app bar name
      appBar: CreditHomeAppBar(
        title: 'Transfer', 
        enableBack: true,
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
              CreditTransferHeader(),
              Expanded(
                child: SafeArea(
                  bottom: true,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        TransferForm(),
                        const SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          child: const Divider(
                            height: 1,
                            color: Color(0xFFE6E5E5),
                          ),
                        ),
                        const SizedBox(height: 20),
                        //Add RecentTransfers here
                        RecentTransfers(
                          transfers: [
                            {"name": "Customer One", "id": "10*****1111"},
                            {"name": "Customer Two", "id": "10*****1112"},
                            {"name": "Customer Three", "id": "10*****1113"},
                          ],
                        ),
                      ],
                    ),
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
