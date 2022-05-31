import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lab_registration_management/app/core/value/constants/app_constants.dart';
import 'package:lab_registration_management/app/core/value/helpers/app_helpers.dart';
import 'package:lab_registration_management/app/core/value/utils/ultils.dart';
import 'package:lab_registration_management/app/data/models/course_group_model.dart';
import 'package:lab_registration_management/app/data/models/course_model.dart';
import 'package:lab_registration_management/app/data/models/registration_model.dart';
import 'package:lab_registration_management/app/data/models/scheduling_response.dart';
import 'package:lab_registration_management/app/data/models/subject_model.dart';
import 'package:lab_registration_management/app/data/models/timetable_model.dart';
import 'package:lab_registration_management/app/data/models/week_model.dart';
import 'package:lab_registration_management/app/data/services/api/course_api_service.dart';
import 'package:lab_registration_management/app/data/services/api/timetable_api_service.dart';
import 'package:lab_registration_management/app/data/services/excel_service.dart';
import 'package:lab_registration_management/app/modules/root/controllers/week_controller.dart';
import 'package:lab_registration_management/app/modules/subject/controllers/subject_controller.dart';
import 'package:lab_registration_management/app/modules/teaching/controllers/teaching_controller.dart';

import 'package:universal_html/html.dart' show AnchorElement;
// import 'package:flutter/foundation.dart' show kIsWeb;

