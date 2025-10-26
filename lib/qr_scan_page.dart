import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:tsb_mini/frame/app_bar/credit_app_bar.dart';

class QRScannerPage extends StatefulWidget {
  const QRScannerPage({super.key});

  @override
  State<QRScannerPage> createState() => _QRScannerPageState();
}

class _QRScannerPageState extends State<QRScannerPage>
    with SingleTickerProviderStateMixin {
  bool _isScanCompleted = false;
  late MobileScannerController controller;

  @override
  void initState() {
    super.initState();
    controller = MobileScannerController(
      detectionSpeed: DetectionSpeed.noDuplicates,
      facing: CameraFacing.back,
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void _onDetect(BarcodeCapture barcodeCapture) {
    if (_isScanCompleted) return;
    final String? code = barcodeCapture.barcodes.first.rawValue;
    if (code != null) {
      setState(() => _isScanCompleted = true);
      controller.stop();
      Navigator.pop(context, code); // send QR result back
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: CreditHomeAppBar(
        title:'Scan QR Code',
        enableBack: true,
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          MobileScanner(controller: controller, onDetect: _onDetect),
          // Dimmed background overlay outside scan area
          ColorFiltered(
            colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.05),
              BlendMode.color,
            ),
            child: Stack(
              children: [
                Container(
                  decoration: const BoxDecoration(
                    color: Colors.black,
                    backgroundBlendMode: BlendMode.dstOut,
                  ),
                ),
                Center(
                  child: SizedBox(
                    width: 250,
                    height: 250,
                    child: CustomPaint(
                      painter: QRCornersPainter(
                        color: Colors.white,
                        strokeWidth: 5,
                        cornerLength: 50,
                        borderRadius: 20,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Custom Painter for rounded QR corners
class QRCornersPainter extends CustomPainter {
  final Color color;
  final double strokeWidth;
  final double cornerLength;
  final double borderRadius;

  QRCornersPainter({
    this.color = Colors.white,
    this.strokeWidth = 3,
    this.cornerLength = 20,
    this.borderRadius = 8,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    // Top-left corner
    canvas.drawLine(Offset(0, borderRadius), Offset(0, cornerLength), paint);
    canvas.drawLine(Offset(borderRadius, 0), Offset(cornerLength, 0), paint);
    canvas.drawArc(
      Rect.fromLTWH(0, 0, borderRadius * 2, borderRadius * 2),
      3.14159,
      1.5708,
      false,
      paint,
    );

    // Top-right corner
    canvas.drawLine(
      Offset(size.width - cornerLength, 0),
      Offset(size.width - borderRadius, 0),
      paint,
    );
    canvas.drawLine(
      Offset(size.width, borderRadius),
      Offset(size.width, cornerLength),
      paint,
    );
    canvas.drawArc(
      Rect.fromLTWH(
        size.width - borderRadius * 2,
        0,
        borderRadius * 2,
        borderRadius * 2,
      ),
      -1.5708,
      1.5708,
      false,
      paint,
    );

    // Bottom-left corner
    canvas.drawLine(
      Offset(0, size.height - cornerLength),
      Offset(0, size.height - borderRadius),
      paint,
    );
    canvas.drawLine(
      Offset(borderRadius, size.height),
      Offset(cornerLength, size.height),
      paint,
    );
    canvas.drawArc(
      Rect.fromLTWH(
        0,
        size.height - borderRadius * 2,
        borderRadius * 2,
        borderRadius * 2,
      ),
      3.14159 / 2,
      1.5708,
      false,
      paint,
    );

    // Bottom-right corner
    canvas.drawLine(
      Offset(size.width - cornerLength, size.height),
      Offset(size.width - borderRadius, size.height),
      paint,
    );
    canvas.drawLine(
      Offset(size.width, size.height - cornerLength),
      Offset(size.width, size.height - borderRadius),
      paint,
    );
    canvas.drawArc(
      Rect.fromLTWH(
        size.width - borderRadius * 2,
        size.height - borderRadius * 2,
        borderRadius * 2,
        borderRadius * 2,
      ),
      0,
      1.5708,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
