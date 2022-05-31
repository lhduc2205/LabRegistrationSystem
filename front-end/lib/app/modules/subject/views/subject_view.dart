library subject;
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:lab_registration_management/app/core/value/helpers/app_helpers.dart';
import 'package:lab_registration_management/app/core/value/theme/themes.dart';
import 'package:lab_registration_management/app/data/models/subject_model.dart';
import 'package:lab_registration_management/app/data/services/data_table_service.dart';
import 'package:lab_registration_management/app/modules/software/controllers/software_controller.dart';
import 'package:lab_registration_management/app/share_components/content_layout.dart';
import 'package:lab_registration_management/app/share_components/custom_chip_widget.dart';
import 'package:lab_registration_management/app/share_components/loading_overlay.dart';
import 'package:lab_registration_management/app/share_components/search_bar.dart';

import '../controllers/subject_controller.dart';

part 'widgets/subject_datatable.dart';
part 'widgets/datatable_source.dart';

class SubjectView extends GetView<SubjectController> {
  const SubjectView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => LoadingOverlay(
        isLoading: controller.isLoading.value,
        child: ContentLayout(
          child: _buildSubjectDatatable(),
          onRefresh: () async {},
          title: 'Môn học',
          isSelectedRow: false,
          warningText: "Sẽ không thể hoàn tác nếu đã xóa môn học",
          searchBar: _buildSearchBar(),
          onCreatedPressed: () {},
          onEditedPressed: () {
          },
          onDeletedPressed: () {},
        ),
      ),
    );
  }

  SubjectDatatable _buildSubjectDatatable() {
    return SubjectDatatable(
      subjects: controller.subjectFiltered.value,
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
}
