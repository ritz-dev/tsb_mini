import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SvgTestPage extends StatelessWidget {
  const SvgTestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent,
      body: Center(
        child: SvgPicture.asset(
          'assets/category/Food1.svg', // <-- change to your actual path
          width: 100,
          height: 100,
          color: Colors.white, // optional
        ),
      ),
    );
  }
}
