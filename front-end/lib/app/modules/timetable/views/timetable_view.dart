library timetable;

import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

import 'package:get/get.dart';
import 'package:lab_registration_management/app/core/value/helpers/app_helpers.dart';
import 'package:lab_registration_management/app/data/models/lecturer_model.dart';
import 'package:lab_registration_management/app/data/models/period_model.dart';
import 'package:lab_registration_management/app/core/value/constants/app_constants.dart';
import 'package:lab_registration_management/app/core/value/theme/themes.dart';
import 'package:lab_registration_management/app/data/models/week_model.dart';
import 'package:lab_registration_management/app/modules/root/controllers/navigation_controller.dart';
import 'package:lab_registration_management/app/modules/root/controllers/side_bar_controller.dart';
import 'package:lab_registration_management/app/modules/timetable_clone/controllers/timetable_clone_controller.dart';
import 'package:lab_registration_management/app/routes/routes.dart';
import 'package:lab_registration_management/app/share_components/loading_overlay.dart';
import 'package:lab_registration_management/app/share_components/roundedDropdown.dart';
import 'package:lab_registration_management/app/share_components/schedule_table/schedule_table_layout.dart';
import '../../../share_components/schedule_table/schedule_table.dart';

import '../controllers/timetable_controller.dart';

part 'widgets/week_dropdown.dart';

part 'widgets/period_dropdown.dart';

part 'widgets/filtered_bar.dart';

part 'widgets/lecturer_dropdown.dart';

part 'widgets/normal_mode_layout.dart';

part 'widgets/edited_mode_layout.dart';

part 'widgets/title.dart';

part 'widgets/schedule_waiting_bar.dart';

class TimeTableView extends StatelessWidget {
  const TimeTableView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _navigationController = Get.find<NavigationController>();
    var _sideBarController = Get.find<SideBarController>();
    var controller = Get.put(TimetableController());

    return Obx(
      () => Scaffold(
        backgroundColor:
            controller.isEditedMode.value ? kScaffoldColor : kWhite,
        body: Container(
          padding: const EdgeInsets.all(kSpacing),
          child: LoadingOverlay(
            isLoading: controller.isLoading.value,
            child: controller.isEditedMode.value
                ? _EditedModeLayout(
                    timetableController: controller,
                    scheduleTable: _buildScheduleTable(
                      controller,
                      controller.isEditedMode.value,
                    ),
                  )
                : _NormalModeLayout(
                    isAdmin: controller.role == 'admin',
                    navigationController: _navigationController,
                    sideBarController: _sideBarController,
                    timetableController: controller,
                    scheduleTable: _buildScheduleTable(
                      controller,
                      controller.isEditedMode.value,
                    ),
                  ),
          ),
        ),
      ),
    );
  }

  ScheduleTableLayout _buildScheduleTable(
      TimetableController controller, bool isEditedMode) {
    return ScheduleTableLayout(
      color: isEditedMode ? kWhite : Colors.transparent,
      tabController: controller.tabController,
      tabs: controller.curSemestersList
          .map((semester) => Text('T${semester.tuanId}'))
          .toList(),
      onTap: (index) {
        controller.getTimetableByWeekAndPeriod(
            index + 1, controller.periodSelection.value);
        controller.setRegistrationFiltered();
      },
      semesters: controller.curSemestersList,
      scheduleTable: Obx(
        () => ScheduleTable(
          timetableList: controller.timetableFiltered,
          startDate: controller.startDate.value,
          week: controller.weekSelection.value,
          isClone: false,
          isEditedMode: isEditedMode,
          labErr: controller.labErr,
        ),
      ),
    );
  }
}
