import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tsb_mini/frame/app_bar/credit_app_bar.dart';
import 'package:tsb_mini/package_mode.dart';

/// Credit Transfer Page
class TransferSuccessfulPage extends StatefulWidget {
  final String recipient;
  final int amount;
  final String transactionNo;
  final String transactionDate;
  final String transactionPerson;
  final String note;

  const TransferSuccessfulPage({
    super.key,
    this.recipient = "Mr.Jason",
    this.amount = 500,
    this.transactionNo = "TRF-20250828-4B7F",
    this.transactionDate = "30 Aug 2025 12:30",
    this.transactionPerson = "10*****0000",
    this.note = "",
  });

  @override
  _TransferSuccessfulPageState createState() => _TransferSuccessfulPageState();
}

class _TransferSuccessfulPageState extends State<TransferSuccessfulPage> {
  int _selectedIndex = 3; // Default active is "List"

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
      // Need to be change a AppBar name from history to normal app bar name
      appBar: CreditHomeAppBar(
        title: 'Transfer', 
        enableBack: true
        ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
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
            children: [
              const SizedBox(height: 32),
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
              const SizedBox(height: 10),
              Text(
                "You sent ${widget.amount} carbon credit to ${widget.recipient}.",
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.w500,
                  fontSize: 15,
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
                      label: "Transaction Date",
                      value: widget.transactionDate,
                    ),
                    _TransferInfoRow(
                      label: "Transaction Person",
                      value: widget.transactionPerson,
                    ),
                    _TransferInfoRow(label: "Note", value: widget.note),
                  ],
                ),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 12,
                ),
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
                          // TODO: Implement view history navigation
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
    );
  }
}

class _TransferInfoRow extends StatelessWidget {
  final String label;
  final String value;
  const _TransferInfoRow({required this.label, required this.value});

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
                fontSize: 15,
                color: Colors.grey[700],
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              value,
              style: GoogleFonts.inter(
                fontWeight: FontWeight.w600,
                fontSize: 15,
                color: Colors.black,
              ),
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }
}
