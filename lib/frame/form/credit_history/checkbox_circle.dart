import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CheckboxCircle extends StatefulWidget {
  const CheckboxCircle({Key? key}) : super(key: key);

  @override
  CheckboxCircleState createState() => CheckboxCircleState();
}

class CheckboxCircleState extends State<CheckboxCircle> {
  // allow multiple selections
  final Set<int> _selectedIndices = <int>{};

  // add this method so parent can clear selection via GlobalKey
  void clearSelection() {
    setState(() {
      _selectedIndices.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Wrap(
          spacing: 5, // horizontal gap
          runSpacing: 8, // vertical gap if wrapped
          children: [
            checkboxText(64, 37, _selectedIndices.contains(0), "All", (val) {
              setState(() {
                if (val == true) {
                  _selectedIndices.add(0);
                } else {
                  _selectedIndices.remove(0);
                }
              });
            }),
            checkboxText(117, 37, _selectedIndices.contains(1), "Transfer In", (val) {
              setState(() {
                if (val == true) {
                  _selectedIndices.add(1);
                } else {
                  _selectedIndices.remove(1);
                }
              });
            }),
            checkboxText(129, 37, _selectedIndices.contains(2), "Transfer Out", (val) {
              setState(() {
                if (val == true) {
                  _selectedIndices.add(2);
                } else {
                  _selectedIndices.remove(2);
                }
              });
            }),
            checkboxText(120, 37, _selectedIndices.contains(3), "Redeemed", (val) {
              setState(() {
                if (val == true) {
                  _selectedIndices.add(3);
                } else {
                  _selectedIndices.remove(3);
                }
              });
            }),
            checkboxText(100, 37, _selectedIndices.contains(4), "Earned", (val) {
              setState(() {
                if (val == true) {
                  _selectedIndices.add(4);
                } else {
                  _selectedIndices.remove(4);
                }
              });
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
                  color: checkData == true
                      ? Color(0xFF083F8C)
                      : Color(0xFFD9D9D9),
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
                  color: checkData == true
                      ? Color(0xFF083F8C)
                      : Color(0xFF959595),
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
