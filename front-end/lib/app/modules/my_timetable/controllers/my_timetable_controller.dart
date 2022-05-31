import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lab_registration_management/app/core/value/constants/app_constants.dart';
import 'package:lab_registration_management/app/data/models/course_model.dart';
import 'package:lab_registration_management/app/data/models/day_model.dart';
import 'package:lab_registration_management/app/data/models/lab_model.dart';
import 'package:lab_registration_management/app/data/models/lecturer_model.dart';
import 'package:lab_registration_management/app/data/models/period_model.dart';
import 'package:lab_registration_management/app/data/models/semester_model.dart';
import 'package:lab_registration_management/app/data/models/subject_model.dart';
import 'package:lab_registration_management/app/data/models/timetable_model.dart';
import 'package:lab_registration_management/app/data/models/week_model.dart';
import 'package:lab_registration_management/app/modules/lab/controllers/lab_controller.dart';
import 'package:lab_registration_management/app/modules/lecturer/controllers/lecturer_controller.dart';
import 'package:lab_registration_management/app/modules/root/controllers/day_controller.dart';
import 'package:lab_registration_management/app/modules/root/controllers/period_controller.dart';
import 'package:lab_registration_management/app/modules/root/controllers/week_controller.dart';
import 'package:lab_registration_management/app/modules/subject/controllers/subject_controller.dart';
import 'package:lab_registration_management/app/modules/teaching/controllers/teaching_controller.dart';
import 'package:lab_registration_management/app/modules/timetable/controllers/timetable_controller.dart';

