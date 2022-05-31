import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:lab_registration_management/app/core/value/utils/ultils.dart';
import 'package:lab_registration_management/app/data/models/department_model.dart';
import 'package:lab_registration_management/app/data/services/api/department_api_service.dart';

class DepartmentController extends GetxController {
  bool isApiProcess = true;
  int currentSortColumn = 0;
  bool isAscending = true;

  // late List<DepartmentModel> departmentsList;
  List<DepartmentModel> departmentsList = [];
  List<DepartmentModel> departmentsFiltered = [];

  final selectedIndexRow = 0.obs;
  final selectedDepartments = [].obs;
  final searchResult = ''.obs;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController searchCtrl = TextEditingController();
  final TextEditingController tenBMCtrl = TextEditingController();
  final TextEditingController vietTatCtrl = TextEditingController();

  final count = 0.obs;

  @override
  void onInit() {
    fetchDepartment();
    super.onInit();
  }

  Future<void> refreshData() async {
    await fetchDepartment();
  }

  Future<List<DepartmentModel>> fetchDepartment() async {
    departmentsList.clear();
    departmentsFiltered.clear();
    try {
      final response = await DepartmentAPIService.fetchDepartment();
      List departmentJson = response.data as List;
      // departmentsList = convertToListDepartment(departmentJson);
      departmentsList.addAll(convertToListDepartment(departmentJson));
      departmentsFiltered.addAll(departmentsList);
      isApiProcess = false;
      update();
      return departmentsList;
    } on Exception catch (e) {
      print(e);
      throw Exception(e);
      // return null;
    }
  }

  Future<void> createDepartment(DepartmentRequestModel _data) async {
    EasyLoading.show(status: 'Loading...');
    try {
      final response = await DepartmentAPIService.createDepartment(_data);

      departmentsList.add(DepartmentModel.fromJson(response.data));

      EasyLoading.dismiss();
      Utils.showNotification('Đã thêm bộ môn ${_data.tenBoMon}!');
      resetDepartmentsFiltered();
      clearTextCtrl();
      update();
    } catch (e) {
      EasyLoading.dismiss();
      Utils.showNotification(
        'Bộ môn đã tồn tại. Không thể thêm!',
        isError: true,
      );
    }
  }

  Future<void> deleteDepartment(int id) async {
    EasyLoading.show(status: 'Loading...');
    try {
      await DepartmentAPIService.deleteDepartment(id);

      final index = departmentsList.indexWhere(
        (department) => department.id == id,
      );
      departmentsList.removeAt(index);
      selectedIndexRow.value = 0;

      EasyLoading.dismiss();
      Utils.showNotification('Đã xóa bộ môn thành công!');
      resetDepartmentsFiltered();
      clearTextCtrl();
      update();
    } catch (e) {
      EasyLoading.dismiss();
      Utils.showNotification(
        'Lỗi! Không thể xóa bộ môn.',
        isError: true,
      );
    }
  }

  Future<void> updateDepartment(DepartmentModel _data) async {
    EasyLoading.show(status: 'Loading...');
    try {
      final response = await DepartmentAPIService.updateDepartment(_data);

      DepartmentModel department = DepartmentModel.fromJson(response.data);
      departmentsList[getIndexOf(department)] = department;

      EasyLoading.dismiss();
      Utils.showNotification('Cập nhật thành công');
      resetDepartmentsFiltered();
      clearTextCtrl();
      update();
    } catch (e) {
      EasyLoading.dismiss();
      Utils.showNotification(
        'Lỗi! Không thể cập nhật bộ môn.',
        isError: true,
      );
    }

    clearTextCtrl();
  }

  handleCreatedSubmit() {
    final DepartmentRequestModel data = DepartmentRequestModel(
      tenBoMon: tenBMCtrl.text.trim().toLowerCase(),
      vietTat: vietTatCtrl.text.trim().toLowerCase(),
    );
    if (formKey.currentState!.validate()) {
      createDepartment(data);
      Get.back();
      clearTextCtrl();
    }
  }

  handleUpdatedSubmit() {
    if (formKey.currentState!.validate()) {
      final DepartmentModel data = DepartmentModel(
        id: selectedIndexRow.value,
        tenBoMon: tenBMCtrl.text.trim().toLowerCase(),
        vietTat: vietTatCtrl.text.trim().toLowerCase(),
      );
      updateDepartment(data);
      Get.back();
      clearTextCtrl();
    }
  }

  void loadDataIntoEditForm() {
    DepartmentModel department = findDepartment(selectedIndexRow.value);
    tenBMCtrl.text = department.tenBoMon;
    vietTatCtrl.text = department.vietTat;
  }

  void onChangedSearch(String value) {
    searchResult.value = value.trim().toLowerCase();
    _filteredDepartment();
  }

  void _filteredDepartment() {
    final filter = departmentsList
        .where(
          (department) =>
              department.tenBoMon.contains(searchResult) ||
              department.vietTat.contains(searchResult),
        )
        .toList();
    departmentsFiltered.clear();
    departmentsFiltered.addAll(filter);
    update();
  }

  List<DepartmentModel> convertToListDepartment(List list) {
    return list
        .map((department) => DepartmentModel.fromJson(department))
        .toList();
  }

  DepartmentModel findDepartment(int id) {
    return departmentsList.firstWhere(
      (department) => department.id == id,
    );
  }

  DepartmentModel findDepartmentByName(String name) {
    return departmentsList.firstWhere(
          (department) => department.tenBoMon == name,
    );
  }

  int getIndexOf(DepartmentModel data) {
    return departmentsList.indexWhere(
      (department) => department.id == data.id,
    );
  }

  String getNameById(int id) {
    final index = departmentsList.indexWhere(
      (department) => department.id == id,
    );
    return departmentsList[index].tenBoMon;
  }

  onSelectedChanged(bool value, int index) {
    selectedIndexRow.value = value ? index : 0;
  }

  onDeleteSearchResult() {
    clearTextCtrl();
    resetDepartmentsFiltered();
  }

  resetDepartmentsFiltered() {
    departmentsFiltered.clear();
    departmentsFiltered.addAll(departmentsList);
  }

  void clearTextCtrl() {
    tenBMCtrl.clear();
    vietTatCtrl.clear();
    searchResult.value = '';
    searchCtrl.clear();
    update();
  }
}
