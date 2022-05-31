import 'package:get/get.dart';

import '../controllers/lab_registration_controller.dart';

class LabRegistrationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LabRegistrationController>(
      () => LabRegistrationController(),
    );
  }
}
