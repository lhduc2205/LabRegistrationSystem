import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lab_registration_management/app/core/value/utils/ultils.dart';
import 'package:lab_registration_management/app/data/models/lecturer_model.dart';
import 'package:flutter/material.dart';
import 'package:lab_registration_management/app/data/services/api/lecturer_api_service.dart';
import 'package:lab_registration_management/app/modules/department/controllers/department_controller.dart';

class LecturerController extends GetxController {
  int currentSortColumn = 0;
  bool isApiProcess = true;
  bool isAscending = true;
  DateTime initDate = DateTime(2000, 05, 22);
  DateTime selectedDate = DateTime(2000, 05, 22);

  // late List<LecturerModel> lecturersList;
  final List<LecturerModel> lecturersList = [];
  final List<LecturerModel> lecturersFiltered = [];

  late Future<List<LecturerModel>> futureLecturer;

  final selectedLecturers = [].obs;
  final isFemale = false.obs;
  final searchResult = ''.obs;
  final departmentSelection = 1.obs;
  final selectedIndexRow = 0.obs;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController searchCtrl = TextEditingController();
  final TextEditingController hoTenCtrl = TextEditingController();
  final TextEditingController maGvCtrl = TextEditingController();
  final TextEditingController ngaySinhCtrl = TextEditingController();
  final TextEditingController sdtCtrl = TextEditingController();
  final TextEditingController emailCtrl = TextEditingController();
  final TextEditingController passwordCtrl = TextEditingController();

  final count = 0.obs;

  @override
  void onInit() {
    futureLecturer = fetchLecturer();
    super.onInit();
  }

  Future<void> refreshData() async {
    await fetchLecturer();
  }

  Future<List<LecturerModel>> fetchLecturer() async {
    lecturersList.clear();
    try {
      final response = await LecturerAPIService.fetchLecturer();
      List lecturerJson = response.data as List;
      lecturersList.addAll(convertToListLecturer(lecturerJson));
      resetFilteredResult();
      isApiProcess = false;
      update();
      return lecturersList;
    } on Exception catch (e) {
      print(e);
      throw Exception(e);
      // return null;
    }
  }

  Future<void> createLecturer(LecturerModel _data, String password) async {
    EasyLoading.show(status: 'Đang tải...');
    try {
      final response = await LecturerAPIService.createLecturer(_data, password);
      final lecturer = LecturerModel.fromJson(response.data);
      lecturersList.add(lecturer);
      resetFilteredResult();

      EasyLoading.dismiss();
      Utils.showNotification('Đã thêm giảng viên ${_data.hoTen}!');

      clearTextCtrl();
      update();
    } catch (e) {
      EasyLoading.dismiss();
      Utils.showNotification(
        'Giảng viên đã tồn tại. Không thể thêm!',
        isError: true,
      );
    }
  }

  Future<void> deleteLecturer(int id) async {
    LecturerModel data = findLecturer(id);
    EasyLoading.show(status: 'Đang tải...');
    try {
      await LecturerAPIService.deleteLecturer(data.id!, data.emailGV);

      final index = lecturersList.indexWhere(
        (lecturer) => lecturer.id == data.id,
      );

      lecturersList.removeAt(index);
      resetFilteredResult();
      selectedIndexRow.value = 0;

      EasyLoading.dismiss();
      Utils.showNotification('Đã xóa giảng viên ${data.hoTen}!');

      clearTextCtrl();
      update();
    } catch (e) {
      EasyLoading.dismiss();
      Utils.showNotification(
        'Lỗi! Không thể xóa giảng viên.',
        isError: true,
      );
    }
  }

  Future<void> updateLecturer(LecturerModel _data, bool isChangedMaGV) async {
    EasyLoading.show(status: 'Đang tải...');
    try {
      final response =
          await LecturerAPIService.updateLecturer(_data, isChangedMaGV);

      LecturerModel lecturer = LecturerModel.fromJson(response.data);

      final departmentName =
          Get.find<DepartmentController>().getNameById(lecturer.boMonId);

      lecturer.tenBoMon = departmentName;
      lecturersList[getIndexOf(lecturer)] = lecturer;
      resetFilteredResult();
      selectedIndexRow.value = 0;

      EasyLoading.dismiss();
      Utils.showNotification('Cập nhật thành công!');

      clearTextCtrl();
      update();
    } catch (e) {
      EasyLoading.dismiss();
      Utils.showNotification(
        'Lỗi! Không thể cập nhật giảng viên.',
        isError: true,
      );
    }

    clearTextCtrl();
  }


