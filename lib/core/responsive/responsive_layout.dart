import 'package:flutter/material.dart';
import 'breakpoints.dart';

enum ScreenSize { mobile, tablet, desktop }

class ResponsiveLayout extends StatelessWidget {
  const ResponsiveLayout({
    super.key,
    required this.mobile,
    this.tablet,
    this.desktop,
  });

  final Widget mobile;
  final Widget? tablet;
  final Widget? desktop;

  static ScreenSize sizeOf(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    if (width >= Breakpoints.desktopMin) return ScreenSize.desktop;
    if (width >= Breakpoints.tabletMin) return ScreenSize.tablet;
    return ScreenSize.mobile;
  }

  static bool isMobile(BuildContext context) => sizeOf(context) == ScreenSize.mobile;
  static bool isTablet(BuildContext context) => sizeOf(context) == ScreenSize.tablet;
  static bool isDesktop(BuildContext context) => sizeOf(context) == ScreenSize.desktop;

  static double contentMaxWidth(BuildContext context) {
    switch (sizeOf(context)) {
      case ScreenSize.desktop:
        return 960;
      case ScreenSize.tablet:
        return 720;
      case ScreenSize.mobile:
        return double.infinity;
    }
  }

  static EdgeInsets pagePadding(BuildContext context) {
    switch (sizeOf(context)) {
      case ScreenSize.desktop:
        return const EdgeInsets.symmetric(horizontal: 48, vertical: 32);
      case ScreenSize.tablet:
        return const EdgeInsets.symmetric(horizontal: 32, vertical: 24);
      case ScreenSize.mobile:
        return const EdgeInsets.symmetric(horizontal: 16, vertical: 16);
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = sizeOf(context);
    return switch (size) {
      ScreenSize.desktop => desktop ?? tablet ?? mobile,
      ScreenSize.tablet => tablet ?? mobile,
      ScreenSize.mobile => mobile,
    };
  }
}
