library my_timetable;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

import 'package:get/get.dart';
import 'package:lab_registration_management/app/core/value/constants/app_constants.dart';
import 'package:lab_registration_management/app/core/value/theme/themes.dart';
import 'package:lab_registration_management/app/data/models/lab_model.dart';
import 'package:lab_registration_management/app/data/models/period_model.dart';
import 'package:lab_registration_management/app/data/models/timetable_model.dart';
import 'package:lab_registration_management/app/data/services/data_table_service.dart';
import 'package:lab_registration_management/app/modules/lab/controllers/lab_controller.dart';
import 'package:lab_registration_management/app/modules/root/controllers/navigation_controller.dart';
import 'package:lab_registration_management/app/modules/timetable/controllers/timetable_controller.dart';
import 'package:lab_registration_management/app/routes/routes.dart';
import 'package:lab_registration_management/app/share_components/roundedDropdown.dart';
import 'package:lab_registration_management/app/share_components/schedule_table/custom_toggle_button.dart';
import 'package:lab_registration_management/app/share_components/schedule_table/schedule_table.dart';
import 'package:lab_registration_management/app/share_components/schedule_table/schedule_table_layout.dart';
import 'package:lab_registration_management/app/share_components/search_bar.dart';

import '../controllers/my_timetable_controller.dart';

part 'widgets/period_dropdown.dart';
part 'widgets/filtered_bar.dart';
part 'widgets/schedule_layout.dart';
part 'widgets/datatable_source.dart';
part 'widgets/schedule_datatable.dart';

class MyTimetableView extends StatelessWidget {
  const MyTimetableView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var navigationController = Get.find<NavigationController>();
    var controller = Get.put(MyTimetableController());
    // var info = Get.put(InfoController()).lecturerInfo;

    return Container(
      padding: const EdgeInsets.all(kSpacing),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextButton(
            onPressed: () {
              navigationController.navigateTo(timeTablePageRoute);
              Get.delete<MyTimetableController>();
            },
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Icon(Icons.keyboard_backspace),
                SizedBox(width: 5),
                Text('Lịch chung'),
              ],
            ),
          ),
          const SizedBox(height: kSpacing),
          _FilteredBar(controller: controller),
          const SizedBox(height: 10),
          Expanded(
            child: Obx(
              () => _ScheduleLayout(
                controller: controller,
                isScheduleMode: controller.toggleSelection[0],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