  handleCreatedSubmit() {
    final LecturerModel data = LecturerModel(
      id: null,
      hoTen: hoTenCtrl.text.trim().toLowerCase(),
      maGv: maGvCtrl.text.trim().toLowerCase(),
      gioiTinh: isFemale.value,
      ngaySinh: selectedDate,
      sdt: sdtCtrl.text.trim(),
      boMonId: departmentSelection.value,
      emailGV: emailCtrl.text.trim().toLowerCase(),
    );
    if (formKey.currentState!.validate()) {
      createLecturer(data, passwordCtrl.text.trim());
      Get.back();
    }
  }

  handleUpdatedSubmit(int id) {
    String maGV = findLecturer(id).maGv;
    if (formKey.currentState!.validate()) {
      final LecturerModel data = LecturerModel(
        id: id,
        hoTen: hoTenCtrl.text.trim().toLowerCase(),
        maGv: maGvCtrl.text.trim().toLowerCase(),
        gioiTinh: isFemale.value,
        ngaySinh: selectedDate,
        sdt: sdtCtrl.text.trim().toLowerCase(),
        boMonId: departmentSelection.value,
        emailGV: emailCtrl.text,
      );

      updateLecturer(data, maGV != maGvCtrl.text.trim());
      Get.back();
      clearTextCtrl();
    }
  }

  List<LecturerModel> convertToListLecturer(List list) {
    return list.map((lecturer) => LecturerModel.fromJson(lecturer)).toList();
  }

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1970),
      lastDate: DateTime(2001),
    );
    if (picked != null && picked != selectedDate) {
      selectedDate = picked;
    }
    final format = DateFormat('dd-MM-yyyy').format(selectedDate);

    ngaySinhCtrl.text = format.toString();
  }

  void loadDataIntoEditForm(int id) {
    LecturerModel data = findLecturer(id);
    hoTenCtrl.text = data.hoTen;
    maGvCtrl.text = data.maGv;
    sdtCtrl.text = data.sdt;
    emailCtrl.text = data.emailGV;
    departmentSelection.value = data.boMonId;
    isFemale.value = data.gioiTinh;
    selectedDate = data.ngaySinh;
    ngaySinhCtrl.text = DateFormat('dd-MM-yyyy').format(selectedDate);
  }

  // Handle filtering of lecturers
  onChangedSearch(String value) {
    searchResult.value = value.trim().toLowerCase();
    _filteredLecturer();
  }

  _filteredLecturer() {
    lecturersFiltered.clear();
    final filter = lecturersList
        .where((lecturer) =>
            lecturer.hoTen.contains(searchResult) ||
            lecturer.maGv.contains(searchResult) ||
            lecturer.emailGV.contains(searchResult) ||
            lecturer.sdt.contains(searchResult))
        .toList();

    lecturersFiltered.addAll(filter);

    update();
  }

  onSelectedChanged(bool value, int index) {
    selectedIndexRow.value = value ? index : 0;
  }

  onDeleteSearchResult() {
    clearTextCtrl();
    resetFilteredResult();
  }

  resetFilteredResult() {
    lecturersFiltered.clear();
    lecturersFiltered.addAll(lecturersList);
  }

  // Return index of lecturer in List<LecturerModel>
  int getIndexOf(LecturerModel data) {
    return lecturersList.indexWhere((lecturer) => lecturer.id == data.id);
  }

  LecturerModel findLecturer(int id) {
    return lecturersList.firstWhere((lecturer) => lecturer.id == id);
  }

  LecturerModel findLecturerByEmail(String email) {
    return lecturersList.firstWhere((lecturer) => lecturer.emailGV == email);
  }


  // Check existed value in edit form
  bool checkExistEmail(String email) {
    final emailGV =
        lecturersList.indexWhere((lecturer) => lecturer.emailGV == email);
    if (emailGV >= 0) {
      return true;
    }
    return false;
  }

  bool checkExistIdLecturer(String maGV) {
    final emailGV = lecturersList.indexWhere(
      (lecturer) => lecturer.maGv == maGV,
    );
    if (emailGV >= 0) {
      return true;
    }
    return false;
  }

  clearTextCtrl() {
    hoTenCtrl.clear();
    maGvCtrl.clear();
    ngaySinhCtrl.clear();
    sdtCtrl.clear();
    emailCtrl.clear();
    passwordCtrl.clear();
    setGender(false);
    setDepartmentSelection(lecturersList[0].boMonId.toString());
    selectedDate = initDate;
    searchResult.value = '';
    searchCtrl.clear();
    update();
  }

  // Set value
  setGender(bool gender) {
    isFemale.value = gender;
  }

  setDepartmentSelection(String id) {
    departmentSelection.value = int.parse(id);
  }
}
