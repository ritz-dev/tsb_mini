import 'package:flutter/material.dart';

class OptimizedImageLoader {
  static Widget loadImage(
    String imagePath, {
    double? width,
    double? height,
    BoxFit? fit,
  }) {
    return Image.asset(imagePath, width: width, height: height, fit: fit);
  }
}
