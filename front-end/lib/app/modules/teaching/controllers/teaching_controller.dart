import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lab_registration_management/app/core/value/constants/app_constants.dart';
import 'package:lab_registration_management/app/core/value/utils/ultils.dart';
import 'package:lab_registration_management/app/data/models/course_model.dart';
import 'package:lab_registration_management/app/data/models/day_model.dart';
import 'package:lab_registration_management/app/data/models/lecturer_model.dart';
import 'package:lab_registration_management/app/data/models/period_model.dart';
import 'package:lab_registration_management/app/data/models/subject_model.dart';
import 'package:lab_registration_management/app/data/services/api/course_api_service.dart';
import 'package:lab_registration_management/app/data/services/excel_service.dart';
import 'package:lab_registration_management/app/modules/lecturer/controllers/lecturer_controller.dart';
import 'package:lab_registration_management/app/modules/root/controllers/day_controller.dart';
import 'package:lab_registration_management/app/modules/root/controllers/period_controller.dart';
import 'package:lab_registration_management/app/modules/subject/controllers/subject_controller.dart';

class TeachingController extends GetxController {
  int currentSortColumn = 0;
  bool isAscending = true;
  var isApiProcess = true.obs;

  final _lecturerController = Get.find<LecturerController>();
  final _subjectController = Get.find<SubjectController>();
  final _dayController = Get.find<DayController>();
  final _periodController = Get.find<PeriodController>();
  final box = GetStorage();

  List<CourseModel> teachingList = [];
  List<LecturerModel> lecturerList = [];
  List<CourseModel> teachingFiltered = [];

  late Future<List<CourseModel>> futureTeaching;
  late FilePickerResult? picked;

  var selectedTeaching = [].obs;
  var searchResult = ''.obs;
  var excelFileName = ''.obs;
  var selectedIndexRow = 0.obs;
  var sessionSelection = 0.obs;
  var daySelection = 0.obs;
  var subjectSelectionById = 0.obs;
  var subjectSelectionByName = 0.obs;
  var lecturerSelection = 0.obs;
  var isCheckFilteredLecturer = false.obs;
  var isHideCloseBtn = true.obs;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController searchCtrl = TextEditingController();
  final TextEditingController maHPCtrl = TextEditingController();
  final TextEditingController soLuongCtrl = TextEditingController();
  final TextEditingController searchController = TextEditingController();

  String get role => box.read(BoxString.ROLE);

  String get email => box.read(BoxString.EMAIL);

  int get uid => box.read(BoxString.UID);

  @override
  void onInit() {
    futureTeaching = fetchTeaching();
    super.onInit();
  }

  Future<void> refreshData() async {
    await fetchTeaching();
  }

  Future<List<CourseModel>> fetchTeaching() async {
    isApiProcess.value = true;
    try {
      final response = await CourseAPIService.fetch();
      List teachingJson = response.data as List;

      teachingList = convertToListTeaching(teachingJson);

      if (role != 'admin') {
        teachingList = findTeachingByLecturer(teachingList, uid);
      }

      setTeachingFiltered(teachingList);

      lecturerList = getLecturers();
      isApiProcess.value = false;

      update();
      return teachingList;
    } on Exception catch (e) {
      print(e);
      throw Exception(e);
      // return null;
    }
  }

  Future<void> createTeaching(CourseModel _data, String password) async {
    EasyLoading.show(status: 'Đang tải...');
    try {
      final response = await CourseAPIService.create(_data);
      final teaching = CourseModel.fromJson(response.data);
      teachingList.add(teaching);

      EasyLoading.dismiss();
      Utils.showNotification('Đã thêm nhóm ${_data.maLopHocPhan}!');

      // clearTextCtrl();
      update();
    } catch (e) {
      EasyLoading.dismiss();
      Utils.showNotification(
        'Giảng viên đã tồn tại. Không thể thêm!',
        isError: true,
      );
    }
  }

