library sidebar;

import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lab_registration_management/app/core/value/constants/app_constants.dart';
import 'package:lab_registration_management/app/core/value/helpers/responsiveness.dart';
import 'package:lab_registration_management/app/modules/info/controllers/info_controller.dart';
import 'package:lab_registration_management/app/modules/root/controllers/navigation_controller.dart';
import 'package:lab_registration_management/app/modules/root/controllers/root_controller.dart';
import 'package:lab_registration_management/app/modules/root/controllers/side_bar_controller.dart';
import 'package:lab_registration_management/app/routes/routes.dart';
import 'package:lab_registration_management/app/share_components/custom_text.dart';

part 'sidebar_item.dart';

class SideBar extends StatelessWidget {
  SideBar({Key? key}) : super(key: key);

  final controller = SideBarController.instance;
  final navigationController = NavigationController.instance;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: kBgColorPallets[0],
        // boxShadow: [
        //   BoxShadow(
        //     color: Colors.grey.withOpacity(0.1),
        //     spreadRadius: 5,
        //     blurRadius: 7,
        //     offset: const Offset(0, 3), // changes position of shadow
        //   ),
        // ],
      ),
      child: ListView(
        children: [
          const SizedBox(height: kSpacing),
          _buildLogoApp(context),
          Divider(
            color: kBgColorPallets[2],
            indent: 20,
            endIndent: 20,
          ),
          const SizedBox(height: kSpacing / 2),
          _buildExpansionPanelList(context)
        ],
      ),
    );
  }

  ExpansionPanelList _buildExpansionPanelList(BuildContext context) {

    final box = GetStorage();
    final role = box.read(BoxString.ROLE);

    return ExpansionPanelList.radio(
      initialOpenPanelValue: controller.panelRadioInitial,
      elevation: 1,
      animationDuration: const Duration(milliseconds: 700),
      children: [
        ExpansionPanelRadio(
          value: 1,
          headerBuilder: (context, status) {
            return _CustomListTile(
              icon: status ? IconlyBold.calendar : IconlyLight.calendar,
              title: "Lịch",
              isActive: status,
            );
          },
          body: _buildContentInCalendarPanel(context, role!),
          // canTapOnHeader: true,
        ),
        if (role == 'admin')
          ExpansionPanelRadio(
            value: 2,
            headerBuilder: (context, status) {
              return _CustomListTile(
                icon: status ? IconlyBold.bookmark : IconlyLight.bookmark,
                title: "Danh mục",
                isActive: status,
              );
            },
            body: _buildContentInCategoryPanel(context),
            // canTapOnHeader: true,
          ),
        ExpansionPanelRadio(
          value: 3,
          headerBuilder: (context, status) {
            return _CustomListTile(
              icon: status ? IconlyBold.infoSquare : IconlyLight.infoSquare,
              title: "Hồ sơ",
              isActive: status,
            );
          },
          body: _buildContentInInfoPanel(context),
          // canTapOnHeader: true,
        ),
      ],
    );
  }

  Container _buildContentInCalendarPanel(BuildContext context, String role) {
    return Container(
      padding: const EdgeInsets.only(bottom: kSpacing),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: itemRoutesInCalendarPanel
            .map(
              (item) => _SidebarItem(
                itemName: item.name,
                sidebarController: controller,
                onTap: () {
                  controller.setPanelRadioInitial(1);
                  navigate(context, item: item);
                },
              ),
            )
            .toList(),
      ),
    );
  }

  Container _buildContentInCategoryPanel(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: kSpacing),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: itemRoutesInCategoryPanel
            .map(
              (item) => _SidebarItem(
                itemName: item.name,
                sidebarController: controller,
                onTap: () {
                  controller.setPanelRadioInitial(2);
                  navigate(context, item: item);
                },
              ),
            )
            .toList(),
      ),
    );
  }

  Container _buildContentInInfoPanel(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: kSpacing),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: itemRoutesInInfoPanel
            .map(
              (item) => _SidebarItem(
                  itemName: item.name,
                  sidebarController: controller,
                  onTap: () {
                    controller.setPanelRadioInitial(3);
                    navigate(context, item: item);
                  }),
            )
            .toList(),
      ),
    );
  }

  void navigate(BuildContext context, {required MenuItem item}) {
    if (item.route == authenticationPageRoute) {
      controller.changeActiveItemTo(labCalendarPageDisplayName);
      Get.offAllNamed(authenticationPageRoute);
    }
    if (!controller.isActive(item.name)) {
      controller.changeActiveItemTo(item.name);
      if (ResponsiveWidget.isSmallScreen(context)) {
        Get.back();
      }
      navigationController.navigateTo(item.route);
    }
  }

  Widget _buildLogoApp(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Image.asset(
            ImageRasterPath.CTULogo,
            width: 30,
          ),
        ),
        const Flexible(
          child: CustomText(
            text: AppString.DEPARTMENT,
            size: 16,
            weight: FontWeight.bold,
            color: kPrimary,
          ),
        ),
        const SizedBox(height: kSpacing / 2),
      ],
    );
  }
}

class _CustomListTile extends StatelessWidget {
  const _CustomListTile({
    Key? key,
    this.icon,
    required this.title,
    required this.isActive,
  }) : super(key: key);

  final IconData? icon;
  final String title;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Row(
        children: [
          Icon(
            icon,
            color: isActive
                ? kFontColorPallets[0]
                : kFontColorPallets[0].withOpacity(0.8),
          ),
          const SizedBox(
            width: 10,
          ),
          Text(
            title,
            style: TextStyle(
              color: isActive
                  ? kFontColorPallets[0]
                  : kFontColorPallets[0].withOpacity(0.8),
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
