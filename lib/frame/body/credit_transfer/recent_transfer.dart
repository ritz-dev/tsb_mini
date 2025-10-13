import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RecentTransfers extends StatelessWidget {
  final List<Map<String, String>> transfers;

  const RecentTransfers({super.key, required this.transfers});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 0.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section Title
          Text(
            "Recent Transfers",
            style: GoogleFonts.inter(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              letterSpacing: 1,
              color: const Color(0xFF083F8C), // blue
            ),
          ),
          const SizedBox(height: 12),

          // List of transfers
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: transfers.length,
            separatorBuilder: (context, index) => const DashedDivider(),
            itemBuilder: (context, index) {
              final transfer = transfers[index];
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Customer Name
                  Text(
                    transfer["name"] ?? "",
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Color(0XFF000000),
                      letterSpacing: 1,
                    ),
                  ),
                  const SizedBox(height: 8),
                  // Masked ID
                  Text(
                    transfer["id"] ?? "",
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Color(0XFF606060),
                    ),
                  ),
                  const SizedBox(height: 8),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

// Custom Dashed Divider
class DashedDivider extends StatelessWidget {
  final double height;
  final Color color;

  const DashedDivider({super.key, this.height = 1, this.color = Colors.grey});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 4.0, bottom: 4.0),
      child: SizedBox(
        height: height,
        child: CustomPaint(
          painter: _DashedLinePainter(
            color: color,
            dashWidth: 5.0,
            dashSpace: 3.0,
          ),
          child: Container(),
        ),
      ),
    );
  }
}

class _DashedLinePainter extends CustomPainter {
  final Color color;
  final double dashWidth;
  final double dashSpace;

  _DashedLinePainter({
    required this.color,
    this.dashWidth = 5.0,
    this.dashSpace = 3.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 0.8;

    double startX = 0;
    final shortDash = 10.0; // short dash for start/end
    final longDash = 24.0; // long dash for middle
    final dashGap = 8.0;

    // Draw short dash at start
    canvas.drawLine(Offset(startX, 0), Offset(startX + shortDash, 0), paint);
    startX += shortDash + dashGap;

    // Draw middle long dashes
    while (startX + longDash + dashGap < size.width - shortDash) {
      canvas.drawLine(Offset(startX, 0), Offset(startX + longDash, 0), paint);
      startX += longDash + dashGap;
    }

    // Draw short dash at end
    if (startX < size.width) {
      double endDashStart = size.width - shortDash;
      canvas.drawLine(Offset(endDashStart, 0), Offset(size.width, 0), paint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
