import 'package:get/get.dart';
import 'package:lab_registration_management/app/data/models/period_model.dart';
import 'package:lab_registration_management/app/data/services/api/period_api_service.dart';

class PeriodController extends GetxController {
  final List<PeriodModel> periodList = [];


  @override
  void onInit() {
    fetch();
    super.onInit();
  }


  Future<List<PeriodModel>> fetch() async {
    periodList.clear();
    try {
      final response = await PeriodAPIService.fetch();
      List lecturerJson = response.data as List;
      periodList.addAll(convertToListSession(lecturerJson));
      addSingleSession();
      return periodList;

    } on Exception catch (e) {
      print(e);
      throw Exception(e);
      // return null;
    }
  }

  addSingleSession() {
    PeriodModel session = PeriodModel(
      id: 0,
      maBuoiHoc: "tat_ca",
      tenBuoiHoc: "Tất cả",
    );
    periodList.add(session);
  }

  PeriodModel findSession(int id) {
    return periodList.firstWhere((session) => session.id == id);
  }

  List<PeriodModel> convertToListSession(List list) {
    return list.map((session) => PeriodModel.fromJson(session)).toList();
  }

}
