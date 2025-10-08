import 'package:flutter/material.dart';

class TextScaleHelper {
  static const double fixedTextScaleFactor = 1.0;

  static MediaQueryData getFixedMediaQueryData(BuildContext context) {
    return MediaQuery.of(
      context,
    ).copyWith(textScaler: TextScaler.linear(fixedTextScaleFactor));
  }

  static Widget wrapMaterialApp({
    required MaterialApp app,
    double textScaleFactor = fixedTextScaleFactor,
  }) {
    return Builder(
      builder: (context) {
        final originalBuilder = app.builder;

        return MaterialApp(
          key: app.key,
          navigatorKey: app.navigatorKey,
          scaffoldMessengerKey: app.scaffoldMessengerKey,
          home: app.home,
          routes: app.routes ?? const <String, WidgetBuilder>{},
          initialRoute: app.initialRoute,
          onGenerateRoute: app.onGenerateRoute,
          onGenerateInitialRoutes: app.onGenerateInitialRoutes,
          onUnknownRoute: app.onUnknownRoute,
          navigatorObservers:
              app.navigatorObservers ?? const <NavigatorObserver>[],
          title: app.title,
          onGenerateTitle: app.onGenerateTitle,
          color: app.color,
          theme: app.theme,
          darkTheme: app.darkTheme,
          highContrastTheme: app.highContrastTheme,
          highContrastDarkTheme: app.highContrastDarkTheme,
          themeMode: app.themeMode,
          themeAnimationDuration: app.themeAnimationDuration,
          themeAnimationCurve: app.themeAnimationCurve,
          locale: app.locale,
          localizationsDelegates: app.localizationsDelegates,
          localeListResolutionCallback: app.localeListResolutionCallback,
          localeResolutionCallback: app.localeResolutionCallback,
          supportedLocales: app.supportedLocales,
          debugShowMaterialGrid: app.debugShowMaterialGrid,
          showPerformanceOverlay: app.showPerformanceOverlay,
          checkerboardRasterCacheImages: app.checkerboardRasterCacheImages,
          checkerboardOffscreenLayers: app.checkerboardOffscreenLayers,
          showSemanticsDebugger: app.showSemanticsDebugger,
          debugShowCheckedModeBanner: app.debugShowCheckedModeBanner,
          shortcuts: app.shortcuts,
          actions: app.actions,
          restorationScopeId: app.restorationScopeId,
          scrollBehavior: app.scrollBehavior,
          builder: (context, child) {
            child = MediaQuery(
              data: MediaQuery.of(
                context,
              ).copyWith(textScaler: TextScaler.linear(textScaleFactor)),
              child: child!,
            );

            if (originalBuilder != null) {
              child = originalBuilder(context, child);
            }

            return child;
          },
        );
      },
    );
  }

  static TextStyle responsiveTextStyle(
    BuildContext context, {
    required double baseFontSize,
    FontWeight? fontWeight,
    Color? color,
    String? fontFamily,
    double? letterSpacing,
    double? height,
    TextDecoration? decoration,
  }) {
    final screenWidth = MediaQuery.of(context).size.width;

    double scaleFactor;
    if (screenWidth < 600) {
      scaleFactor = 1.0; // Mobile
    } else if (screenWidth < 1200) {
      scaleFactor = 1.1; // Tablet
    } else {
      scaleFactor = 1.2; // Desktop
    }

    return TextStyle(
      fontSize: baseFontSize * scaleFactor,
      fontWeight: fontWeight,
      color: color,
      fontFamily: fontFamily,
      letterSpacing: letterSpacing,
      height: height,
      decoration: decoration,
    );
  }

  static DeviceType getDeviceType(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width < 600) return DeviceType.mobile;
    if (width < 1200) return DeviceType.tablet;
    return DeviceType.desktop;
  }

  static double getResponsiveFontSize(
    BuildContext context, {
    required double mobile,
    double? tablet,
    double? desktop,
  }) {
    final deviceType = getDeviceType(context);
    switch (deviceType) {
      case DeviceType.mobile:
        return mobile;
      case DeviceType.tablet:
        return tablet ?? mobile * 1.1;
      case DeviceType.desktop:
        return desktop ?? mobile * 1.2;
    }
  }

  static Widget fixTextScale(
    BuildContext context,
    Widget child, [
    double textScaleFactor = fixedTextScaleFactor,
  ]) {
    return withFixedTextScale(
      context: context,
      child: child,
      textScaleFactor: textScaleFactor,
    );
  }

  static Widget withFixedTextScale({
    required BuildContext context,
    required Widget child,
    double textScaleFactor = fixedTextScaleFactor,
  }) {
    return MediaQuery(
      data: MediaQuery.of(
        context,
      ).copyWith(textScaler: TextScaler.linear(textScaleFactor)),
      child: child,
    );
  }
}

enum DeviceType { mobile, tablet, desktop }
