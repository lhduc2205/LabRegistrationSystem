import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:lab_registration_management/app/core/value/utils/ultils.dart';
import 'package:lab_registration_management/app/data/models/department_model.dart';
import 'package:lab_registration_management/app/data/models/lab_model.dart';
import 'package:lab_registration_management/app/data/providers/capacity_provider.dart';
import 'package:lab_registration_management/app/data/services/api/lab_api_service.dart';
import 'package:lab_registration_management/app/modules/department/controllers/department_controller.dart';
import 'package:lab_registration_management/app/modules/software/controllers/software_controller.dart';

class LabController extends GetxController {
  bool isApiProcess = true;
  bool isAscending = true;
  int currentSortColumn = 0;

  final List<LabModel> labsList = [];
  final List<LabModel> labsFiltered = [];
  final List<CapacityData> ramCapacityList = CapacityProvider.ramCapacityList;
  final List<CapacityData> diskCapacityList = CapacityProvider.diskCapacityList;

  // final selectedLabs = [].obs;
  final softwareSelection = [].obs;
  final ramCapacitySelection = 1.obs;
  final diskCapacitySelection = 1.obs;
  final selectedIndexRow = 0.obs;
  final departmentSelection = 1.obs;
  final searchResult = ''.obs;

  final softwareController = Get.find<SoftwareController>();
  final _departmentController = Get.find<DepartmentController>();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController searchCtrl = TextEditingController();
  final TextEditingController tenPhongCtrl = TextEditingController();
  final TextEditingController soChoNgoiCtrl = TextEditingController();
  final TextEditingController cpuCtrl = TextEditingController();
  final TextEditingController gpuCtrl = TextEditingController();

  final count = 0.obs;

  List<DepartmentModel> get departmentsList =>
      _departmentController.departmentsList;

  @override
  void onInit() {
    fetchLab();
    super.onInit();
  }

  Future<void> refreshData() async {
    await fetchLab();
  }

  Future<List<LabModel>> fetchLab() async {
    labsList.clear();
    labsFiltered.clear();
    try {
      final response = await LabAPIService.fetchLab();
      List labJson = response.data as List;
      labsList.addAll(convertToListLab(labJson));
      sortByLabID();
      labsFiltered.addAll(labsList);
      update();
      isApiProcess = false;
      return labsList;
    } on Exception catch (e) {
      print(e);
      throw Exception(e);
      // return null;
    }
  }

  Future<void> createLab(LabModel _data) async {
    EasyLoading.show(status: 'Loading...');
    try {
      final response = await LabAPIService.createLab(_data);

      labsList.add(LabModel.fromJson(response.data));
      sortByLabID();

      EasyLoading.dismiss();
      Utils.showNotification('Đã thêm ${_data.tenPhong}!');
      resetFilteredResult();
      update();
    } catch (e) {
      EasyLoading.dismiss();
      Utils.showNotification(
        'Phòng thực hành đã tồn tại. Không thể thêm!',
        isError: true,
      );
    }
  }

  Future<void> deleteLab() async {
    EasyLoading.show(status: 'Loading...');
    try {
      int labId = selectedIndexRow.value;
      await LabAPIService.deleteLab(labId);

      final index = labsList.indexWhere(
        (lab) => lab.id == labId,
      );

      selectedIndexRow.value = 0;
      labsList.removeAt(index);

      EasyLoading.dismiss();
      Utils.showNotification('Đã xóa phòng thành công!');
      resetFilteredResult();
      update();
    } catch (e) {
      EasyLoading.dismiss();
      Utils.showNotification(
        'Lỗi! Không thể xóa phòng thực hành.',
        isError: true,
      );
    }
  }

  Future<void> editLab(LabModel data) async {
    EasyLoading.show(status: 'Loading...');
    try {
      final response = await LabAPIService.editLab(data);

      LabModel lab = LabModel.fromJson(response.data);
      labsList[getIndexOf(lab)] = lab;

      EasyLoading.dismiss();
      Utils.showNotification('Cập nhật thành công');
      resetFilteredResult();
      clearTextCtrl();
      selectedIndexRow.value = 0;

      update();
    } catch (e) {
      EasyLoading.dismiss();
      Utils.showNotification(
        'Lỗi! Không thể cập nhật phòng thực hành.',
        isError: true,
      );
    }
  }

