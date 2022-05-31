import 'package:flutter/material.dart';
import 'package:lab_registration_management/app/modules/404/error_page.dart';
import 'package:lab_registration_management/app/modules/department/views/department_view.dart';
import 'package:lab_registration_management/app/modules/info/views/info_view.dart';
import 'package:lab_registration_management/app/modules/lab/views/lab_view.dart';
import 'package:lab_registration_management/app/modules/lab_registration/views/lab_registration_view.dart';
import 'package:lab_registration_management/app/modules/lecturer/views/lecturer_view.dart';
import 'package:lab_registration_management/app/modules/login/views/login_view.dart';
import 'package:lab_registration_management/app/modules/my_timetable/views/my_timetable_view.dart';
import 'package:lab_registration_management/app/modules/subject/views/subject_view.dart';
import 'package:lab_registration_management/app/modules/teaching/views/teaching_view.dart';
import 'package:lab_registration_management/app/modules/timetable/views/timetable_view.dart';
import 'package:lab_registration_management/app/modules/timetable_clone/views/timetable_clone_view.dart';
import 'package:lab_registration_management/app/routes/routes.dart';

Route<dynamic> onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    // case labCalendarPageRoute:
    //   // return _getPageRoute(const LabCalendarView());
    //   return _getPageRoute(const TimeTableView());
    case loginPageRoute:
      return _getPageRoute(const LoginView());
    case departmentPageRoute:
      return _getPageRoute(const DepartmentView());
    case lecturerPageRoute:
      return _getPageRoute(const LecturerView());
    case labPageRoute:
      return _getPageRoute(const LabView());
    case teachingPageRoute:
      return _getPageRoute(const TeachingView());
    case labRegistrationPageRoute:
      return _getPageRoute(const LabRegistrationView());
    case infoPageRoute:
      return _getPageRoute(const InfoView());
    case timeTablePageRoute:
      return _getPageRoute(const TimeTableView());
    case timetableClonePageRoute:
      return _getPageRoute(const TimetableCloneView());
    case myTimetablePageRoute:
      return _getPageRoute(const MyTimetableView());
    case subjectPageRoute:
      return _getPageRoute(const SubjectView());
    default:
      return _getPageRoute(const ErrorPage());
  }
}

PageRoute _getPageRoute(Widget child) {
  return _FadeRoute(child: child);
}

class _FadeRoute extends PageRouteBuilder {
  final Widget child;

  _FadeRoute({required this.child})
      : super(
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              child,
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) =>
              FadeTransition(
            opacity: animation,
            child: child,
          ),
        );
}
