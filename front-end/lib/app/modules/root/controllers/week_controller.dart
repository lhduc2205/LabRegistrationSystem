import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lab_registration_management/app/data/models/week_model.dart';
import 'package:lab_registration_management/app/data/services/api/week_api_service.dart';

class WeekController extends GetxController {
  final List<WeekModel> weeksList = [];


  @override
  void onInit() {
    fetch();
    super.onInit();
  }


  Future<List<WeekModel>> fetch() async {
    weeksList.clear();
    try {
      final response = await WeekAPIService.fetch();
      List lecturerJson = response.data as List;
      weeksList.addAll(convertToListWeek(lecturerJson));
      addSingleSession();
      return weeksList;

    } on Exception catch (e) {
      print(e);
      throw Exception(e);
      // return null;
    }
  }

  addSingleSession() {
    WeekModel session = WeekModel(
      id: 0,
      maTuan: 0,
      tenTuan: "Tất cả",
    );
    weeksList.add(session);
  }

  WeekModel findWeek(int id) {
    return weeksList.firstWhere((week) => week.id == id);
  }

  List<WeekModel> convertToListWeek(List list) {
    return list.map((week) => WeekModel.fromJson(week)).toList();
  }

}