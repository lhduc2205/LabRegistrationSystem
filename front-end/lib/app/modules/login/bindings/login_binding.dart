import 'package:get/get.dart';
import 'package:lab_registration_management/app/modules/info/controllers/info_controller.dart';

import '../controllers/login_controller.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(LoginController());
  }
}
