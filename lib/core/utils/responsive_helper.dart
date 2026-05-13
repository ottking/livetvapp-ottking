import 'package:flutter/material.dart';

class ResponsiveHelper {
  static bool isMobile(BuildContext context) {
    return MediaQuery.of(context).size.width < 600;
  }

  static bool isTablet(BuildContext context) {
    return MediaQuery.of(context).size.width >= 600 && 
           MediaQuery.of(context).size.width < 1200;
  }

  static bool isTV(BuildContext context) {
    return MediaQuery.of(context).size.width >= 1200 ||
           MediaQuery.of(context).size.shortestSide > 600;
  }

  static double getResponsiveFontSize(
    BuildContext context, {
    required double mobileSize,
    double? tabletSize,
    double? tvSize,
  }) {
    if (isTV(context)) {
      return tvSize ?? mobileSize * 1.5;
    } else if (isTablet(context)) {
      return tabletSize ?? mobileSize * 1.2;
    }
    return mobileSize;
  }

  static double getResponsivePadding(
    BuildContext context, {
    required double mobilePadding,
    double? tabletPadding,
    double? tvPadding,
  }) {
    if (isTV(context)) {
      return tvPadding ?? mobilePadding * 2;
    } else if (isTablet(context)) {
      return tabletPadding ?? mobilePadding * 1.5;
    }
    return mobilePadding;
  }

  static int getGridCrossAxisCount(BuildContext context) {
    if (isTV(context)) {
      return 5;
    } else if (isTablet(context)) {
      return 3;
    }
    return 2;
  }
}