  void handleSubmit({isEdited = false}) {
    if (formKey.currentState!.validate()) {
      final LabModel data = LabModel(
        id: isEdited ? selectedIndexRow.value : null,
        tenPhong: tenPhongCtrl.text.trim(),
        soChoNgoi: int.parse(soChoNgoiCtrl.text),
        dungLuongRam:
            CapacityProvider.findRAMCapacity(ramCapacitySelection.value)
                .capacity,
        dungLuongOCung:
            CapacityProvider.findDiskCapacity(diskCapacitySelection.value)
                .capacity,
        cpu: cpuCtrl.text.trim().toLowerCase(),
        gpu: gpuCtrl.text.trim().toLowerCase(),
        boMonId: departmentSelection.value,
        phanMemId: softwareSelection.toList(),
      );
      if (isEdited) {
        editLab(data);
      } else {
        createLab(data);
      }
      Get.back();
      clearTextCtrl();
    }
  }

  void loadDataIntoEditForm() {
    LabModel labData = findLab(selectedIndexRow.value);
    print(labData);
    tenPhongCtrl.text = labData.tenPhong;
    soChoNgoiCtrl.text = labData.soChoNgoi.toString();
    ramCapacitySelection.value =
        CapacityProvider.findRAMByCapacity(labData.dungLuongRam).id;
    diskCapacitySelection.value =
        CapacityProvider.findDiskByCapacity(labData.dungLuongOCung).id;
    cpuCtrl.text = labData.cpu;
    gpuCtrl.text = labData.gpu;
    departmentSelection.value = labData.boMonId;
    softwareSelection.clear();
    softwareSelection.addAll(labData.phanMemId);
  }

  List<LabModel> convertToListLab(List list) {
    return list.map((lab) => LabModel.fromJson(lab)).toList();
  }

  sortByLabID() {
    labsList.sort(
          (a, b) => int.parse(a.tenPhong.substring(1, 3)).compareTo(
        int.parse(
          b.tenPhong.substring(1, 3),
        ),
      ),
    );
  }

  bool isSoftwareSelected(int id) {
    return softwareSelection.contains(id);
  }

  LabModel findLab(int labId) {
    final lab = labsList.firstWhere((lab) => lab.id == labId);
    return lab;
  }

  int getIndexOf(LabModel data) {
    return labsList.indexWhere(
      (lab) => lab.id == data.id,
    );
  }

  List<DepartmentModel> getDepartments() {
    return _departmentController.departmentsList;
  }

  String getNameById(int id) {
    final index = labsList.indexWhere(
      (lab) => lab.id == id,
    );
    return labsList[index].tenPhong;
  }

  DepartmentModel getDepartmentByName(String name) {
    return _departmentController.findDepartmentByName(searchResult.value);
  }

  onSelectedChanged(bool value, int index) {
    selectedIndexRow.value = value ? index : 0;
  }

  onDeleteSearchResult() {
    clearTextCtrl();
    resetFilteredResult();
  }

  void onChangedSearch(String value) {
    searchResult.value = value.trim();
    _filteredLab();
  }

  _filteredLab() {
    labsFiltered.clear();
    final departments = getDepartments();
    final filter =
        labsList.where((lab) => lab.tenPhong.contains(searchResult)).toList();

    labsFiltered.addAll(filter);

    update();
  }

  resetFilteredResult() {
    labsFiltered.clear();
    labsFiltered.addAll(labsList);
  }

  setSoftwareSelected(int id) {
    if (softwareSelection.contains(id)) {
      softwareSelection.remove(id);
    } else {
      softwareSelection.add(id);
    }
  }

  setSelectedIndexRow(int id) {
    selectedIndexRow.value = id;
  }

  setRAMCapacity(String? id) {
    ramCapacitySelection.value = int.parse(id!);
  }

  setDiskCapacity(String? id) {
    diskCapacitySelection.value = int.parse(id!);
  }

  setDepartment(String? id) {
    departmentSelection.value = int.parse(id!);
  }

  clearTextCtrl() {
    tenPhongCtrl.clear();
    soChoNgoiCtrl.clear();
    ramCapacitySelection.value = 1;
    diskCapacitySelection.value = 1;
    departmentSelection.value = 1;
    softwareSelection.clear();
    cpuCtrl.clear();
    gpuCtrl.clear();
    searchResult.value = '';
    searchCtrl.clear();
    update();
  }
}
