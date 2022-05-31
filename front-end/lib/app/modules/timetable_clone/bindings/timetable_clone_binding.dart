import 'package:get/get.dart';

import '../controllers/timetable_clone_controller.dart';

class TimetableCloneBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TimetableCloneController>(
      () => TimetableCloneController(),
    );
  }
}
