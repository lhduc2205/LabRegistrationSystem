import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lab_registration_management/app/core/value/constants/app_constants.dart';
import 'package:lab_registration_management/app/data/models/lecturer_model.dart';
import 'package:lab_registration_management/app/data/services/api/lecturer_api_service.dart';

class InfoController extends GetxController {
  var lecturerInfo = <LecturerModel>[].obs;

  var isLoading = true.obs;


  final box = GetStorage();

  @override
  onInit()  {
    print('InfoController has been initialized');
    super.onInit();
    fetchLecturer();
  }


  Future<void> fetchLecturer() async {
    isLoading.value = true;
    final email = box.read(BoxString.EMAIL);
    lecturerInfo.clear();
    try {
      final _infoResponse = await LecturerAPIService.fetchFullInfoLecturer(email);
      final lecturerJson = _infoResponse.data;
      lecturerInfo.add( LecturerModel.fromJson(lecturerJson));
      print(lecturerInfo.toString());
      update();
      isLoading.value = false;

    } on Exception catch (e) {
      print(e);
      isLoading.value = false;
      throw Exception(e);
      // return null;
    }
  }





// DepartmentModel findDepartment(int id) {
//   final _departmentController = Get.find<DepartmentController>();
//   return _departmentController.findDepartment(id);
// }

}
