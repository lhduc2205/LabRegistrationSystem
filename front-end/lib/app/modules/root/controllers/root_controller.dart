import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lab_registration_management/app/core/value/constants/app_constants.dart';
import 'package:lab_registration_management/app/data/services/api/user_api_service.dart';
import 'package:lab_registration_management/app/modules/info/controllers/info_controller.dart';
import 'package:lab_registration_management/app/modules/lab_registration/controllers/lab_registration_controller.dart';
import 'package:lab_registration_management/app/modules/my_timetable/controllers/my_timetable_controller.dart';
import 'package:lab_registration_management/app/modules/timetable/controllers/timetable_controller.dart';
import 'package:lab_registration_management/app/modules/timetable_clone/controllers/timetable_clone_controller.dart';

import 'side_bar_controller.dart';
import 'navigation_controller.dart';

class RootController extends GetxController {
  final box = GetStorage();

  // SideBarController sidebarController = SideBarController.instance;
  // NavigationController navigationController = NavigationController.instance;


  bool checkLoggedIn() {
    var loggedIn = box.read(BoxString.LOGGED_IN);

    if (loggedIn == null) {
      return false;
    }
    return true;
  }

  void logout(String email) => UserAPIService.logout(email);

  void removeController() {
    Get.delete<InfoController>();
    Get.delete<LabRegistrationController>();
    Get.delete<TimetableCloneController>();
    Get.delete<TimetableController>();
    Get.delete<MyTimetableController>();
  }

}