  Future<void> uploadExcel(FilePickerResult file) async {
    EasyLoading.show(status: 'Đang tải...');
    try {
      final response = await CourseAPIService.uploadFile(file);
      List teachingJson = response.data as List;

      if (teachingJson.isNotEmpty) {
        teachingList.clear();
        teachingList.addAll(convertToListTeaching(teachingJson));
      }

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

  List<CourseModel> convertToListTeaching(List list) {
    return list.map((teaching) => CourseModel.fromJson(teaching)).toList();
  }

  onCheckFilterLecturer(bool value) {
    isCheckFilteredLecturer.value = value;
    if (value) {
      setLecturerSelection(lecturerList[0].id.toString());
    } else {
      setLecturerSelection('0');
    }
  }

  onSelectedChanged(bool value, int index) {
    selectedIndexRow.value = value ? index : 0;
  }

  onTapCloseBtn() {
    searchCtrl.clear();
    searchResult.value = '';
    isHideCloseBtn.value = true;
    setTeachingFiltered(teachingList);
    update();
  }

  onChangedSearchInput(String value) {
    if (value.isEmpty || value == '') {
      isHideCloseBtn.value = true;
    } else {
      isHideCloseBtn.value = false;
    }

    searchResult.value = value.trim();
    setTeachingFiltered(getFilteredTeachingList());
    update();

    // teachingFiltered = teachingList
    //     .where((teaching) => teaching.hoTenGV!.contains(searchResult.value))
    //     .toList();
    // update();
  }

  // Return index of teaching in List<CourseModel>
  int getIndexOf(CourseModel data) {
    return teachingList.indexWhere((teaching) => teaching.id == data.id);
  }

  List<CourseModel> getFilteredTeachingList() {
    setTeachingFiltered(teachingList);

    if(searchResult.value.contains('\'')) {
      final splitter = searchResult.value.split('\'');
      setTeachingFiltered(
        teachingList
            .where(
              (teaching) =>
            teaching.maMonHoc!.contains(splitter[0]) &&
              teaching.maLopHocPhan.contains(splitter[1])
        )
            .toList(),
      );
    } else {
      setTeachingFiltered(
        teachingList
            .where(
              (teaching) =>
          teaching.maMonHoc!.contains(searchResult.value) ||
              teaching.hoTenGV!.contains(searchResult.value) ||
              teaching.maGV!.contains(
                searchResult.value,
              ),
        )
            .toList(),
      );
    }

    if (subjectSelectionById.value == 0 &&
        sessionSelection.value == 0 &&
        daySelection.value == 0 &&
        lecturerSelection.value == 0) {
      // !isCheckFilteredLecturer.value) {
      // setTeachingFiltered(teachingList);
      return teachingFiltered;
    }
    if (subjectSelectionById > 0) {
      setTeachingFiltered(filteredTeachingBySubject());
    }
    if (sessionSelection > 0) {
      setTeachingFiltered(filteredTeachingBySession());
    }
    if (daySelection > 0) {
      setTeachingFiltered(filteredTeachingByDay());
    }
    if (isCheckFilteredLecturer.value) {
      setTeachingFiltered(filteredTeachingByLecturer());
      getSubjectByLecturer(lecturerSelection.value);
    }
    return teachingFiltered;
  }

  List<CourseModel> filteredTeachingByLecturer() {
    final curFilteredData = teachingFiltered;
    return curFilteredData
        .where(
          (teaching) => (teaching.giangVienId ==
              _lecturerController.findLecturer(lecturerSelection.value).id),
        )
        .toList();
  }

  List<CourseModel> filteredTeachingByDay() {
    final curFilteredData = teachingFiltered;
    return curFilteredData
        .where(
          (teaching) =>
              (teaching.thuId == _dayController.findDay(daySelection.value).id),
        )
        .toList();
  }

  List<CourseModel> filteredTeachingBySubject() {
    final curFilteredData = teachingFiltered;
    return curFilteredData
        .where(
          (teaching) => (teaching.monHocId ==
              _subjectController.findSubject(subjectSelectionById.value).id),
        )
        .toList();
  }

  List<CourseModel> filteredTeachingBySession() {
    final curFilteredData = teachingFiltered;
    return curFilteredData
        .where(
          (teaching) => (teaching.buoiHocId ==
              _periodController.findSession(sessionSelection.value).id),
        )
        .toList();
  }

  List<SubjectModel> getSubjects({bool sortById = true, int gvId = 0}) {
    var subjectsList = _subjectController.subjectsList;
    sortById
        ? subjectsList.sort((a, b) => a.maMonHoc.compareTo(b.maMonHoc))
        : subjectsList.sort((a, b) =>
            a.tenMonHoc.substring(0, 1).compareTo(b.tenMonHoc.substring(0, 1)));
    return subjectsList;
  }

  List<PeriodModel> getSessions() {
    final sessionList = _periodController.periodList;
    sessionList.sort((a, b) => a.id.compareTo(b.id));
    return sessionList;
  }

  List<DayModel> getDays() {
    final dayList = _dayController.daysList;
    dayList.sort((a, b) => a.id.compareTo(b.id));
    return dayList;
  }

  List<LecturerModel> getLecturers() {
    final lecturerList = _lecturerController.lecturersList
        .where((lecturer) => lecturer.maVaiTro != 'admin')
        .toList();
    lecturerList.sort((a, b) => a.hoTen.compareTo(b.hoTen));
    return lecturerList;
  }

  CourseModel findTeaching(int id) {
    return teachingList.firstWhere((teaching) => teaching.id == id);
  }

  List<CourseModel> findTeachingByLecturer(
      List<CourseModel> _teachingList, int lecturerID) {
    return _teachingList
        .where((teaching) => teaching.giangVienId == lecturerID)
        .toList();
  }

  Iterable<CourseModel> getSubjectByLecturer(int id) {
    var _teachingList = teachingList;
    return _teachingList;
  }

  LecturerModel findLecturer(int id) {
    return _lecturerController.findLecturer(id);
  }

  DayModel findDay(int id) {
    return _dayController.findDay(id);
  }

  PeriodModel findSession(int id) {
    return _periodController.findSession(id);
  }

  SubjectModel findSubject(int id) {
    return _subjectController.findSubject(id);
  }

  // Check existed value in edit form
  // bool checkExistEmail(String email) {
  //   final emailGV =
  //   teachingList.indexWhere((teaching) => teaching.emailGV == email);
  //   if (emailGV >= 0) {
  //     return true;
  //   }
  //   return false;
  // }
  // bool checkExistIdteaching(String maGV) {
  //   final emailGV = teachingList.indexWhere(
  //         (teaching) => teaching.maGv == maGV,
  //   );
  //   if (emailGV >= 0) {
  //     return true;
  //   }
  //   return false;
  // }
  //
  clearTextCtrl() {
    maHPCtrl.clear();
    soLuongCtrl.clear();
    update();
  }

  resetFiltered() {
    setSessionSelection('0');
    setDaySelection('0');
    setSubjectSelection('0');
    setSubjectSelection('0', isSetId: false);
    setLecturerSelection('0');
    isCheckFilteredLecturer.value = false;
  }

  // // Set value
  // setGender(bool gender) {
  //   isFemale.value = gender;
  // }
  setTeachingFiltered(List<CourseModel> newList) {
    teachingFiltered = newList;
  }

  setExcelFileName(String fileName) {
    excelFileName.value = fileName;
  }

  setSubjectSelection(String id, {bool isSetId = true}) {
    if (isSetId) {
      subjectSelectionById.value = int.parse(id);
      subjectSelectionByName.value =
          _subjectController.findSubject(subjectSelectionById.value).id!;
    } else {
      subjectSelectionByName.value = int.parse(id);
      subjectSelectionById.value =
          _subjectController.findSubject(subjectSelectionByName.value).id!;
    }
    update();
  }

  setSessionSelection(String id) {
    sessionSelection.value = int.parse(id);
    update();
  }

  setDaySelection(String id) {
    daySelection.value = int.parse(id);
    update();
  }

  setLecturerSelection(String id) {
    lecturerSelection.value = int.parse(id);
    update();
  }

  Future pickExcelFile() async {
    picked = await ExcelService.pickExcelFile();
    return picked;
  }
}
