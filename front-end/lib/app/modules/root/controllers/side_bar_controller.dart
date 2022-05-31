import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:get/get.dart';
import 'package:lab_registration_management/app/core/value/constants/app_constants.dart';
import 'package:lab_registration_management/app/core/value/helpers/responsiveness.dart';
import 'package:lab_registration_management/app/modules/root/controllers/navigation_controller.dart';
import 'package:lab_registration_management/app/routes/routes.dart';
import 'package:flutter/material.dart';

class SideBarController extends GetxController {
  static SideBarController instance = Get.find();

  var activeItem = timetablePageDisplayName.obs;
  var hoverItem = "".obs;

  int panelRadioInitial = 1;

  @override
  onClose() {
    setPanelRadioInitial(1);
  }

  changeActiveItemTo(String itemName) {
    activeItem.value = itemName;
  }

  onHover(String itemName) {
    if (!isActive(itemName)) {
      hoverItem.value = itemName;
    }
  }

  isActive(String itemName) => activeItem.value == itemName;

  isHovering(String itemName) => hoverItem.value == itemName;

// Widget returnIconFor(String itemName) {
//   switch(itemName) {
//     case labCalendarPageDisplayName:
//       return _customIcon(icon: IconlyLight.calendar, activeIcon: IconlyBold.calendar, itemName: itemName);
//     case excelPageDisplayName:
//       return _customIcon(icon: EvaIcons.fileTextOutline, activeIcon: EvaIcons.fileText, itemName: itemName);
//     case lecturerPageDisplayName:
//       return _customIcon(icon: IconlyLight.user3, activeIcon: IconlyBold.user3, itemName: itemName);
//     default:
//       return _customIcon(icon: IconlyLight.calendar, activeIcon: IconlyBold.calendar, itemName: itemName);
//   }
// }

  Widget _customIcon(
      {required IconData activeIcon,
      required IconData icon,
      required String itemName}) {
    if (isActive(itemName)) {
      return Icon(
        activeIcon,
        color: kFontColorPallets[0],
      );
    }
    return Icon(
      icon,
      color: isHovering(itemName) ? kFontColorPallets[0] : kFontColorPallets[2],
    );
  }

  setPanelRadioInitial(int value) {
    panelRadioInitial = value;
  }

  resetActive() {
    panelRadioInitial = 1;
    activeItem.value = timetablePageDisplayName;
  }
}
