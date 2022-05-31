library top_nav;

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lab_registration_management/app/core/value/constants/app_constants.dart';
import 'package:lab_registration_management/app/core/value/helpers/responsiveness.dart';
import 'package:lab_registration_management/app/modules/root/controllers/root_controller.dart';
import 'package:lab_registration_management/app/share_components/custom_text.dart';
import 'package:lab_registration_management/app/share_components/small_button.dart';

part 'widgets/custom_icon_button.dart';

part 'widgets/custom_app_name.dart';

part 'widgets/user_info.dart';

AppBar topNavigationBar(BuildContext context, GlobalKey<ScaffoldState> key) {
  return AppBar(
    // elevation: 0,
    // backgroundColor: kBgColorPallets[1],
    backgroundColor: kWhite,
    iconTheme: const IconThemeData(color: kBlack),
    automaticallyImplyLeading: false,
    title: _buildTitle(context, key),
    actions: _buildActions(context),

  );
}

Widget _buildTitle(BuildContext context, GlobalKey<ScaffoldState> key) {
  // if (ResponsiveWidget.isSmallScreen(context)) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      _CustomIconButton(
        onPressed: () {
          key.currentState?.openDrawer();
        },
        icon: Icons.menu,
      ),
      if (!ResponsiveWidget.isSmallScreen(context)) const _CustomAppName(),
    ],
  );
  // }
  // return const _CustomAppName();
}

List<Widget> _buildActions(BuildContext context) {
  return <Widget>[
    _buildUserInfo()
  ];
}

Widget _buildUserInfo() {
  return const Padding(
    padding: EdgeInsets.symmetric(horizontal: kSpacing),
    child: _UserInfo(),
  );
}
