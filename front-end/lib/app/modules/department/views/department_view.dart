library department;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:lab_registration_management/app/core/value/constants/app_constants.dart';
import 'package:lab_registration_management/app/core/value/theme/themes.dart';
import 'package:lab_registration_management/app/data/models/department_model.dart';
import 'package:lab_registration_management/app/data/services/data_table_service.dart';
import 'package:lab_registration_management/app/routes/routes.dart';
import 'package:lab_registration_management/app/share_components/confirm_dialog.dart';
import 'package:lab_registration_management/app/share_components/content_layout.dart';
import 'package:lab_registration_management/app/share_components/custom_text_form_field.dart';
import 'package:lab_registration_management/app/share_components/loading_overlay.dart';
import 'package:lab_registration_management/app/share_components/search_bar.dart';

import '../controllers/department_controller.dart';

part 'widgets/data_table.dart';

part 'widgets/department_form.dart';

part 'widgets/data_table_source.dart';

class DepartmentView extends GetView<DepartmentController> {
  const DepartmentView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ContentLayout(
        child: _buildDepartmentGetBuilder(),
        title: departmentPageDisplayName,
        isSelectedRow: controller.selectedIndexRow.value > 0,
        onRefresh: controller.refreshData,
        warningText: "Sẽ không thể hoàn tác nếu xóa bộ môn",
        searchBar: _buildSearchBar(),
        onCreatedPressed: () => Get.dialog(
          showCreatedDialog(),
          barrierDismissible: false,
        ),
        onEditedPressed: () {
          controller.loadDataIntoEditForm();
          Get.dialog(
            showEditDialog(),
          );
        },
        onDeletedPressed: () => Get.dialog(
          showDeleteDialog(controller.selectedIndexRow.value),
        ),
      ),
    );
  }

  SearchBar _buildSearchBar() {
    return SearchBar(
        searchController: controller.searchCtrl,
        isHideCloseBtn: controller.searchResult.value.isEmpty,
        onChanged: (value) => controller.onChangedSearch(value),
        onTapCloseBtn: controller.onDeleteSearchResult,
      );
  }

  GetBuilder<DepartmentController> _buildDepartmentGetBuilder() {
    return GetBuilder<DepartmentController>(
      builder: (controller) {
        return LoadingOverlay(
          isLoading: controller.isApiProcess,
          child: _DepartmentDataTable(
            departments: controller.departmentsFiltered,
            controller: controller,
          ),
        );
      },
    );
  }

  Widget showCreatedDialog() {
    return ConfirmDialog(
      title: "Thêm bộ môn",
      content: _DepartmentForm(controller: controller),
      onAcceptPressed: () => controller.handleCreatedSubmit(),
      onCancelPressed: () => Get.back(),
    );
  }

  Widget showEditDialog() {
    return ConfirmDialog(
      title: "Cập nhật",
      primaryColor: kGreen,
      content: _DepartmentForm(controller: controller),
      acceptBtnText: "cập nhật",
      onAcceptPressed: () => controller.handleUpdatedSubmit(),
      onCancelPressed: () {
        controller.clearTextCtrl();
        Get.back();
      },
    );
  }

  Widget showDeleteDialog(int id) {
    return ConfirmDialog(
      title: "Cảnh báo",
      primaryColor: kRed,
      content: const Text(
        "Sẽ không thể hoàn tác nếu đã xóa bộ môn",
        style: TextStyle(
          color: kBlack,
        ),
      ),
      acceptBtnText: "xóa",
      onAcceptPressed: () {
        controller.deleteDepartment(id);
        Get.back();
      },
      onCancelPressed: () => Get.back(),
    );
  }
}
