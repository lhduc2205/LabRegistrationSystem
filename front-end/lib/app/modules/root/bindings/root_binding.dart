import 'package:get/get.dart';
import 'package:lab_registration_management/app/modules/department/controllers/department_controller.dart';
import 'package:lab_registration_management/app/modules/info/controllers/info_controller.dart';
import 'package:lab_registration_management/app/modules/lab/controllers/lab_controller.dart';
import 'package:lab_registration_management/app/modules/lab_calendar/controllers/lab_calendar_controller.dart';
import 'package:lab_registration_management/app/modules/lab_registration/controllers/lab_registration_controller.dart';
import 'package:lab_registration_management/app/modules/lecturer/controllers/lecturer_controller.dart';
import 'package:lab_registration_management/app/modules/root/controllers/day_controller.dart';
import 'package:lab_registration_management/app/modules/root/controllers/period_controller.dart';
import 'package:lab_registration_management/app/modules/root/controllers/root_controller.dart';
import 'package:lab_registration_management/app/modules/root/controllers/semester_controller.dart';
import 'package:lab_registration_management/app/modules/root/controllers/week_controller.dart';
import 'package:lab_registration_management/app/modules/software/controllers/software_controller.dart';
import 'package:lab_registration_management/app/modules/subject/controllers/subject_controller.dart';
import 'package:lab_registration_management/app/modules/teaching/controllers/teaching_controller.dart';
import 'package:lab_registration_management/app/modules/timetable/controllers/timetable_controller.dart';


class RootBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(RootController(), permanent: true);
    // Get.put(InfoController());
    Get.put(DepartmentController(), permanent: true);
    Get.put(SoftwareController(), permanent: true);
    Get.put(SubjectController(), permanent: true);
    Get.put(DayController(), permanent: true);
    Get.put(SemesterController(), permanent: true);
    Get.put(WeekController(), permanent: true);
    Get.put(PeriodController(), permanent: true);
    Get.put(LecturerController(), permanent: true);
    Get.put(LabController(), permanent: true);
    Get.put(TeachingController(), permanent: true).onInit();
    Get.put(LabCalendarController(), permanent: true);
    // Get.put(TimetableController());
    // Get.put(LabRegistrationController(), permanent: true);
    // Get.put(TimetableCloneController(), permanent: true);
    // Get.lazyPut(() => LabRegistrationController());
    // Get.lazyPut(() => TimetableCloneController());
  }
}
