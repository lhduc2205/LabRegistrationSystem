// import 'package:flutter/material.dart';
// import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
// import 'package:lab_registration_management/app/core/value/constants/app_constants.dart';
// import 'package:lab_registration_management/app/modules/root/controllers/side_bar_controller.dart';
// import 'package:lab_registration_management/app/share_components/custom_text.dart';

part of sidebar;

class _SidebarItem extends StatelessWidget {
  const _SidebarItem({
    Key? key,
    required this.itemName,
    required this.onTap,
    required this.sidebarController,
  }) : super(key: key);

  final String itemName;
  final VoidCallback onTap;
  final SideBarController sidebarController;

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: onTap,
      hoverColor: Colors.transparent,
      splashColor: Colors.blue.withOpacity(.05),
      highlightColor: Colors.blue.withOpacity(.1),
      onHover: (value) {
        value
            ? sidebarController.onHover(itemName)
            : sidebarController.onHover("not hovering");
      },
      child: Obx(
        () => Container(
          color: sidebarController.isActive(itemName)
              ? kBlue.withOpacity(.07)
              : Colors.transparent,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Padding(
              //   padding: const EdgeInsets.all(16),
              //   child: sidebarController.returnIconFor(itemName),
              // ),
              // sidebarController.returnIconFor(itemName),
              // Container(width: 30,),
              const SizedBox(width: kSpacing),
              if (!sidebarController.isActive(itemName))
                Expanded(
                  child: CustomText(
                    text: itemName,
                    color: sidebarController.isHovering(itemName)
                        // ? kFontColorPallets[0]
                        ? kPrimary
                        : kFontColorPallets[2],
                  ),
                )
              else
                Expanded(
                  child: CustomText(
                    text: itemName,
                    // color: kFontColorPallets[0],
                    color: kPrimary,
                  ),
                ),
              Visibility(
                visible: sidebarController.isActive(itemName),
                child: Container(
                  width: 6,
                  height: 40,
                  color: kPrimary,
                ),
                maintainState: true,
                maintainSize: true,
                maintainAnimation: true,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
