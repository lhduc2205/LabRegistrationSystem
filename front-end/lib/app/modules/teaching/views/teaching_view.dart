library teaching;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lab_registration_management/app/core/value/constants/app_constants.dart';
import 'package:lab_registration_management/app/core/value/helpers/app_helpers.dart';
import 'package:lab_registration_management/app/core/value/helpers/responsiveness.dart';
import 'package:lab_registration_management/app/core/value/theme/themes.dart';
import 'package:lab_registration_management/app/data/models/course_model.dart';
import 'package:lab_registration_management/app/data/models/day_model.dart';
import 'package:lab_registration_management/app/data/models/lecturer_model.dart';
import 'package:lab_registration_management/app/data/models/period_model.dart';
import 'package:lab_registration_management/app/data/models/subject_model.dart';
import 'package:lab_registration_management/app/modules/info/controllers/info_controller.dart';
import 'package:lab_registration_management/app/share_components/card_layout.dart';
import 'package:lab_registration_management/app/share_components/colored_button.dart';
import 'package:lab_registration_management/app/share_components/confirm_dialog.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lab_registration_management/app/share_components/custom_bottom_sheet.dart';
import 'package:lab_registration_management/app/share_components/default_button.dart';
import 'package:lab_registration_management/app/share_components/default_chip_widget.dart';
import 'package:lab_registration_management/app/share_components/default_dropdown.dart';
import 'package:lab_registration_management/app/share_components/default_icon_button.dart';
import 'package:lab_registration_management/app/share_components/loading_overlay.dart';
import 'package:lab_registration_management/app/share_components/search_bar.dart';

import '../controllers/teaching_controller.dart';

part './widgets/data_table_source.dart';

part './widgets/subject_dropdown.dart';

part './widgets/data_table.dart';

part './widgets/teaching_form.dart';

part './widgets/filtered_bar.dart';

part './widgets/import_button.dart';

part './widgets/teaching_card.dart';

part './widgets/period_dropdown.dart';

part './widgets/day_dropdown.dart';

part './widgets/lecturer_dropdown.dart';

class TeachingView extends GetView<TeachingController> {
  const TeachingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => LoadingOverlay(
        isLoading: controller.isApiProcess.value,
        child: Container(
          padding: const EdgeInsets.all(kSpacing),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTitle(controller.role == 'admin'),
              const SizedBox(height: kSpacing),
              _buildFilteredBar(controller.role == 'admin'),
              const SizedBox(height: kSpacing),
              _buildLectureBody(context),
            ],
          ),
        ),
      ),
    );
  }

  Row _buildTitle(bool isAdmin) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('Giảng dạy', style: headingStyle2),
        isAdmin
            ? _ImportButton(controller: controller)
            : TextButton.icon(
                onPressed: () async => controller.refreshData(),
                icon: const Icon(Icons.refresh),
                label: const Text('Refresh'),
              )
      ],
    );
  }

  Widget _buildFilteredBar(bool isAdmin) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: _FilteredBar(
              controller: controller,
            ),
          ),
        ),
        const SizedBox(width: 10),
        Obx(
          () => SizedBox(
            width: 200,
            child: SearchBar(
              hintText: 'Tìm kiếm',
              searchController: controller.searchCtrl,
              isHideCloseBtn: controller.isHideCloseBtn.value,
              onChanged: (value) => controller.onChangedSearchInput(value),
              onTapCloseBtn: controller.onTapCloseBtn,
            ),
          ),
        )
      ],
    );
  }

  GetBuilder<TeachingController> _buildLectureBody(BuildContext context) {
    return GetBuilder<TeachingController>(
      builder: (controller) {
        return Expanded(
          child: ResponsiveWidget.isSmallScreen(context)
              ? _TeachingCard(
                  teaching: controller.getFilteredTeachingList(),
                  controller: controller,
                )
              : SizedBox.expand(
                  child: _TeachingDataTable(
                    teaching: controller.getFilteredTeachingList(),
                    controller: controller,
                  ),
                ),
        );
      },
    );
  }
}
