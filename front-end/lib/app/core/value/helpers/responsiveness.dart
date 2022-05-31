import 'package:flutter/material.dart';

const int largeScreenSize = 1366;
const int smallScreenSize = 768;
// const int smallScreenSize = 360;
const int customScreenSize = 1100;

class ResponsiveWidget extends StatelessWidget {
  const ResponsiveWidget({
    Key? key,
    required this.largeScreen,
    this.mediumScreen,
    this.smallScreen,
    this.customScreen,
  }) : super(key: key);

  final Widget largeScreen;
  final Widget? mediumScreen;
  final Widget? smallScreen;
  final Widget? customScreen;

  static bool isSmallScreen(BuildContext context) =>
      MediaQuery.of(context).size.width < customScreenSize;

  // static bool isMediumScreen(BuildContext context) =>
  //     MediaQuery.of(context).size.width >= mediumScreenSize &&
  //     MediaQuery.of(context).size.width < largeScreenSize;

  static bool isLargeScreen(BuildContext context) =>
      MediaQuery.of(context).size.width >= largeScreenSize;

  // static bool isCustomScreen(BuildContext context) =>
  //     MediaQuery.of(context).size.width >= smallScreenSize &&
  //     MediaQuery.of(context).size.width <= largeScreenSize;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      double _width = constraints.maxWidth;
      if(_width >= largeScreenSize) {
        return largeScreen;
      }
      // else if (_width < largeScreenSize && _width >= mediumScreenSize) {
      //   return mediumScreen ?? largeScreen;
      // }
      // else if (_width >= customScreenSize && _width <= smallScreenSize) {
      //   return customScreen ?? largeScreen;
      // }
      else {
        return smallScreen ?? largeScreen;
      }
    });
  }
}
