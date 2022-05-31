import 'package:flutter/widgets.dart';
import 'package:lab_registration_management/app/modules/root/controllers/navigation_controller.dart';
import 'package:lab_registration_management/app/routes/routes.dart';
import 'package:lab_registration_management/app/routes/router.dart';

Navigator localNavigator() => Navigator(
  key: NavigationController.instance.navigatorKey,
  initialRoute: labCalendarPageRoute,
  onGenerateRoute: onGenerateRoute,
);