class MyTimetableController extends GetxController
    with GetSingleTickerProviderStateMixin {
  LecturerModel? info;

  int currentSortColumn = 4;
  bool isAscending = true;
  List<TimetableModel> timetable = [];
  List<SemesterModel> curSemestersList = [];
  List<PeriodModel> periodsList = [];
  List<SubjectModel> subjectList = [];
  List<CourseModel> courseList = [];
  List<TimetableModel> timetableTableModeFiltered = [];
  final columns = [
    'Mã HP',
    'Tên HP',
    'Nhóm HP',
    'Nhóm TH',
    'Tuần TH',
    'Thứ',
    'Buổi',
    'Phòng TH',
  ];

  var labErr = [].obs;
  var weekSelection = 1.obs;
  var periodSelection = 1.obs;
  var startDate = DateTime.now().obs;
  var box = GetStorage();
  var isHideCloseBtn = true.obs;
  var toggleSelection = [true, false].obs;
  var timetableFiltered = <TimetableModel>[].obs;

  var timetableController = Get.find<TimetableController>();
  var lecturerController = Get.find<LecturerController>();
  var periodController = Get.find<PeriodController>();
  var courseController = Get.find<TeachingController>();
  var subjectController = Get.find<SubjectController>();
  var labController = Get.find<LabController>();
  var weekController = Get.find<WeekController>();
  var dayController = Get.find<DayController>();

  late TextEditingController searchController;
  late TabController tabController2;

  @override
  void onInit() {
    searchController = TextEditingController();
    tabController2 = TabController(
      length: 16,
      vsync: this,
    );
    initialData();
    super.onInit();
  }

  @override
  void onClose() {
    tabController2.dispose();
    super.onClose();
  }

  initialData() {
    String email = box.read(BoxString.EMAIL);
    info = lecturerController.findLecturerByEmail(email);
    timetable = getTimetable();
    timetableTableModeFiltered = timetable;
    timetableTableModeFiltered.sort((a, b) => a.tuanId.compareTo(b.tuanId));
    timetableFiltered.value = findTimetableByWeekAndPeriod(
      timetable,
      weekSelection.value,
      periodSelection.value,
    );
    periodsList =
        periodController.periodList.where((period) => period.id != 0).toList();
    courseList = courseController.teachingList
        .where((teaching) => teaching.giangVienId == info!.id)
        .toList();

    curSemestersList = timetableController.curSemestersList;
    startDate.value = curSemestersList[0].ngayBatDau;
  }

  List<TimetableModel> findTimetableByLecturer(
      List<TimetableModel> _timetable, lecturerID) {
    return _timetable
        .where((timetable) => timetable.giangVienId == lecturerID)
        .toList();
  }

  List<TimetableModel> findTimetableByWeekAndPeriod(
      List<TimetableModel> _timetable, int weekID, int periodID) {
    return _timetable
        .where(
          (timetable) =>
              timetable.tuanId == weekID && timetable.buoiHocId == periodID,
        )
        .toList();
  }

  CourseModel findCourse(id) {
    return courseController.findTeaching(id);
  }

  SubjectModel findSubject(id) {
    return subjectController.findSubject(id);
  }

  WeekModel findWeek(id) {
    return weekController.findWeek(id);
  }

  LabModel findLab(id) {
    return labController.findLab(id);
  }

  DayModel findDay(id) {
    return dayController.findDay(id);
  }

  PeriodModel findPeriod(id) {
    return periodController.findSession(id);
  }

  getTimetableByWeekAndPeriod(int weekID, int periodID) {
    weekSelection.value = weekID;
    startDate.value = curSemestersList
        .firstWhere((semester) => semester.tuanId == weekID)
        .ngayBatDau;
    timetableFiltered.value =
        findTimetableByWeekAndPeriod(timetable, weekID, periodID);
    // print(timetableFiltered.value.map((element) => element.phongId));
  }

  List<TimetableModel> getTimetable() {
    return findTimetableByLecturer(
      timetableController.timetable,
      info!.id,
    );
  }

  onChangedInput(String value) {
    if (value.isEmpty || value == '') {
      hideCloseBtn(true);
    } else {
      hideCloseBtn(false);
    }
    if(!value.contains('\'')) {
      timetableTableModeFiltered = getTimetable()
          .where(
              (timetable) =>
          timetable.maMonHoc!.contains(value) ||
              timetable.maLopHocPhan.toString().contains(value) ||
              timetable.maNhom.toString().contains(value)
      )
          .toList();
    } else {
      final splitted = value.split('\'');
      timetableTableModeFiltered = getTimetable()
          .where(
              (timetable) =>
          timetable.maMonHoc!.contains(splitted[0]) &&
              timetable.maLopHocPhan.toString().contains(splitted[1]) &&
              timetable.maNhom.toString().contains(splitted[2])
      )
          .toList();
    }

    update();
  }

  onTapCloseBtn() {
    searchController.clear();
    hideCloseBtn(true);
    timetableTableModeFiltered = getTimetable();
    timetableTableModeFiltered.sort((a, b) => a.tuanId.compareTo(b.tuanId));
    update();
  }

  onPressedToggle(int index) {
    setToggleSelection(index);
  }

  onSort(int columnIndex, String label) {
    currentSortColumn = columnIndex;
    const String nhomHP = 'Nhóm HP';
    const String nhomTH = 'Nhóm TH';
    const String tuanTH = 'Tuần TH';
    const String thu = 'Thứ';
    const String phongTH = 'Phòng TH';
    if (isAscending == true) {
      isAscending = false;
      switch (label) {
        case nhomHP:
          timetableTableModeFiltered.sort(
                (a, b) => a.maLopHocPhan.compareTo(b.maLopHocPhan),
          );
          break;
        case nhomTH:
          timetableTableModeFiltered.sort(
            (a, b) => a.nhomThId.compareTo(b.nhomThId),
          );
          break;
        case tuanTH:
          timetableTableModeFiltered.sort(
                (a, b) => a.tuanId.compareTo(b.tuanId),
          );
          break;
        case thu:
          timetableTableModeFiltered.sort(
                (a, b) => a.thuId.compareTo(b.thuId),
          );
          break;
        case phongTH:
          timetableTableModeFiltered.sort(
                (a, b) => a.phongId.compareTo(b.phongId),
          );
          break;
        default:
          timetableTableModeFiltered.sort(
            (a, b) => a.id.compareTo(b.id),
          );
      }
    } else {
      isAscending = true;
      switch (label) {
        case nhomHP:
          timetableTableModeFiltered.sort(
                (a, b) => b.maLopHocPhan.compareTo(a.maLopHocPhan),
          );
          break;
        case nhomTH:
          timetableTableModeFiltered.sort(
            (a, b) => b.nhomThId.compareTo(a.nhomThId),
          );
          break;
        case tuanTH:
          timetableTableModeFiltered.sort(
            (a, b) => b.tuanId.compareTo(a.tuanId),
          );
          break;
        case thu:
          timetableTableModeFiltered.sort(
                (a, b) => b.thuId.compareTo(a.thuId),
          );
          break;
        case phongTH:
          timetableTableModeFiltered.sort(
                (a, b) => b.phongId.compareTo(a.phongId),
          );
          break;
        default:
          timetableTableModeFiltered.sort(
            (a, b) => b.id.compareTo(a.id),
          );
      }
    }
    update();
  }

  hideCloseBtn(bool isHide) {
    isHideCloseBtn.value = isHide;
  }

  setPeriodSelection(String id) {
    periodSelection.value = int.parse(id);
    getTimetableByWeekAndPeriod(weekSelection.value, periodSelection.value);
  }

  setToggleSelection(int index) {
    if (index == 0) {
      toggleSelection[0] = true;
      toggleSelection[1] = false;
    }
    if (index == 1) {
      toggleSelection[0] = false;
      toggleSelection[1] = true;
    }
  }
}
