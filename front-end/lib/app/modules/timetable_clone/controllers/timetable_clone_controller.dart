import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lab_registration_management/app/data/models/period_model.dart';
import 'package:lab_registration_management/app/data/models/semester_model.dart';
import 'package:lab_registration_management/app/data/models/timetable_model.dart';
import 'package:lab_registration_management/app/data/models/week_model.dart';
import 'package:lab_registration_management/app/data/services/api/timetable_api_service.dart';
import 'package:lab_registration_management/app/modules/lab_registration/controllers/lab_registration_controller.dart';
import 'package:lab_registration_management/app/modules/root/controllers/period_controller.dart';
import 'package:lab_registration_management/app/modules/root/controllers/semester_controller.dart';
import 'package:lab_registration_management/app/modules/timetable/controllers/timetable_controller.dart';

class TimetableCloneController extends GetxController
    with GetTickerProviderStateMixin {
  List<WeekModel> weeksList = [];
  List<PeriodModel> periodsList = [];
  List<TimetableModel> timetableClone = [];
  List<SemesterModel> curSemestersList = [];
  Map<String, dynamic> sourceCell = {};
  Map<String, dynamic> desCell = {};

  var timetableCloneFiltered = <TimetableModel>[].obs;
  var periodSelection = 1.obs;
  var weekSelection = 1.obs;
  var isLoading = true.obs;
  var startDate = DateTime.now().obs;
  var labErr = [].obs;

  late TabController tabController;
  final _periodController = Get.find<PeriodController>();
  final _semesterController = Get.find<SemesterController>();

  @override
  void onInit() async {
    print('TimetableCloneController called onInit()');
    tabController = TabController(
      length: 16,
      vsync: this,
      initialIndex: 0,
    );
    await fetchTimetableClone();

    super.onInit();
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }

  Future fetchTimetableClone() async {
    isLoading.value = true;
    try {
      final response = await TimetableAPIService.fetchClone();
      List timetableJson = response.data as List;
      timetableClone = timetableJson
          .map((timetable) => TimetableModel.fromJson(timetable))
          .toList();
      getTimetableByWeekAndPeriod(weekSelection.value, periodSelection.value);

      curSemestersList = _semesterController.curSemestersList;
      curSemestersList.removeRange(16, curSemestersList.length);
      startDate.value = _semesterController.curSemestersList[0].ngayBatDau;

      periodsList = _periodController.periodList
          .where((period) => period.id != 0)
          .toList();

      isLoading.value = false;

      return timetableClone;
    } on Exception catch (e) {
      isLoading.value = false;
      print(e);
      throw Exception(e);
      // return null;
    }
  }

  Future changeTimetable() async {
    labErr.value = [];
    try {
      final response =
          await TimetableAPIService.updateClone(sourceCell, desCell);
      labErr.value = response.data;

      if (labErr.isEmpty) {
        TimetableModel timetableCell =
            findClone(sourceCell['phong_id'], sourceCell['thu_id']);
        int index = findIndex(timetableCell);

        timetableCell.phongId = desCell['phong_id'];
        timetableCell.thuId = desCell['thu_id'];

        timetableCloneFiltered[index] = timetableCell;
      }

      return timetableClone;
    } on Exception catch (e) {
      isLoading.value = false;
      print(e);
      throw Exception(e);
      // return null;
    }
  }

  Future saveClone() async {
    isLoading.value = true;
    try {
      var _timetableController = Get.find<TimetableController>();
      var _registrationController = Get.find<LabRegistrationController>();
      final response = await TimetableAPIService.saveClone();
      await fetchTimetableClone();
      await _timetableController.onRefresh();
      await _registrationController.onRefresh();

      isLoading.value = false;
    } on Exception catch (e) {
      isLoading.value = false;
      print(e);
      throw Exception(e);
      // return null;
    }
  }

  getTimetableByWeekAndPeriod(int weekID, int periodID) {
    weekSelection.value = weekID;
    startDate.value = _semesterController.curSemestersList
        .firstWhere((semester) => semester.tuanId == weekID)
        .ngayBatDau;
    List<TimetableModel> _timetable = timetableClone
        .where(
          (timetable) =>
              timetable.tuanId == weekID && timetable.buoiHocId == periodID,
        )
        .toList();
    timetableCloneFiltered.value = _timetable;
    // timetableCloneFiltered.map((element) => print(element));
    // print(timetableCloneFiltered.value.map((element) => element.phongId));
  }

  TimetableModel findClone(labID, dayID) {
    final timetable = timetableCloneFiltered.firstWhere(
      (clone) => clone.thuId == dayID && clone.phongId == labID,
    );
    return timetable;
  }

  int findIndex(TimetableModel timetable) {
    int index = timetableCloneFiltered.indexOf(timetable);
    return index;
  }

  TimetableModel getClone(int labID, int periodID) {
    return timetableCloneFiltered.firstWhere(
      (clone) => clone.phongId == labID && clone.buoiHocId == periodID,
    );
  }

  getSourceCell(CellData data) {
    sourceCell['tuan_id'] = weekSelection.value;
    sourceCell['thu_id'] = data.day;
    sourceCell['phong_id'] = data.labID;
    sourceCell['buoi_hoc_id'] = periodSelection.value;
  }

  getDesCell(CellData data) {
    desCell['tuan_id'] = weekSelection.value;
    desCell['thu_id'] = data.day;
    desCell['phong_id'] = data.labID;
    desCell['buoi_hoc_id'] = periodSelection.value;
  }

  setPeriodSelection(String? id) {
    periodSelection.value = int.parse(id!);
    getTimetableByWeekAndPeriod(weekSelection.value, periodSelection.value);
  }
}

class CellData {
  final int? labID;
  final int? day;
  final int? nhomTHID;

  CellData(this.labID, this.day, this.nhomTHID);
}
