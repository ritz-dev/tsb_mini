import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';

class PackageAssets {
  
  static Image image(
    String path, {
    BoxFit? fit,
    double? width,
    double? height,
    Color? color,
  }) {
    return Image.asset(
      path,
      fit: fit,
      width: width,
      height: height,
      color: color,
      package: _isInPackage ? 'tsb_mini' : null ,
    );
  }

  static SvgPicture svg(
    String path, {
    double? width,
    double? height,
    Color? color,
  }) {
    return SvgPicture.asset(
      path,
      width: width,
      height: height,
      color: color,
      package: _isInPackage ? 'tsb_mini' : null ,
    );
  }

  // Simple toggle for dev vs package usage
  static const bool _isInPackage = bool.fromEnvironment(
    'PACKAGE_MODE',
    defaultValue: false, // set to false when running sub project standalone
  );

  
}
