import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tsb_mini/frame/body/credit_transfer/error_transfer_banner.dart';
import 'package:tsb_mini/screen/transfer/transfer_successful.dart';

// Add this widget below your TransferForm class
class ConfirmTransferSheet extends StatelessWidget {
  final String recipient;
  final int amount;
  final VoidCallback onTransfer;

  const ConfirmTransferSheet({
    required this.recipient,
    required this.amount,
    required this.onTransfer,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 32, 24, 24),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Confirm  Your Transfer",
            style: GoogleFonts.inter(
              fontWeight: FontWeight.w700,
              fontSize: 20,
              color: Color(0XFF083F8C),
            ),
            textAlign: TextAlign.left,
          ),
          const SizedBox(height: 24),
          Text(
            "You are about to send $amount points to\n$recipient.",
            style: GoogleFonts.inter(
              fontWeight: FontWeight.w500,
              fontSize: 16,
              color: Color(0XFF000000),
            ),
            textAlign: TextAlign.left,
          ),
          const SizedBox(height: 16),
          Text(
            "* Please review the details carefully before continuing.",
            style: GoogleFonts.inter(
              fontWeight: FontWeight.w600,
              fontSize: 14,
              color: Color(0XFFE63063),
              letterSpacing: 1,
            ),
            textAlign: TextAlign.left,
          ),
          const SizedBox(height: 28),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF0A4DA2),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                padding: const EdgeInsets.symmetric(vertical: 18),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TransferSuccessfulPage(),
                  ),
                );
              },
              child: Text(
                "Transfer",
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                backgroundColor: Color(0XFFEAEAEA),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                side: BorderSide(color: Colors.grey.shade300),
                padding: const EdgeInsets.symmetric(vertical: 18),
              ),
              // ...existing code...
              onPressed: () {
                Navigator.of(context).pop();
                TransferErrorBanner.show(context);
              },
              // ...existing code...
              child: Text(
                "Cancel",
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  color: Colors.grey[500],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