class LabRegistrationController extends GetxController
    with GetTickerProviderStateMixin {
  List<CourseModel> courses = [];
  List<SubjectModel> subjects = [];

  List<RegistrationModel> registration = [];
  List<TimetableModel> timetable = [];
  List<Conflict> conflict = [];
  List<int> coursesIDList = [];
  List<TimetableModel> timetableClone = [];
  List<CourseGroup> courseGroup = [];

  final labelColumns = [
    'Mã HP',
    'Môn học',
    'Nhóm HP',
    'Nhóm TH',
    'Số sinh viên',
    'Tuần đăng ký',
    'Tuần đã xếp',
    'Tuần chưa xếp',
  ];

  var isAssigned = false.obs;
  var isRegistered = false.obs;
  var isLoading = true.obs;
  var isScheduling = false.obs;
  var isHideCloseBtn = true.obs;
  var activeTabBarColor = kPrimary.obs;
  var subjectSelection = 1.obs;
  var weekPracticeQuantity = 1.obs;
  var excelFileName = ''.obs;
  var searchResult = ''.obs;
  var groupSelection = 0.obs;
  var weekListSelection = <int>[].obs;
  var registrationFiltered = <RegistrationModel>[].obs;

  late TabController _tabController;
  late FilePickerResult? picked;

  final box = GetStorage();

  final _subjectController = Get.find<SubjectController>();
  final _courseController = Get.find<TeachingController>();
  final _weekController = Get.find<WeekController>();
  final searchController = TextEditingController();

  TabController get tabController => _tabController;

  String get role => box.read(BoxString.ROLE);

  @override
  onInit() {
    fetchCourseByLecturer();
    fetchCourseGroupByLecturer();
    fetchRegistration();
    _tabController = TabController(length: 3, vsync: this, initialIndex: 0);
    // _tabController.addListener(() {
    //   onTapTabBar(_tabController.index);
    // });
    super.onInit();
  }

  // @override
  // onReady() {
  //   fetchCourseByLecturer();
  //   // fetchRegistration();
  //   update();
  // }

  Future<void> onRefresh() async {
    await fetchCourseByLecturer();
    await fetchCourseGroupByLecturer();
    await fetchRegistration();
  }

  Future fetchCourseByLecturer() async {
    final email = box.read(BoxString.EMAIL);
    isLoading.value = true;
    try {
      final response = await CourseAPIService.fetchByLecturer(email);
      if (response.data.length == 0) {
        isAssigned.value = false;
      } else {
        isAssigned.value = true;
      }
      List courseJson = response.data as List;
      final courseList =
          courseJson.map((course) => CourseModel.fromJson(course)).toList();
      courses.addAll(courseList);
      subjects = getSubjects();

      // return courses;
    } catch (err) {
      throw Exception(err);
    }
  }

  Future fetchCourseGroupByLecturer() async {
    final email = box.read(BoxString.EMAIL);
    try {
      final response = await TimetableAPIService.fetchGroupByLecturer(email);
      List courseGroupJson = response.data as List;
      print(courseGroupJson);
      courseGroup =
          courseGroupJson.map((group) => CourseGroup.fromJson(group)).toList();
      // courseGroup.sort((a, b) {
      //   if (a.trangThai) {
      //     return 1;
      //   }
      //   return -1;
      // });
      // return courses;

    } catch (err) {
      throw Exception(err);
    }
  }

  Future fetchRegistration() async {
    registration.clear();
    final email = box.read(BoxString.EMAIL);
    try {
      var response;
      if (email == 'admin') {
        response = await TimetableAPIService.fetchRegistration();
      } else {
        response = await TimetableAPIService.fetchRegistrationByEmail(email);
      }

      if (response.data != []) {
        isRegistered.value = true;
      }
      List registrationJson = response.data as List;
      registration = registrationJson
          .map((registration) => RegistrationModel.fromJson(registration))
          .toList();

      registrationFiltered.value = registration;

      isLoading.value = false;
    } catch (err) {
      throw Exception(err);
    }
  }

  Future fetchTimetable() async {
    timetable.clear();
    final email = box.read(BoxString.EMAIL);
    try {
      final response = await TimetableAPIService.fetchByLecturer(email);
      List timetableJson = response.data as List;
      final timetableList = timetableJson
          .map((registration) => TimetableModel.fromJson(registration))
          .toList();
      timetable.addAll(timetableList);
    } catch (err) {
      throw Exception(err);
    }
  }

  Future<List<TimetableModel>> scheduling() async {
    isScheduling.value = true;
    try {
      final response = await TimetableAPIService.scheduling();
      var res = response.data;
      final timetableResponse = SchedulingResponse.fromJson(res);
      timetable = timetableResponse.timetableModel;
      conflict = timetableResponse.conflict;
      // timetable.addAll(timetableClone);
      isScheduling.value = false;

      return timetable;
    } catch (err) {
      throw Exception(err);
    }
  }

  Future registerWeek() async {
    try {
      final response = await TimetableAPIService.register(
          weekListSelection.value, groupSelection.value);
      var res = response.data;
      var groupData = CourseGroup.fromJson(res);
      int index = findGroupIndex(groupData);
      courseGroup[index] = groupData;

      await onRefresh();
    } catch (err) {
      EasyLoading.dismiss();
      Utils.showNotification('Đã xảy ra lỗi!');
      throw Exception(err);
    }
  }

  List<SubjectModel> getSubjects() {
    List<int> subjectIdList = [];
    List<SubjectModel> subjectList = [];

    for (int i = 0; i < courses.length; i++) {
      if (!subjectIdList.contains(courses[i].monHocId)) {
        subjectIdList.add(courses[i].monHocId);
      }
    }

    for (int i = 0; i < subjectIdList.length; i++) {
      final subject = _subjectController.findSubject(subjectIdList[i]);
      subjectList.add(subject);
    }

    return subjectList;
  }

  CourseModel findCourse(int courseID) {
    return _courseController.findTeaching(courseID);
  }

  SubjectModel findSubject(int subjectID) {
    return _subjectController.findSubject(subjectID);
  }

  int findGroupIndex(CourseGroup _courseGroup) {
    return courseGroup.indexWhere((group) => group.id == _courseGroup.id);
  }

  // List<RegistrationModel> filteredRegistration(
  //     {required bool status}) {
  //   return registration
  //       .where((register) => register.trangThai == status)
  //       .toList();
  // }

  List<WeekModel> getWeek() {
    return _weekController.weeksList.where((week) => week.id != 0).toList();
  }

  Future downloadSample() async {
    final email = box.read(BoxString.EMAIL);
    EasyLoading.show(status: 'Loading...');
    try {
      // final response = await CourseAPIService.downloadFile(email);
      // final bytes = response.data as List<int>;
      // print(response.data);
      // if (kIsWeb) {
      //   AnchorElement(
      //       href:
      //       'data:application/octet-stream;charset=utf-16le;base64, ${base64.encode(bytes)}')
      //     ..setAttribute('download', '$email.xlsx')
      //     ..click();
      // }
      downloadFile(ApiPath.course + "/download/" + email.toString());
      await Future.delayed(const Duration(seconds: 2));
      EasyLoading.dismiss();
      Utils.showNotification('Đã tải xuống thành công!');
    } catch (err) {
      print(err);
      EasyLoading.dismiss();
      Utils.showNotification('Đã xảy ra lỗi, không thể tải!');
    }
  }

  Future<void> downloadFile(String url) async {
    AnchorElement anchorElement = AnchorElement(href: url);
    anchorElement.download = url;
    anchorElement.click();
  }

  Future<void> uploadExcel(FilePickerResult file) async {
    EasyLoading.show(status: 'Đang tải...');
    try {
      final response = await TimetableAPIService.uploadFile(file);
      await onRefresh();
      EasyLoading.dismiss();
      Utils.showNotification('Đã Import thành công!');

      update();
    } catch (err) {
      EasyLoading.dismiss();
      Utils.showNotification(
        'Đã xảy ra lỗi. Không thể import !!!',
      );
    }
  }

  // addWeekPractice() {
  //   if (weekSelection.last < 22) {
  //     weekSelection.add(weekSelection.last + 1);
  //   }
  //   weekSelection.add(1);
  //   weekPracticeQuantity += 1;
  // }
  // setWeekSelection(String id, int index) {
  //   weekSelection[index] = int.parse(id);
  // }
  //
  // setSubjectSelection(String id) {
  //   subjectSelection.value = int.parse(id);
  // }

  bool isWeekSelected(id) {
    return weekListSelection.contains(id);
  }

  setWeekSelected(id) {
    if (weekListSelection.contains(id)) {
      weekListSelection.remove(id);
    } else {
      weekListSelection.add(id);
    }
  }

  onTapTabBar(int index) {
    activeTabBarColor.value = TypeHelper.tabBarIndicator(index);
  }

  onTapCloseBtn() {
    isHideCloseBtn.value = true;
    searchResult.value = '';
    searchController.clear();
    registrationFiltered.value = registration;
  }

  onChangedSearchBtn(String value) {
    if (value.isEmpty || value == '') {
      isHideCloseBtn.value = true;
    } else {
      isHideCloseBtn.value = false;
    }

    searchResult.value = value.trim();

    if (searchResult.value.contains('\'')) {
      final splitter = searchResult.value.split('\'');
      registrationFiltered.value = registration
          .where(
            (register) =>
                register.maMonHoc!.contains(splitter[0]) &&
                register.maLopHocPhan!.contains(splitter[1]) &&
                register.maNhom.toString().contains(splitter[2]),
          )
          .toList();
    } else {
      registrationFiltered.value = registration
          .where(
            (register) =>
        register.maMonHoc!.contains(searchResult.value) ||
            register.tenMonHoc!.contains(searchResult.value) ||
            register.vietTat!.contains(searchResult.value),
      )
          .toList();
    }

  }

  Future pickExcelFile() async {
    picked = await ExcelService.pickExcelFile();
    return picked;
  }

  setExcelFileName(String fileName) {
    excelFileName.value = fileName;
  }
}
