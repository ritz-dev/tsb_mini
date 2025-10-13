import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CheckboxCircle extends StatefulWidget {
  const CheckboxCircle({super.key});

  @override
  State<CheckboxCircle> createState() => _CheckboxCircleState();
}

class _CheckboxCircleState extends State<CheckboxCircle> {
  bool isCheckedAll = true;
  bool isTransferIn = false;
  bool isTransferOut = false;
  bool isRedeemed = false;
  bool isEarned = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Wrap(
          spacing: 5, // horizontal gap
          runSpacing: 8, // vertical gap if wrapped
          children: [
            checkboxText(64, 37, isCheckedAll, "All", (val) {
              setState(() => isCheckedAll = val ?? false);
            }),
            checkboxText(117, 37, isTransferIn, "Transfer In", (val) {
              setState(() => isTransferIn = val ?? false);
            }),
            checkboxText(129, 37, isTransferOut, "Transfer Out", (val) {
              setState(() => isTransferOut = val ?? false);
            }),
            checkboxText(120, 37, isRedeemed, "Redeemed", (val) {
              setState(() => isRedeemed = val ?? false);
            }),
            checkboxText(100, 37, isEarned, "Earned", (val) {
              setState(() => isEarned = val ?? false);
            }),
          ],
        ),
      ],
    );
  }

  Widget checkboxText(
    double width,
    double height,
    bool? checkData,
    String text,
    ValueChanged<bool?> onChanged,
  ) {
    return InkWell(
      borderRadius: BorderRadius.circular(43),
      onTap: () => onChanged(!(checkData ?? false)),
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(43),
          border: Border.all(
            color: checkData == true ? Color(0xFF083F8C) : Color(0xFFD9D9D9),
            width: 1.5,
          ),
          color: checkData == true ? Colors.transparent : Colors.white,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 18,
              height: 18,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: checkData == true ? Color(0xFF083F8C) : Colors.white,
                border: Border.all(
                  color: checkData == true ? Color(0xFF083F8C) : Color(0xFFD9D9D9),
                  width: 1.5,
                ),
              ),
              child: checkData == true
                  ? Icon(Icons.check, size: 12, color: Colors.white)
                  : null,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 7),
              child: Text(
                text,
                style: GoogleFonts.inter(
                  fontSize: 13,
                  color: checkData == true ? Color(0xFF083F8C) : Color(0xFF959595),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
