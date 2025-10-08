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
      package: _isInPackage ? 'carbon_credit_app' : null,
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
      package: _isInPackage ? 'carbon_credit_app' : null,
    );
  }

  // Simple toggle for dev vs package usage
  static const bool _isInPackage = bool.fromEnvironment(
    'PACKAGE_MODE',
    defaultValue: true, // set to false when running sub project standalone
  );
}
