library lecturer;

import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lab_registration_management/app/core/value/constants/app_constants.dart';
import 'package:lab_registration_management/app/core/value/helpers/app_helpers.dart';
import 'package:lab_registration_management/app/core/value/theme/themes.dart';
import 'package:lab_registration_management/app/data/models/department_model.dart';
import 'package:lab_registration_management/app/data/models/lecturer_model.dart';
import 'package:lab_registration_management/app/data/services/data_table_service.dart';
import 'package:lab_registration_management/app/modules/department/controllers/department_controller.dart';
import 'package:lab_registration_management/app/routes/routes.dart';
import 'package:lab_registration_management/app/share_components/confirm_dialog.dart';
import 'package:lab_registration_management/app/share_components/content_layout.dart';
import 'package:lab_registration_management/app/share_components/custom_text_form_field.dart';
import 'package:lab_registration_management/app/share_components/default_button.dart';
import 'package:lab_registration_management/app/share_components/default_icon_button.dart';
import 'package:lab_registration_management/app/share_components/loading_overlay.dart';
import 'package:lab_registration_management/app/share_components/search_bar.dart';

import '../controllers/lecturer_controller.dart';

part './widgets/data_table.dart';

part './widgets/department_dropdown.dart';

part './widgets/data_table_source.dart';

part './widgets/lecturer_form.dart';

part 'widgets/gender_checkbox.dart';

part 'widgets/add_button.dart';

class LecturerView extends GetView<LecturerController> {
  const LecturerView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ContentLayout(
        child: _buildLecturerDataTable(),
        onRefresh: controller.refreshData,
        title: lecturerPageDisplayName,
        isSelectedRow: controller.selectedIndexRow.value > 0,
        warningText: "Sẽ không thể hoàn tác nếu xóa giảng viên",
        searchBar: _buildSearchBar(),
        onCreatedPressed: () => Get.dialog(
          _buildCreatedDialog(),
          barrierDismissible: false,
        ),
        onEditedPressed: () {
          controller.loadDataIntoEditForm(controller.selectedIndexRow.value);
          Get.dialog(
            showEditDialog(controller.selectedIndexRow.value),
          );
        },
        onDeletedPressed: () => Get.dialog(
          showDeleteDialog(controller.selectedIndexRow.value),
        ),
      ),
    );
  }

  ConfirmDialog _buildCreatedDialog() {
    return ConfirmDialog(
        title: "Thêm Giảng viên",
        content: SingleChildScrollView(
          child:  _LecturerForm(
            controller: controller,
          ),
        ),
        onAcceptPressed: () => controller.handleCreatedSubmit(),
        onCancelPressed: () => Get.back(),
      );
  }

  GetBuilder<LecturerController> _buildLecturerDataTable() {
    return GetBuilder<LecturerController>(
      builder: (controller) {
        return LoadingOverlay(
          isLoading: controller.isApiProcess,
          child: _LecturerDataTable(
            lecturers: controller.lecturersFiltered,
            controller: controller,
          ),
        );
      },
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

  Widget showDeleteDialog(int id) {
    return ConfirmDialog(
      title: "Cảnh báo",
      primaryColor: kRed,
      content: const Text(
        "Sẽ không thể hoàn tác nếu đã xóa giảng viên",
        style: TextStyle(
          color: kBlack,
        ),
      ),
      acceptBtnText: "xóa",
      onAcceptPressed: () async {
        await controller.deleteLecturer(id);
        Get.back();
      },
      onCancelPressed: () => Get.back(),
    );
  }

  Widget showEditDialog(int id) {
    return ConfirmDialog(
      title: "Cập nhật",
      primaryColor: kGreen,
      content: _LecturerForm(
        controller: controller,
        primaryColor: kGreen,
        isEditedMode: true,
      ),
      acceptBtnText: "cập nhật",
      onAcceptPressed: () => controller.handleUpdatedSubmit(id),
      onCancelPressed: () => {Get.back(), controller.clearTextCtrl()},
    );
  }
}
