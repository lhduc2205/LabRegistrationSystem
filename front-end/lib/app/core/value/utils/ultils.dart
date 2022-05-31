import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class Utils {
  static showSnackBar({required String title, String content=''}) {
    Get.snackbar(title, content);
  }

  static showNotification(String content, {bool isError = false}) {
    if(!isError) {
      return EasyLoading.showSuccess(
        content,
        duration: const Duration(seconds: 2),
      );
    }

    return EasyLoading.showError(
      content,
      duration: const Duration(seconds: 2),
    );
  }
}
