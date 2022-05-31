import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lab_registration_management/app/core/value/constants/app_constants.dart';
import 'package:lab_registration_management/app/data/models/login/login_request_model.dart';
import 'package:lab_registration_management/app/data/services/api/user_api_service.dart';

class LoginController extends GetxController {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  var isRemember = false.obs;
  var isAPICallProcess = false.obs;
  bool hidePassword = true;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  // final _infoController = Get.find<InfoController>();

  onChangeRememberPassword(value) {
    isRemember.value = value;
  }

  // Validate form
  handleSubmit() {
    if (validateAndSave()) {
      isAPICallProcess.value = true;
      LoginRequestModel model = LoginRequestModel(
        email: emailController.text,
        mat_khau: passwordController.text,
      );
      UserAPIService.login(model, isRemember.value)?.then(
        (response) => {
          if (response != null)
            {
              // _infoController.lecturerInfo = LecturerModel.fromJson(response),
              isAPICallProcess.value = false,
              // print(_infoController.lecturerInfo),
              Get.offAllNamed('/dash-board'),
            }
          else
            {
              Get.dialog(
                AlertDialog(
                  title: const Text("Lỗi xác thực", style: TextStyle(color: kRed),),
                  content: Text(
                    "Tài khoản hoặc mật khẩu không đúng",
                    style: TextStyle(color: kFontColorPallets[0]),
                  ),
                  actions: <Widget>[
                    ElevatedButton(
                      child: const Text("Thử lại"),
                      onPressed: () {
                        Get.back();
                        isAPICallProcess.value = false;
                      },
                    )
                  ],
                ),
                barrierDismissible: false,
              ),
            }
        },
      );
    }
  }


  String? validateEmail(String value) {
    if (value == null || value.isEmpty) {
      return '* Vui lòng nhập email';
    }
    return null;
  }

  String? validatePassword(String value) {
    if (value == null || value.isEmpty) {
      return '* Vui lòng nhập mật khẩu';
    }
    return null;
  }

  bool validateAndSave() {
    final form = formKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    } else {
      return false;
    }
  }
}
