import 'package:flutter/material.dart';
import 'package:lab_registration_management/app/core/value/constants/app_constants.dart';

class MyTabBar extends StatelessWidget {
  const MyTabBar({
    Key? key,
    required this.tabController,
    required this.onTap,
    required this.tabs,
  }) : super(key: key);

  final TabController tabController;
  final Function(int)? onTap;
  final List<Widget> tabs;

  @override
  Widget build(BuildContext context) {
    return TabBar(
      controller: tabController,
      labelPadding: const EdgeInsets.all(kSpacing),
      isScrollable: true,
      labelColor: kPrimary,
      unselectedLabelColor: kFontColorPallets[1],
      indicatorColor: kPrimary,
      onTap: onTap,
      tabs: tabs,
    );
  }
}
