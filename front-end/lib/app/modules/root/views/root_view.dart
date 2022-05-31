import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:lab_registration_management/app/core/value/constants/app_constants.dart';
import 'package:lab_registration_management/app/core/value/helpers/responsiveness.dart';
import 'package:lab_registration_management/app/modules/root/views/widgets/responsive/large_screen.dart';
import 'package:lab_registration_management/app/modules/root/views/widgets/responsive/small_screen.dart';
import 'package:lab_registration_management/app/modules/root/views/widgets/side_bar/side_bar.dart';
import 'package:lab_registration_management/app/modules/root/views/widgets/top_nav/top_nav.dart';
import 'package:lab_registration_management/app/share_components/loading_overlay.dart';

import '../controllers/root_controller.dart';

class RootView extends GetView<RootController> {
  const RootView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: kBgColorPallets[0],
      appBar: topNavigationBar(context, scaffoldKey),
      drawer: Drawer(child: SideBar()),
      body: const ResponsiveWidget(
        largeScreen: LargeScreen(),
        smallScreen: SmallScreen(),
      ),
    );
  }
}
