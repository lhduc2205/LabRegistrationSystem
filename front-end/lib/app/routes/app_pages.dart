import 'package:get/get.dart';

import '../modules/404/error_page.dart';
import '../modules/department/views/department_view.dart';
import '../modules/info/bindings/info_binding.dart';
import '../modules/info/views/info_view.dart';
import '../modules/lab/views/lab_view.dart';
import '../modules/lab_registration/bindings/lab_registration_binding.dart';
import '../modules/lab_registration/views/lab_registration_view.dart';
import '../modules/lecturer/views/lecturer_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/my_timetable/bindings/my_timetable_binding.dart';
import '../modules/my_timetable/views/my_timetable_view.dart';
import '../modules/root/controllers/root_controller.dart';
import '../modules/root/views/root_view.dart';
import '../modules/software/views/software_view.dart';
import '../modules/splash_screen.dart';
import '../modules/subject/views/subject_view.dart';
import '../modules/teaching/views/teaching_view.dart';
import '../modules/timetable/views/timetable_view.dart';
import '../modules/timetable_clone/bindings/timetable_clone_binding.dart';
import '../modules/timetable_clone/views/timetable_clone_view.dart';

part 'app_routes.dart';

final controller = Get.find<RootController>();
bool _loggedIn = controller.checkLoggedIn();

class AppPages {
  AppPages._();

  // static String INITIAL = _loggedIn ? Routes.LAB_CALENDAR : Routes.LOGIN;
  static String INITIAL = Routes.LOGIN;

  static final routes = [
    GetPage(
      name: _Paths.LAB_CALENDAR,
      page: () => const RootView(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.TEST,
      page: () => const ErrorPage(),
    ),
    GetPage(
      name: _Paths.ROOT,
      page: () => const RootView(),
    ),
    GetPage(
      name: _Paths.DEPARTMENT,
      page: () => const DepartmentView(),
    ),
    GetPage(
      name: _Paths.LECTURER,
      page: () => const LecturerView(),
    ),
    GetPage(
      name: _Paths.LAB,
      page: () => const LabView(),
    ),
    GetPage(
      name: _Paths.SOFTWARE,
      page: () => SoftwareView(),
    ),
    GetPage(
      name: _Paths.SPLASH_SCREEN,
      page: () => const SplashScreen(),
    ),
    GetPage(
      name: _Paths.TEACHING,
      page: () => const TeachingView(),
    ),
    GetPage(
      name: _Paths.SUBJECT,
      page: () => SubjectView(),
    ),
    GetPage(
      name: _Paths.LAB_REGISTRATION,
      page: () => const LabRegistrationView(),
      binding: LabRegistrationBinding(),
    ),
    GetPage(
      name: _Paths.INFO,
      page: () => const InfoView(),
      binding: InfoBinding(),
    ),
    GetPage(
      name: _Paths.TIMETABLE,
      page: () => const TimeTableView(),
    ),
    GetPage(
      name: _Paths.TIMETABLE_CLONE,
      page: () => TimetableCloneView(),
      binding: TimetableCloneBinding(),
    ),
    GetPage(
      name: _Paths.MY_TIMETABLE,
      page: () => MyTimetableView(),
      binding: MyTimetableBinding(),
    ),
  ];
}
