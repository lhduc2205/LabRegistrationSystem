import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:lab_registration_management/app/core/value/constants/app_constants.dart';
import 'package:lab_registration_management/app/data/models/lecturer_model.dart';
import 'package:lab_registration_management/app/data/models/login/registration_single_model.dart';
import 'package:lab_registration_management/app/data/models/period_model.dart';
import 'package:lab_registration_management/app/data/models/registration_model.dart';
import 'package:lab_registration_management/app/data/models/semester_model.dart';
import 'package:lab_registration_management/app/data/models/timetable_model.dart';
import 'package:lab_registration_management/app/data/models/week_semester_model.dart';
import 'package:lab_registration_management/app/data/services/api/semester_api_service.dart';
import 'package:lab_registration_management/app/data/services/api/timetable_api_service.dart';
import 'package:lab_registration_management/app/modules/lecturer/controllers/lecturer_controller.dart';
import 'package:lab_registration_management/app/modules/root/controllers/period_controller.dart';
import 'package:lab_registration_management/app/modules/root/controllers/semester_controller.dart';
import 'package:lab_registration_management/app/modules/timetable_clone/controllers/timetable_clone_controller.dart';

class TimetableController extends GetxController
    with GetSingleTickerProviderStateMixin {
  Map<String, dynamic> sourceCell = {};
  Map<String, dynamic> desCell = {};

  var isLoading = true.obs;
  var isEditedMode = false.obs;
  var weekSelection = 1.obs;
  var periodSelection = 1.obs;
  var lecturerSelection = 0.obs;
  var timetableFiltered = <TimetableModel>[].obs;
  var registrationFiltered = <RegistrationSingleModel>[].obs;
  var startDate = DateTime.now().obs;
  var labErr = [].obs;

  List<WeekSemesterModel> weekSemestersList = [];
  List<PeriodModel> periodsList = [];
  List<LecturerModel> lecturersList = [];
  List<TimetableModel> timetable = [];
  List<RegistrationSingleModel> registration = [];
  List<SemesterModel> curSemestersList = [];

  final _semesterController = Get.find<SemesterController>();
  final _periodController = Get.find<PeriodController>();
  final _lecturerController = Get.find<LecturerController>();
  final box = GetStorage();

  String get role => box.read(BoxString.ROLE);

  late TabController tabController;

  @override
  void onInit() async {
    isLoading.value = true;
    print('Timetable Controller has been initialized');
    tabController = TabController(
      length: 16,
      vsync: this,
    );
    await fetchRegistration();
    await fetchSemesterByDate();
    await fetchTimetable();
    isLoading.value = false;
    super.onInit();
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }

  Future onRefresh() async {
    isLoading.value = true;
    await fetchRegistration();
    await fetchSemesterByDate();
    await fetchTimetable();
    isLoading.value = false;
  }

  Future<List<WeekSemesterModel>> fetchTimetable() async {
    try {
      final response = await TimetableAPIService.fetch();
      List timetableJson = response.data as List;
      timetable = timetableJson
          .map((timetable) => TimetableModel.fromJson(timetable))
          .toList();

      getTimetableByWeekAndPeriod(weekSelection.value, periodSelection.value);

      // isLoading.value = false;

      return weekSemestersList;
    } on Exception catch (e) {
      print(e);
      throw Exception(e);
      // return null;
    }
  }

  Future fetchRegistration() async {
    registration.clear();
    try {
      final response = await TimetableAPIService.fetchRegistrationNoFormat();

      List registrationJson = response.data as List;
      registration = registrationJson
          .map((registration) => RegistrationSingleModel.fromJson(registration))
          .toList();
      registration = getRegistrationInProcess(registration);
      registrationFiltered.value = getRegistrationEachWeek(registration);
    } catch (err) {
      throw Exception(err);
    }
  }

  Future<List<SemesterModel>> fetchSemesterByDate() async {
    isLoading.value = true;
    try {
      final response = await SemesterAPIService.fetchByDate(DateTime.now());
      List semestersJson = response.data as List;

      curSemestersList = convertToListSemester(semestersJson);
      curSemestersList.removeRange(16, curSemestersList.length);
      startDate.value = _semesterController.curSemestersList[0].ngayBatDau;

      periodsList = _periodController.periodList
          .where((period) => period.id != 0)
          .toList();

      lecturersList = _lecturerController.lecturersList
          .where((lecturer) => lecturer.id != 1)
          .toList();

      lecturersList.add(
        LecturerModel(
            id: 0,
            maGv: '0',
            hoTen: 'Tất cả',
            gioiTinh: true,
            ngaySinh: DateTime.now(),
            sdt: '',
            boMonId: 0,
            emailGV: '0'),
      );

      return curSemestersList;
    } on Exception catch (e) {
      print(e);
      throw Exception(e);
      // return null;
    }
  }

  Future changeTimetable() async {
    labErr.value = [];
    try {
      var response;
      bool isUpdate = sourceCell['phong_id'] != null;

      if (!isUpdate) {
        var _date = getDateStartTimetable(desCell['thu_id']).toIso8601String();
        desCell['ngay_bat_dau'] = _date;
        desCell['nhom_th_id'] = sourceCell['nhom_th_id'];
        response =
            await TimetableAPIService.createTimetableWithDraggable(desCell);
        labErr.value = response.data[1];
      } else {
        response = await TimetableAPIService.updateTimetableWithDraggable(
          sourceCell,
          desCell,
        );
        labErr.value = response.data;
      }

      if (labErr.isEmpty) {
        if (!isUpdate) {
          TimetableModel _timetable = TimetableModel.fromJson(response.data[0]);
          timetable.add(_timetable);
          timetableFiltered.add(_timetable);
          removeRegistration(_timetable.nhomThId, _timetable.tuanId);
        } else {
          changeTimetableElement();
        }
      }

      return timetable;
    } on Exception catch (e) {
      isLoading.value = false;
      print(e);
      throw Exception(e);
      // return null;
    }
  }

  List<WeekSemesterModel> convertToModel(List list) {
    return list
        .map((weekSemester) => WeekSemesterModel.fromJson(weekSemester))
        .toList();
  }

  List<SemesterModel> convertToListSemester(List list) {
    return list.map((semester) => SemesterModel.fromJson(semester)).toList();
  }

  changeTimetableElement() {
    TimetableModel timetableCell =
        findTimetable(sourceCell['phong_id'], sourceCell['thu_id']);
    int index = findIndex(timetableCell);

    timetableCell.phongId = desCell['phong_id'];
    timetableCell.thuId = desCell['thu_id'];

    timetableFiltered[index] = timetableCell;
  }

  removeRegistration(int groupID, int weekID) {
    int index = findRegistrationIndex(groupID, weekID, registration);
    int indexFiltered =
        findRegistrationIndex(groupID, weekID, registrationFiltered);
    registration.removeAt(index);
    registrationFiltered.removeAt(indexFiltered);
  }

  DateTime getDateStartTimetable(weekID) {
    return startDate.value.add(Duration(days: weekID - 1));
  }

  getTimetableByWeekAndPeriod(int weekID, int periodID) {
    weekSelection.value = weekID;
    startDate.value = _semesterController.curSemestersList
        .firstWhere((semester) => semester.tuanId == weekID)
        .ngayBatDau;
    List<TimetableModel> _timetable = timetable
        .where(
          (timetable) =>
              timetable.tuanId == weekID && timetable.buoiHocId == periodID,
        )
        .toList();
    timetableFiltered.value = _timetable;
    // print(timetableFiltered.value.map((element) => element.phongId));
  }

  List<RegistrationSingleModel> getRegistrationInProcess(
      List<RegistrationSingleModel> newRegistration) {
    newRegistration =
        newRegistration.where((regis) => regis.trangThai == false).toList();
    return newRegistration;
  }

  List<RegistrationSingleModel> getRegistrationEachWeek(
      List<RegistrationSingleModel> newRegistration) {
    newRegistration = registration
        .where((regis) => regis.tuanID == weekSelection.value)
        .toList();
    return newRegistration;
  }

  filteredTimetableByLecturer() {
    var _timetableFiltered =
        getTimetableByWeekAndPeriod(weekSelection.value, periodSelection.value);
    if (lecturerSelection.value == 0) {
      timetableFiltered.value = _timetableFiltered;
    } else {
      List<TimetableModel> _timetable = _timetableFiltered
          .where(
            (timetable) => timetable.giangVienId == lecturerSelection.value,
          )
          .toList();

      return _timetable;
    }
  }

  List<TimetableModel> findTimetableByGroup(int groupID) {
    final _timetable = timetable.where((e) => e.nhomThId == groupID).toList();
    return _timetable;
  }

  TimetableModel findTimetable(labID, dayID) {
    final timetable = timetableFiltered.firstWhere(
      (clone) => clone.thuId == dayID && clone.phongId == labID,
    );
    return timetable;
  }

  int findIndex(TimetableModel timetable) {
    int index = timetableFiltered.indexOf(timetable);
    return index;
  }

  int findIndexMain(TimetableModel newTimetable) {
    int index = timetable.indexOf(newTimetable);
    return index;
  }

  int findRegistrationIndex(
      int groupID, int weekID, List<RegistrationSingleModel> _registration) {
    int index = _registration.indexWhere(
      (regis) => regis.nhomThId == groupID && regis.tuanID == weekID,
    );
    return index;
  }

  String getDayinWeek(DateTime startDate, int day) {
    return DateFormat('dd/MM/yyyy')
        .format(startDate.add(Duration(days: day)))
        .toString();
  }

  getSourceCell(CellData data) {
    sourceCell['tuan_id'] = weekSelection.value;
    sourceCell['thu_id'] = data.day;
    sourceCell['phong_id'] = data.labID;
    sourceCell['nhom_th_id'] = data.nhomTHID;
    sourceCell['buoi_hoc_id'] = periodSelection.value;
  }

  getDesCell(CellData data) {
    desCell['tuan_id'] = weekSelection.value;
    desCell['thu_id'] = data.day;
    desCell['phong_id'] = data.labID;
    desCell['buoi_hoc_id'] = periodSelection.value;
  }

  setWeekSelection(String? id) {
    weekSelection.value = int.parse(id!);
  }

  setPeriodSelection(String? id) {
    periodSelection.value = int.parse(id!);
    getTimetableByWeekAndPeriod(weekSelection.value, periodSelection.value);
  }

  setLecturerSelection(String? id) {
    lecturerSelection.value = int.parse(id!);
    timetableFiltered.value = filteredTimetableByLecturer();
  }

  setEditedModel(bool editedMode) {
    isEditedMode.value = editedMode;
  }

  setRegistrationFiltered() {
    registrationFiltered.value = getRegistrationEachWeek(registration);
  }
}
