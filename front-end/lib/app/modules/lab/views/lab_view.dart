library lab;

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:lab_registration_management/app/core/value/constants/app_constants.dart';
import 'package:lab_registration_management/app/core/value/helpers/app_helpers.dart';
import 'package:lab_registration_management/app/core/value/theme/themes.dart';
import 'package:lab_registration_management/app/data/models/lab_model.dart';
import 'package:lab_registration_management/app/data/providers/capacity_provider.dart';
import 'package:lab_registration_management/app/data/services/data_table_service.dart';
import 'package:lab_registration_management/app/modules/department/controllers/department_controller.dart';
import 'package:lab_registration_management/app/modules/software/controllers/software_controller.dart';
import 'package:lab_registration_management/app/routes/routes.dart';
import 'package:lab_registration_management/app/share_components/confirm_dialog.dart';
import 'package:lab_registration_management/app/share_components/content_layout.dart';
import 'package:lab_registration_management/app/share_components/custom_chip_widget.dart';
import 'package:lab_registration_management/app/share_components/custom_text_form_field.dart';
import 'package:lab_registration_management/app/share_components/default_choice_chip.dart';
import 'package:lab_registration_management/app/share_components/default_dropdown.dart';
import 'package:lab_registration_management/app/share_components/loading_overlay.dart';
import 'package:lab_registration_management/app/share_components/search_bar.dart';

import '../controllers/lab_controller.dart';

part 'widgets/data_table_source.dart';

part 'widgets/data_table.dart';

part 'widgets/lab_form.dart';

part 'widgets/capacity_dropdown.dart';

class LabView extends GetView<LabController> {
  const LabView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ContentLayout(
        child: _buildDepartmentGetBuilder(),
        onRefresh: controller.refreshData,
        title: labPageDisplayName,
        isSelectedRow: controller.selectedIndexRow.value > 0,
        warningText: "Sẽ không thể hoàn tác nếu đã xóa phòng thực hành",
        searchBar: _buildSearchBar(),
        onCreatedPressed: () => Get.dialog(_showCreatedDialog()),
        onEditedPressed: () {
          controller.loadDataIntoEditForm();
          Get.dialog(
            _showEditDialog(controller.selectedIndexRow.value),
          );
        },
        onDeletedPressed: () => Get.dialog(_showDeleteDialog()),
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

  GetBuilder<LabController> _buildDepartmentGetBuilder() {
    return GetBuilder<LabController>(
      builder: (controller) {
        return LoadingOverlay(
          isLoading: controller.isApiProcess,
          child: _LabDataTable(
            labs: controller.labsFiltered,
            controller: controller,
          ),
        );
      },
    );
  }

  Widget _showCreatedDialog() {
    return ConfirmDialog(
      title: "Thêm Phòng thực hành",
      content: _LabForm(
        controller: controller,
      ),
      onAcceptPressed: () => controller.handleSubmit(),
      onCancelPressed: () => Get.back(),
    );
  }

  Widget _showDeleteDialog() {
    return ConfirmDialog(
      title: "Cảnh báo",
      primaryColor: kRed,
      content: const Text(
        "Sẽ không thể hoàn tác nếu đã xóa phòng thực hành",
        style: TextStyle(
          color: kBlack,
        ),
      ),
      acceptBtnText: "xóa",
      onAcceptPressed: () {
        controller.deleteLab();
        Get.back();
      },
      onCancelPressed: () => Get.back(),
    );
  }

  Widget _showEditDialog(int id) {
    return ConfirmDialog(
      title: "Cập nhật",
      primaryColor: kGreen,
      content: _LabForm(
        controller: controller,
        primaryColor: kGreen,
        isEditedMode: true,
      ),
      acceptBtnText: "cập nhật",
      onAcceptPressed: () => controller.handleSubmit(isEdited: true),
      onCancelPressed: () => {
        Get.back(),
        controller.clearTextCtrl(),
      },
    );
  }
}
