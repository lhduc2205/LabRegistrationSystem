import 'package:get/get.dart';
import 'package:lab_registration_management/app/data/models/software_model.dart';
import 'package:lab_registration_management/app/data/services/api/software_api_service.dart';

class SoftwareController extends GetxController {

  final List<SoftwareModel> softwareList = [];
  late Future<List<SoftwareModel>> futureSoftware;

  @override
  void onInit() {
    futureSoftware = fetchSoftware();
    super.onInit();
  }

  Future<List<SoftwareModel>> fetchSoftware() async {
    softwareList.clear();
    try {
      final response = await SoftwareAPIService.fetch();
      List softwareJson = response.data as List;
      softwareList.addAll(convertToListSoftware(softwareJson));

      update();
      return softwareList;
    } on Exception catch (e) {
      print(e);
      throw Exception(e);
      // return null;
    }
  }

  SoftwareModel findSoftware(int id) {
    return softwareList.firstWhere((software) => software.id == id);
  }

  int getIdByName(String name) {
    return softwareList.firstWhere((software) => software.tenPhanMem == name).id;
  }

  List<SoftwareModel> convertToListSoftware(List list) {
    return list.map((Software) => SoftwareModel.fromJson(Software)).toList();
  }

}
