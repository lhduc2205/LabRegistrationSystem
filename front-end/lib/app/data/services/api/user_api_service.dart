import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:lab_registration_management/app/core/value/constants/app_constants.dart';
import 'package:lab_registration_management/app/data/models/login/login_request_model.dart';
import 'package:lab_registration_management/app/modules/root/controllers/root_controller.dart';
import 'package:lab_registration_management/app/modules/root/controllers/side_bar_controller.dart';
import 'package:lab_registration_management/app/routes/routes.dart';

class UserAPIService {
  static var client = http.Client();

  static Future? login(LoginRequestModel model, bool isRemember) async {
    final box = GetStorage();
    final logged = box.read(BoxString.LOGGED_IN);
    Map<String, String> requestHeaders = {'Content-Type': 'application/json'};

    // var url = Uri.http('192.168.56.1:4000', '/api/users/login');

    try {
      // var response = await client.post(
      //   url,
      //   headers: requestHeaders,
      //   body: jsonEncode(
      //     model.toJson(),
      //   ),
      // );
      var response = await Dio().post(
        ApiPath.loginAPI,
        data: jsonEncode(
          model.toJson(),
        ),
      );
      if(response.statusCode == 200) {
        if(isRemember && logged == null) {
          box.write(BoxString.LOGGED_IN, model.email);
        }
        box.write(BoxString.EMAIL, model.email);
        final Map<String, dynamic> data = response.data;
        box.write(BoxString.ROLE, data['ma_vai_tro']);
        box.write(BoxString.UID, data['id']);
        // print(model.email);
        // await SharedService.setLoginDetails(loginResponseJson(response.body));
        return response.data;
      } else {
        return null;
      }
    } on Exception catch (_){
      print("Connection to server failed");
      return null;
    }


  }

  static void logout(String email) {
    final box = GetStorage();
    final remembered = box.read(BoxString.LOGGED_IN);
    final _sidebarController = Get.find<SideBarController>();
    final _rootController = Get.find<RootController>();

    if(remembered != null) {
      box.remove(BoxString.LOGGED_IN);
    }
    box.remove(BoxString.EMAIL);
    box.remove(BoxString.ROLE);
    box.remove(BoxString.UID);
    _sidebarController.resetActive();
    _rootController.removeController();
    Get.offAllNamed(loginPageRoute);
  }
}

