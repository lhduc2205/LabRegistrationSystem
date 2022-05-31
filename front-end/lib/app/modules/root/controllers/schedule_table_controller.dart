import 'dart:convert';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:lab_registration_management/app/core/value/utils/ultils.dart';
import 'package:lab_registration_management/app/data/models/day_model.dart';
import 'package:lab_registration_management/app/data/models/lab_model.dart';
import 'package:lab_registration_management/app/data/models/period_model.dart';
import 'package:lab_registration_management/app/data/models/timetable_model.dart';
import 'package:lab_registration_management/app/data/models/week_model.dart';
import 'package:lab_registration_management/app/data/services/api/timetable_api_service.dart';
import 'package:lab_registration_management/app/modules/lab/controllers/lab_controller.dart';
import 'package:lab_registration_management/app/modules/root/controllers/period_controller.dart';
import 'package:lab_registration_management/app/modules/root/controllers/week_controller.dart';
import 'package:lab_registration_management/app/modules/timetable/controllers/timetable_controller.dart';

import 'day_controller.dart';

class ScheduleTableController extends GetxController {
  var weekSelection = 1.obs;
  var daySelection = 1.obs;
  var labSelection = 1.obs;
  var periodSelection = 1.obs;
  var isLabUnoccupied = false.obs;
  var isDisableAcceptBtn = true.obs;
  var isFetchNotif = false.obs;
  var notifications = [].obs;
  var isLoading = false.obs;

  final _weekController = Get.find<WeekController>();
  final _dayController = Get.find<DayController>();
  final _labController = Get.find<LabController>();
  final _periodController = Get.find<PeriodController>();

  Future updateTimetable(TimetableModel curTimetable) async {
    // EasyLoading.show(status: 'Loading...');
    try {
      TimetableModel newTimetable = curTimetable;
      newTimetable.phongId = labSelection.value;
      newTimetable.buoiHocId = periodSelection.value;
      newTimetable.tuanId = weekSelection.value;
      newTimetable.thuId = daySelection.value;

      final response = await TimetableAPIService.updateTimetable(newTimetable);
      final timetableResponse = TimetableModel.fromJson(response.data);

      final timetableController = Get.find<TimetableController>();
      int index = timetableController.findIndex(curTimetable);
      timetableController.timetableFiltered[index] = timetableResponse;
      timetableController.tabController.index = weekSelection.value - 1;
      timetableController.setPeriodSelection(periodSelection.value.toString());
      timetableController.getTimetableByWeekAndPeriod(weekSelection.value, periodSelection.value);

      Get.back();
      EasyLoading.dismiss();
      Utils.showNotification('Đã dời lịch thành công!');
    } catch (err) {
      print(err);
      Utils.showNotification('Lỗi! Dời lịch thất bại!');
    }
  }

  Future<void> checkAvailableRoom(TimetableModel timetable) async {
    resetValue();

    isFetchNotif.value = true;
    try {
      Map<String, dynamic> data = {
        'tuan_id': weekSelection.value,
        'thu_id': daySelection.value,
        'buoi_hoc_id': periodSelection.value,
        'phong_id': labSelection.value,
        'cur_timetable': timetable,
      };
      final response = await TimetableAPIService.checkAvailableRoom(data);
      final notification = NotificationChangedModel.fromJson(response.data);
      notifications.value = notification.notification;
      isLabUnoccupied.value = notification.isUnoccupied;
      if(isLabUnoccupied.value && notifications.isEmpty) {
        isDisableAcceptBtn.value = false;
      }
      isFetchNotif.value = false;

    } catch (err) {
      print(err);
    }
  }

  setValueSelection({required String value, required String name}) {
    switch (name) {
      case 'week':
        weekSelection.value = int.parse(value);
        break;
      case 'day':
        daySelection.value = int.parse(value);
        break;
      case 'lab':
        labSelection.value = int.parse(value);
        break;
      case 'period':
        periodSelection.value = int.parse(value);
        break;
    }
  }

  onChangedDropdown(TimetableModel timetable,
      {required String value, required String name}) async {
    setValueSelection(value: value, name: name);
    await checkAvailableRoom(timetable);
  }

  List<WeekModel> getWeekList() {
    final weekList = _weekController.weeksList
        .where((week) => week.id > 0 && week.id <= 15)
        .toList();
    return weekList;
  }

  List<DayModel> getDayList() {
    final dayList =
        _dayController.daysList.where((day) => day.id != 0).toList();
    return dayList;
  }

  List<LabModel> getLabList() {
    final labList =
        _labController.labsList.where((lab) => lab.id != 0).toList();
    return labList;
  }

  List<PeriodModel> getPeriodList() {
    final periodList =
        _periodController.periodList.where((period) => period.id != 0).toList();
    return periodList;
  }

  resetValue() {
    isLabUnoccupied.value = false;
    notifications.value = [];
    isDisableAcceptBtn.value = true;
    isFetchNotif.value = false;
  }
}



class NotificationChangedModel {
  bool isUnoccupied;
  List<dynamic> notification;

  NotificationChangedModel(
      {required this.isUnoccupied, required this.notification});

  factory NotificationChangedModel.fromJson(Map<String, dynamic> json) =>
      NotificationChangedModel(
        isUnoccupied: json["is_unoccupied"],
        notification: json["notification"],
      );

  Map<String, dynamic> toJson() => {
        "is_unoccupied": isUnoccupied,
        "notification": notification,
      };
}
