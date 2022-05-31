library lab_registration;

import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lab_registration_management/app/core/value/constants/app_constants.dart';
import 'package:lab_registration_management/app/core/value/helpers/responsiveness.dart';
import 'package:lab_registration_management/app/core/value/theme/themes.dart';
import 'package:lab_registration_management/app/core/value/utils/ultils.dart';
import 'package:lab_registration_management/app/data/models/course_group_model.dart';
import 'package:lab_registration_management/app/data/models/course_model.dart';
import 'package:lab_registration_management/app/data/models/registration_model.dart';
import 'package:lab_registration_management/app/data/models/timetable_registration_model.dart';
import 'package:lab_registration_management/app/data/services/data_table_service.dart';
import 'package:lab_registration_management/app/modules/info/controllers/info_controller.dart';
import 'package:lab_registration_management/app/modules/root/controllers/navigation_controller.dart';
import 'package:lab_registration_management/app/modules/root/controllers/side_bar_controller.dart';
import 'package:lab_registration_management/app/modules/timetable/controllers/timetable_controller.dart';
import 'package:lab_registration_management/app/modules/timetable_clone/controllers/timetable_clone_controller.dart';
import 'package:lab_registration_management/app/routes/routes.dart';
import 'package:lab_registration_management/app/share_components/colored_button.dart';
import 'package:lab_registration_management/app/share_components/confirm_dialog.dart';
import 'package:lab_registration_management/app/share_components/custom_back_button.dart';
import 'package:lab_registration_management/app/share_components/loading_overlay.dart';
import 'package:lab_registration_management/app/share_components/search_bar.dart';
import 'package:lottie/lottie.dart';
import '../../../share_components/schedule_table/schedule_table.dart';

import '../controllers/lab_registration_controller.dart';

part 'widgets/lab_registration_tab_by_excel.dart';

part 'widgets/tab_bar_label.dart';

part 'widgets/result_tab.dart';

part 'widgets/import_button.dart';

part 'user_view.dart';

part 'admin_view.dart';

part 'widgets/scheduling_button.dart';

part 'widgets/data_table_source.dart';

part 'widgets/lab_registration_tab.dart';

class LabRegistrationView extends StatelessWidget {
  const LabRegistrationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LabRegistrationController());
    final timetableController = Get.find<TimetableController>();

    return Obx(
      () => LoadingOverlay(
        isLoading: controller.isLoading.value,
        child: Container(
          padding: const EdgeInsets.all(kSpacing),
          child: controller.role == 'admin'
              ? _AdminView(
                  controller: controller,
                  timetableController: timetableController,
                )
              : _UserView(
                  controller: controller,
                  timetableController: timetableController,
                ),
        ),
      ),
    );
  }
}

class _CustomCard extends StatelessWidget {
  const _CustomCard({
    Key? key,
    required this.header,
    required this.body,
  }) : super(key: key);

  final Widget header;
  final Widget body;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: kGrey,
        ),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Column(
        children: [
          Column(
            children: [
              header,
              const Divider(
                height: 0,
                thickness: 0.25,
              ),
            ],
          ),
          Flexible(child: body),
        ],
      ),
    );
  }
}

class _Title extends StatelessWidget {
  const _Title({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(title, style: headingStyle2);
  }
}
