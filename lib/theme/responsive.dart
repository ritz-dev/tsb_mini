import 'package:flutter/material.dart';

class Responsive {
  final BuildContext context;
  late final MediaQueryData _mediaQuery;
  late final Size _screenSize;
  late final double _width;
  late final double _height;
  late final Orientation _orientation;

  Responsive(this.context) {
    // Use MediaQuery with fixed text scale factor to ensure consistency
    _mediaQuery = MediaQuery.of(context).copyWith(textScaler: TextScaler.linear(1.0));
    _screenSize = _mediaQuery.size;
    _width = _screenSize.width;
    _height = _screenSize.height;
    _orientation = _mediaQuery.orientation;
  }

  static const double mobileBreakpoint = 600;
  static const double tabletBreakpoint = 1024;
  static const double desktopBreakpoint = 1440;
  static const double largeDesktopBreakpoint = 1920;

  // Screen size getters
  double get width => _width;
  double get height => _height;
  Size get screenSize => _screenSize;
  Orientation get orientation => _orientation;
  MediaQueryData get mediaQuery => _mediaQuery;

  // Get the original system text scale factor if needed
  double get systemTextScaleFactor => MediaQuery.of(context).textScaleFactor;

  bool get isMobile => _width < mobileBreakpoint;
  bool get isTablet => _width >= mobileBreakpoint && _width < tabletBreakpoint;
  bool get isDesktop =>
      _width >= tabletBreakpoint && _width < largeDesktopBreakpoint;
  bool get isLargeDesktop => _width >= largeDesktopBreakpoint;

  bool get isPortrait => _orientation == Orientation.portrait;
  bool get isLandscape => _orientation == Orientation.landscape;

  // Responsive helpers
  bool get isMobileOrTablet => isMobile || isTablet;
  bool get isTabletOrDesktop => isTablet || isDesktop;
  bool get isSmallScreen => _width < tabletBreakpoint;
  bool get isLargeScreen => _width >= tabletBreakpoint;

  // Get responsive value based on screen size
  T responsive<T>({required T mobile, T? tablet, T? desktop, T? largeDesktop}) {
    if (isLargeDesktop && largeDesktop != null) return largeDesktop;
    if (isDesktop && desktop != null) return desktop;
    if (isTablet && tablet != null) return tablet;
    return mobile;
  }

  // Get responsive font size with fixed text scaling
  double responsiveFontSize({
    required double mobile,
    double? tablet,
    double? desktop,
    double? largeDesktop,
  }) {
    return responsive<double>(
      mobile: mobile,
      tablet: tablet ?? mobile * 1.1,
      desktop: desktop ?? mobile * 1.2,
      largeDesktop: largeDesktop ?? mobile * 1.3,
    );
  }

  // Create responsive text style with consistent scaling
  TextStyle responsiveTextStyle({
    required double baseFontSize,
    FontWeight? fontWeight,
    Color? color,
    String? fontFamily,
    double? letterSpacing,
    double? height,
    TextDecoration? decoration,
    double? tabletScale,
    double? desktopScale,
    double? largeDesktopScale,
  }) {
    final fontSize = responsiveFontSize(
      mobile: baseFontSize,
      tablet: tabletScale != null ? baseFontSize * tabletScale : null,
      desktop: desktopScale != null ? baseFontSize * desktopScale : null,
      largeDesktop: largeDesktopScale != null
          ? baseFontSize * largeDesktopScale
          : null,
    );

    return TextStyle(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
      fontFamily: fontFamily,
      letterSpacing: letterSpacing,
      height: height,
      decoration: decoration,
    );
  }

  // Wrap widget with fixed text scale
  Widget withFixedTextScale(Widget child, [double textScaleFactor = 1.0]) {
    return MediaQuery(
      data: MediaQuery.of(
        context,
      ).copyWith(textScaler: TextScaler.linear(textScaleFactor)),
      child: child,
    );
  }
}
