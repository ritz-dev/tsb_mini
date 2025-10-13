import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tsb_mini/frame/body/credit_transfer/confirm_transfer_sheet.dart';
import 'package:tsb_mini/frame/body/credit_transfer/no_account_transfer.dart';
import 'package:tsb_mini/theme/icon_theme.dart';

class TransferForm extends StatefulWidget {
  final VoidCallback? onCancelTransfer;
  const TransferForm({super.key, this.onCancelTransfer});

  @override
  State<TransferForm> createState() => _TransferFormState();
}

class _TransferFormState extends State<TransferForm> {
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _notesController = TextEditingController();

  final ScrollController controller = ScrollController();

  final int availableCredits =
      3000; // <-- From CreditTransferHeader (mocked here)

  bool _isError = false;

  final String noAccountData = "000011110000";

  void _validateAmount(String value) {
    final entered = int.tryParse(value.replaceAll(",", "")) ?? 0;
    setState(() {
      _isError = entered > availableCredits;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section Title
          Text(
            "Transfer To",
            style: GoogleFonts.inter(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: const Color(0xFF083F8C),
            ),
          ),
          const SizedBox(height: 12),

          // Personal ID input
          TextField(
            controller: _idController,
            style: GoogleFonts.inter(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: const Color(0XFF083F8C), // fixed text color
            ),
            decoration: InputDecoration(
              hintText: "Please Enter Personal ID",
              hintStyle: GoogleFonts.inter(
                fontSize: 14,
                color: Color(0xFFA6A6A6),
                fontWeight: FontWeight.w500,
              ),
              contentPadding: const EdgeInsets.symmetric(
                vertical: 14,
                horizontal: 16,
              ),
              suffixIcon: IconButton(
                icon: AppIcons.scanPngIcon(),
                onPressed: () {
                  // Handle scan action
                },
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: const BorderSide(color: Colors.grey),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: const BorderSide(color: Colors.grey),
              ),
              focusedBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(30)),
                borderSide: BorderSide(
                  color: Color(0xFF0A4DA2), // blue focus
                  width: 1.5,
                ),
              ),
            ),
          ),

          const SizedBox(height: 14),

          // Amount input with error overlay
          Padding(
            padding: const EdgeInsets.only(top: 0), // give room for chip
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                TextField(
                  controller: _amountController,
                  keyboardType: TextInputType.number,
                  onChanged: _validateAmount,
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: _isError ? Colors.red : Color(0XFF083F8C),
                  ),
                  decoration: InputDecoration(
                    hintText: "Enter Amount",
                    hintStyle: GoogleFonts.inter(
                      fontSize: 14,
                      color: Color(0xFFA6A6A6),
                      fontWeight: FontWeight.w500,
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 14,
                      horizontal: 16,
                    ),
                    filled: _isError,
                    fillColor: _isError ? const Color(0xFFFFEBEE) : null,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: const BorderSide(color: Colors.grey),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide(
                        color: _isError ? Colors.red : Colors.grey,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide(
                        color: _isError ? Colors.red : const Color(0xFF0A4DA2),
                        width: 1.5,
                      ),
                    ),
                  ),
                ),

                // Floating error label (top-right, above border)
                if (_isError)
                  Positioned(
                    right: 20,
                    top: -9,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.red, width: 1),
                      ),
                      child: Text(
                        "Insufficient Balance",
                        style: GoogleFonts.inter(
                          color: Colors.red,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 14),

          // Notes input
          TextField(
            controller: _notesController,
            style: GoogleFonts.inter(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: const Color(0XFF083F8C), // fixed input text color
            ),
            decoration: InputDecoration(
              hintText: "Add Notes",
              hintStyle: GoogleFonts.inter(
                fontSize: 14,
                color: Color(0xFFA6A6A6),
                fontWeight: FontWeight.w500,
              ),
              contentPadding: const EdgeInsets.symmetric(
                vertical: 14,
                horizontal: 16,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: const BorderSide(color: Colors.grey),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: const BorderSide(color: Colors.grey),
              ),
              focusedBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(30)),
                borderSide: BorderSide(
                  color: Color(0xFF0A4DA2), // blue border on focus
                  width: 1.5,
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),

          // Continue Button
          // Replace the whole GestureDetector(...) block with this:
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF0A4DA2),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                disabledBackgroundColor: const Color(0xFF0A4DA2),
              ),
              onPressed: () {
                // Close keyboard so sheet has full space
                FocusScope.of(context).unfocus();

                if (_isError) {
                  return; // disabled due to insufficient balance
                }

                final id = _idController.text.trim();

                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  builder: (BuildContext context) {
                    if (id == noAccountData) {
                      return NoAccountTransfer();
                    } else {
                      final recipient = _idController.text.trim();
                      final amount =
                          int.tryParse(
                            _amountController.text.replaceAll(",", ""),
                          ) ??
                          0;
                      void onTransfer() {
                        // Implement transfer logic here
                      }
                      return ConfirmTransferSheet(
                        recipient: recipient,
                        amount: amount,
                        onTransfer: onTransfer,
                      );
                    }
                  },
                );
              },
              child: Text(
                "Continue",
                style: GoogleFonts.inter(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
