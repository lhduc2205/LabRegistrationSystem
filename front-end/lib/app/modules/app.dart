import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:lab_registration_management/app/core/value/theme/themes.dart';
import 'package:lab_registration_management/app/modules/root/bindings/root_binding.dart';
import 'package:lab_registration_management/app/routes/app_pages.dart';

import '404/error_page.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Application",
      theme: AppTheme.basic(context),
      scrollBehavior: MyCustomScrollBehavior(),
      initialRoute: AppPages.INITIAL,
      // initialBinding: RootBinding(),
      // home: const SplashScreen(),
      unknownRoute: GetPage(
          name: "/not-found",
          page: () => const ErrorPage(),
          transition: Transition.fadeIn),
      getPages: AppPages.routes,
      builder: EasyLoading.init(),
    );
  }
}

class MyCustomScrollBehavior extends MaterialScrollBehavior {
  // Override behavior methods and getters like dragDevices
  @override
  Set<PointerDeviceKind> get dragDevices => {
    PointerDeviceKind.touch,
    PointerDeviceKind.mouse,
  };
}