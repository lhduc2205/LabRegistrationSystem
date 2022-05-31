library timetable_clone;

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:lab_registration_management/app/core/value/constants/app_constants.dart';
import 'package:lab_registration_management/app/core/value/theme/themes.dart';
import 'package:lab_registration_management/app/modules/root/controllers/navigation_controller.dart';
import 'package:lab_registration_management/app/routes/routes.dart';
import 'package:lab_registration_management/app/share_components/custom_back_button.dart';
import 'package:lab_registration_management/app/share_components/default_icon_button.dart';
import 'package:lab_registration_management/app/share_components/dropdowns/period_dropdown.dart';
import 'package:lab_registration_management/app/share_components/loading_overlay.dart';
import 'package:lab_registration_management/app/share_components/schedule_table/schedule_table_layout.dart';
import '../../../share_components/schedule_table/schedule_table.dart';

import '../controllers/timetable_clone_controller.dart';


class TimetableCloneView extends StatelessWidget {
  const TimetableCloneView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(TimetableCloneController());

    return Scaffold(
      backgroundColor: kWhite,
      body: Obx(
        () => LoadingOverlay(
          isLoading: controller.isLoading.value,
          child: Container(
            padding: const EdgeInsets.all(kSpacing),
            child: Column(
              children: [
                _buildTitleRow(context, controller),
                const SizedBox(height: kSpacing),
                _buildSaveButton(controller),
                const SizedBox(height: kSpacing),
                Expanded(
                  child: _buildScheduleTable(controller),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  ScheduleTableLayout _buildScheduleTable(TimetableCloneController controller) {
    return ScheduleTableLayout(
      tabController: controller.tabController,
      tabs: controller.curSemestersList
          .map((semester) => Text('T${semester.tuanId}'))
          .toList(),
      onTap: (index) {
        controller.getTimetableByWeekAndPeriod(
            index + 1, controller.periodSelection.value);
      },
      semesters: controller.curSemestersList,
      scheduleTable: Obx(
        () => ScheduleTable(
          timetableList: controller.timetableCloneFiltered,
          startDate: controller.startDate.value,
          week: controller.weekSelection.value,
          isEditedMode: true,
          labErr: controller.labErr,
        ),
      ),
    );
  }

  Row _buildSaveButton(TimetableCloneController controller) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Obx(
          () => PeriodDropdown(
            periodsList: controller.periodsList,
            onChanged: (id) => controller.setPeriodSelection(id),
            value: controller.periodSelection.value.toString(),
          ),
        ),
        ElevatedButton.icon(
          icon: const Icon(Icons.save),
          label: const Text('Lưu thay đổi'),
          style: defaultButtonStyle(),
          onPressed: () => controller.saveClone(),
        )
      ],
    );
  }

  Row _buildTitleRow(
      BuildContext context, TimetableCloneController controller) {
    var _navigationController = NavigationController.instance;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomBackButton(
          onPressed: () {
            Get.delete<TimetableCloneController>();
            _navigationController.navigateTo(
              labRegistrationPageRoute,
            );
          },
          text: 'Sắp xếp lại',
        ),
        DefaultIconButton(
          icon: Icons.refresh,
          onPressed: () => controller.fetchTimetableClone(),
        )
      ],
    );
  }
}
