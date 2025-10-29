import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tsb_main/frame/navigation/bottom_navigation_frame.dart';
import 'package:tsb_mini/frame/app_bar/credit_app_bar.dart';
import 'package:tsb_mini/package_mode.dart';
import 'package:tsb_mini/screen/transfer/credit_transfer.dart';
import 'package:tsb_mini/theme/color_theme.dart';
import 'package:tsb_main/utils/localization/app_localizations.dart';

/// Credit Transfer Page
class TransferSuccessfulPage extends StatefulWidget {
  final String recipient;
  final int amount;
  final String transactionNo;
  final String transactionDate;
  // final String transactionPerson;
  final String note;

  const TransferSuccessfulPage({
    super.key,
    this.recipient = "Mr.John Doe",
    this.amount = 500,
    this.transactionNo = "TRF-20250828",
    this.transactionDate = "30 Aug 2025 12:30",
    // this.transactionPerson = "10000001111",
    this.note = "-",
  });

  @override
  _TransferSuccessfulPageState createState() => _TransferSuccessfulPageState();
}

class _TransferSuccessfulPageState extends State<TransferSuccessfulPage> {
  int _selectedIndex = 2; // Default active is "List"

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
      appBar: CreditHomeAppBar(title: 'Transfer', enableBack: true),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
        child: Container(
          width: double.infinity,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Column(
                  children: [
                    const SizedBox(height: 0),
                    PackageAssets.image("assets/image/success_icon.png"),
                    const SizedBox(height: 18),
                    Text(
                      "Transfer Successfully",
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.w700,
                        fontSize: 20,
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 24),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 32),
                      child: Column(
                        children: [
                          _TransferInfoRow(
                            label: "Amount",
                            value: "-${widget.amount} CC",
                          ),
                          _TransferInfoRow(
                            label: "Transaction No",
                            value: widget.transactionNo,
                          ),
                          _TransferInfoRow(
                            label: "Date & Time",
                            value: widget.transactionDate,
                          ),
                          _TransferInfoRow(
                            label: "Person",
                            valueWidget: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  widget.recipient, // Name
                                  style: GoogleFonts.inter(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14,
                                    color: AppColors.textBlack,
                                  ),
                                ),
                                // Text(
                                //   widget.transactionPerson, // ID
                                //   style: GoogleFonts.inter(
                                //     fontWeight: FontWeight.w400,
                                //     fontSize: 14,
                                //     color: AppColors.textGrey,
                                //   ),
                                // ),
                              ],
                            ),
                          ),
                          _TransferInfoRow(label: "Note", value: widget.note),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
             Container(
                margin: const EdgeInsets.only(
                  bottom: 90,
                ), // ← add margin to lift buttons above BottomNavigationFrame
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: Column(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24),
                          ),
                          side: const BorderSide(color: Color(0xFF0A4DA2)),
                        ),
                        onPressed: () {
                          // Navigate to Transfer History page
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const CreditTransferPage(),
                            ),
                          );
                        },
                        child: Text(
                          "View History",
                          style: GoogleFonts.inter(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            color: const Color(0xFF0A4DA2),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24),
                          ),
                          side: const BorderSide(color: Color(0xFF0A4DA2)),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          "Send Again",
                          style: GoogleFonts.inter(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            color: const Color(0xFF0A4DA2),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

            ],
          ),
        ),
      ),
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

class _TransferInfoRow extends StatelessWidget {
  final String label;
  final String? value;
  final Widget? valueWidget;

  const _TransferInfoRow({required this.label, this.value, this.valueWidget});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: GoogleFonts.inter(
                fontWeight: FontWeight.w500,
                fontSize: 14,
                color: AppColors.textGrey,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child:
                valueWidget ??
                Text(
                  value ?? "",
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    color: AppColors.textBlack,
                  ),
                  textAlign: TextAlign.right,
                ),
          ),
        ],
      ),
    );
  }
}
