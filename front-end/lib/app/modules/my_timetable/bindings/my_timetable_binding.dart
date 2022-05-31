import 'package:get/get.dart';

import '../controllers/my_timetable_controller.dart';

class MyTimetableBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MyTimetableController>(
      () => MyTimetableController(),
    );
  }
}
