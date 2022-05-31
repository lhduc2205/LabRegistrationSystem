import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lab_registration_management/app/core/value/constants/app_constants.dart';
import 'package:lab_registration_management/app/data/models/semester_model.dart';
import 'package:lab_registration_management/app/data/services/api/semester_api_service.dart';
import 'package:lab_registration_management/app/data/services/api/user_api_service.dart';
import 'package:lab_registration_management/app/modules/info/controllers/info_controller.dart';

class SemesterController extends GetxController {
  // late final SemesterModel semester;
  List<SemesterModel> semestersList = [];
  List<SemesterModel> curSemestersList = [];

  @override
  void onInit() {
    // fetchSemester();
    fetchSemesterByDate();
    super.onInit();
  }

  // Future<List<SemesterModel>> fetchSemester() async {
  //   try {
  //     final response = await SemesterAPIService.fetch();
  //     List semestersJson = response.data as List;
  //
  //     semestersList = convertToListSemester(semestersJson);
  //     print(curSemestersList);
  //
  //     return semestersList;
  //   } on Exception catch (e) {
  //     print(e);
  //     throw Exception(e);
  //     // return null;
  //   }
  // }

  Future<List<SemesterModel>> fetchSemesterByDate() async {
    try {
      final response = await SemesterAPIService.fetchByDate(DateTime.now());
      List semestersJson = response.data as List;

      curSemestersList = convertToListSemester(semestersJson);
      return curSemestersList;
    } on Exception catch (e) {
      print(e);
      throw Exception(e);
      // return null;
    }
  }

  SemesterModel findSemester(int id) {
    return semestersList.firstWhere((semester) => semester.id == id);
  }

  List<SemesterModel> convertToListSemester(List list) {
    return list.map((semester) => SemesterModel.fromJson(semester)).toList();
  }
}
