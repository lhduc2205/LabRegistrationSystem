import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:url_strategy/url_strategy.dart';
import 'app/modules/app.dart';
import 'package:get/get.dart';
import 'app/modules/info/controllers/info_controller.dart';
import 'app/modules/root/controllers/navigation_controller.dart';
import 'app/modules/root/controllers/root_controller.dart';
import 'app/modules/root/controllers/side_bar_controller.dart';
import 'package:flutter_downloader/flutter_downloader.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await FlutterDownloader.initialize(
  //     debug: true // optional: set false to disable printing logs to console
  // );
  await GetStorage.init();
  setPathUrlStrategy();
  Get.put(SideBarController());
  Get.put(NavigationController());
  Get.put(RootController());
  runApp(const App());
}



