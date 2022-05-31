library info;

import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:lab_registration_management/app/core/value/constants/app_constants.dart';
import 'package:lab_registration_management/app/core/value/helpers/app_helpers.dart';
import 'package:lab_registration_management/app/core/value/theme/themes.dart';
import 'package:lab_registration_management/app/data/models/lecturer_model.dart';
import 'package:lab_registration_management/app/modules/department/controllers/department_controller.dart';
import 'package:lab_registration_management/app/share_components/custom_circular_progress_indicator.dart';
import 'package:lab_registration_management/app/share_components/loading_overlay.dart';

import '../controllers/info_controller.dart';

part 'widgets/lecturer_info.dart';

class InfoView extends StatelessWidget {
  const InfoView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(InfoController());
    final _lecturerInfo = controller.lecturerInfo;

    return Obx(
      () => LoadingOverlay(
        isLoading: controller.isLoading.value,
        child: Container(
          padding: const EdgeInsets.all(kSpacing),
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    'Hồ sơ',
                    style: headingStyle2,
                  )
                ],
              ),
              const SizedBox(height: 10),
              _lecturerInfo.isNotEmpty
                  ? _LecturerInfo(
                      lecturer: _lecturerInfo[0],
                    )
                  : const CustomCircularProgessIndicator(),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
