import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PackageAssets {
  /// For raster image assets (.png, .jpg, etc.)
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

  /// For vector SVG assets (.svg)
  static SvgPicture svg(
    String path, {
    BoxFit? fit, // same style as Image
    double? width,
    double? height,
    Color? color,
  }) {
    return SvgPicture.asset(
      path,
      width: width,
      height: height,
      fit: fit ?? BoxFit.contain, // safely apply default if null
      color: color,
      package: _isInPackage ? 'tsb_mini' : null ,
    );
  }

  /// Whether this is being loaded inside a package (like tsb_mini)
  static const bool _isInPackage = bool.fromEnvironment(
    'PACKAGE_MODE',
    defaultValue: false, // false = running standalone project
  );
}
