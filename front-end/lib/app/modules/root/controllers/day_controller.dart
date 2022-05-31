import 'package:get/get.dart';
import 'package:lab_registration_management/app/data/models/day_model.dart';
import 'package:lab_registration_management/app/data/services/api/day_api_service.dart';

class DayController extends GetxController {
  final List<DayModel> daysList = [];


  @override
  void onInit() {
    fetch();
    super.onInit();
  }


  Future<List<DayModel>> fetch() async {
    daysList.clear();
    try {
      final response = await DayAPIService.fetch();
      List lecturerJson = response.data as List;
      daysList.addAll(convertToListDay(lecturerJson));
      addSingleSession();
      return daysList;

    } on Exception catch (e) {
      print(e);
      throw Exception(e);
      // return null;
    }
  }

  addSingleSession() {
    DayModel session = DayModel(
      id: 0,
      maThu: "tat_ca",
      tenThu: "Tất cả",
    );
    daysList.add(session);
  }

  DayModel findDay(int id) {
    return daysList.firstWhere((day) => day.id == id);
  }

  List<DayModel> convertToListDay(List list) {
    return list.map((day) => DayModel.fromJson(day)).toList();
  }

}