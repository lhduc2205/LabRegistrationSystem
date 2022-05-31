import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:lab_registration_management/app/core/value/constants/app_constants.dart';
import 'package:lab_registration_management/app/core/value/helpers/app_helpers.dart';
import 'package:lab_registration_management/app/core/value/theme/themes.dart';
import 'package:lab_registration_management/app/data/models/day_model.dart';
import 'package:lab_registration_management/app/data/models/lab_model.dart';
import 'package:lab_registration_management/app/data/models/scheduling_response.dart';
import 'package:lab_registration_management/app/data/models/timetable_model.dart';
import 'package:lab_registration_management/app/modules/lab/controllers/lab_controller.dart';
import 'package:lab_registration_management/app/modules/lecturer/controllers/lecturer_controller.dart';
import 'package:lab_registration_management/app/modules/root/controllers/day_controller.dart';
import 'package:lab_registration_management/app/modules/root/controllers/schedule_table_controller.dart';
import 'package:lab_registration_management/app/modules/subject/controllers/subject_controller.dart';
import 'package:lab_registration_management/app/modules/timetable/controllers/timetable_controller.dart';
import 'package:lab_registration_management/app/modules/timetable_clone/controllers/timetable_clone_controller.dart';
import 'package:lab_registration_management/app/share_components/confirm_dialog.dart';
import 'package:lab_registration_management/app/share_components/default_icon_button.dart';
import 'package:lab_registration_management/app/share_components/dropdowns/day_dropdown.dart';
import 'package:lab_registration_management/app/share_components/dropdowns/lab_dropdown.dart';
import 'package:lab_registration_management/app/share_components/dropdowns/period_dropdown.dart';
import 'package:lab_registration_management/app/share_components/dropdowns/week_dropdown.dart';
import 'package:lab_registration_management/app/share_components/loading_overlay.dart';

class ScheduleTable extends StatelessWidget {
  const ScheduleTable({
    Key? key,
    required this.timetableList,
    required this.startDate,
    required this.week,
    required this.labErr,
    this.isClone = true,
    this.isEditedMode = false,
    this.conflict,
  }) : super(key: key);

  final RxList<TimetableModel> timetableList;
  final DateTime startDate;
  final int week;
  final RxList labErr;
  final bool isClone;
  final bool isEditedMode;
  final List<Conflict>? conflict;

  @override
  Widget build(BuildContext context) {
    var _daysList = Get.find<DayController>().daysList;
    _daysList = _daysList.where((day) => day.id != 0).toList();
    var _labsList = Get.find<LabController>().labsList;
    var controller = Get.put(ScheduleTableController());
    // print(timetableList.length);

    return Obx(
      () => LoadingOverlay(
        isLoading: controller.isLoading.value,
        child: Column(
          children: [
            _buildHeaderRow(_daysList, startDate),
            Column(
              children: _labsList
                  .map(
                    (lab) => Row(
                      children: [
                        _ContentCell(
                          child: _LabLabel(
                            text: lab.tenPhong,
                          ),
                        ),
                        Row(
                          children: _daysList.map(
                            (day) {
                              return _buildContentCell(context, lab, day);
                            },
                          ).toList(),
                        ),
                      ],
                    ),
                  )
                  .toList(),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildContentCell(BuildContext context, LabModel lab, DayModel day) {
    TimetableController? timetableController;
    TimetableCloneController? timetableCloneController;

    String? text = getText(lab.id, day.id);
    isClone
        ? timetableCloneController = Get.find<TimetableCloneController>()
        : timetableController = Get.find<TimetableController>();

    CellData data = CellData(lab.id, day.id, null);

    if (text == null) {
      return DragTarget(
        onAccept: (CellData data) {
          if (isClone) {
            timetableCloneController!.getSourceCell(data);
            timetableCloneController.changeTimetable();
            _showDialog();
          } else {
            timetableController!.getSourceCell(data);
            timetableController.changeTimetable();
            _showDialog();
          }
        },
        builder: (context, _, __) {
          if (isClone) {
            timetableCloneController!.getDesCell(data);
          } else {
            timetableController!.getDesCell(data);
          }
          return _ContentCell(
            color: Colors.transparent,
            child: Container(),
          );
        },
      );
    } else {
      return isEditedMode
          ? Stack(
              children: [
                Draggable(
                  data: data,
                  childWhenDragging: const _ContentCell(
                    child: Text(''),
                  ),
                  feedback: _ContentCell(
                    color: kPrimary,
                    child: _CustomText(
                      text: text,
                      color: kWhite,
                    ),
                  ),
                  child: _ContentCell(
                    child: _CustomText(text: text),
                  ),
                ),
                Visibility(
                  visible: !isClone,
                  child: Positioned(
                    bottom: 0,
                    right: 0,
                    child: Material(
                      color: Colors.transparent,
                      child: DefaultIconButton(
                        splashRadius: 15,
                        size: 20,
                        onPressed: () {
                          Get.dialog(_showScheduleChangedRequestDialog(
                              lab.id, day.id));
                        },
                        icon: Icons.edit,
                      ),
                    ),
                  ),
                ),
              ],
            )
          : _ContentCell(
              child: _CustomText(text: text),
            );
    }
  }

  getText(labID, dayID) {
    String text = '';
    TimetableModel? timetable = timetableList.value.firstWhereOrNull(
      (timetable) => timetable.phongId == labID && timetable.thuId == dayID,
    );
    if (timetable != null) {
      var _subjects =
          Get.find<SubjectController>().findSubject(timetable.monHocId);
      var _lecturers =
          Get.find<LecturerController>().findLecturer(timetable.giangVienId);
      var name = StringHelper.toAbbreviation(
        _lecturers.hoTen.capitalizeFirstOfEach,
        _lecturers.gioiTinh,
      );

      text += '${_subjects.maMonHoc} - ${_subjects.vietTat}'
          '\n$name'
          '\n(N${timetable.maLopHocPhan} - 0${timetable.maNhom.toString()})';

      return text;
    }
  }

  TimetableModel? getTimetable(int labID, int dayID) {
    TimetableModel? timetable = timetableList.value.firstWhereOrNull(
      (timetable) => timetable.phongId == labID && timetable.thuId == dayID,
    );
    return timetable;
  }

  Row _buildHeaderRow(List<DayModel> daysList, var startDay) {
    return Row(
      children: [
        _HeaderCell(
          child: Text(
            'Phòng',
            style: _headerStyle,
          ),
        ),
        for (int i = 0; i < daysList.length; i++)
          _HeaderCell(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  i < daysList.length - 1
                      ? ('thứ ' + daysList[i].tenThu).capitalizeFirst!
                      : daysList[i].tenThu.capitalizeFirst!,
                  style: _headerStyle,
                ),
                Text(
                  getDayinWeek(startDay, i),
                  style: _subHeaderStyle,
                )
              ],
            ),
          )
      ],
    );
  }

  String getDayinWeek(DateTime startDate, int day) {
    return DateFormat('dd/MM/yyyy')
        .format(startDate.add(Duration(days: day)))
        .toString();
  }

  _showDialog() {
    Get.defaultDialog(
      title: '',
      content: Container(
        color: kWhite,
        child: Column(
          children: [
            Obx(
              () => Image.asset(
                labErr.value.isEmpty
                    ? ImageRasterPath.reScheduleSuccessful
                    : ImageRasterPath.noData,
                width: 300,
              ),
            ),
            Obx(
              () => Column(
                children: labErr.isEmpty
                    ? [
                        const _CustomErrTile(
                          text: 'Đáp ứng đủ số lượng máy',
                          icon: Icons.check,
                          iconColor: kGreen,
                        ),
                        const _CustomErrTile(
                          text: 'Đáp ứng đủ phần mềm yêu cầu',
                          icon: Icons.check,
                          iconColor: kGreen,
                        ),
                      ]
                    : labErr.value
                        .map(
                          (e) => Column(
                            children: [
                              _CustomErrTile(text: e),
                            ],
                          ),
                        )
                        .toList(),
              ),
            ),
            const SizedBox(
              height: kSpacing,
            ),
            Obx(
              () => Text(
                labErr.value.isEmpty ? 'Đổi lịch thành công' : 'Oops!!!',
                style: GoogleFonts.lato(
                  textStyle: TextStyle(
                    color: labErr.value.isEmpty ? kPrimary : kRed,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _showScheduleChangedRequestDialog(labID, dayID) {
    TimetableModel timetable = timetableList.value.firstWhere(
      (timetable) => timetable.phongId == labID && timetable.thuId == dayID,
    );
    var controller = Get.find<ScheduleTableController>();

    controller.setValueSelection(
        value: timetable.tuanId.toString(), name: 'week');
    controller.setValueSelection(
        value: timetable.thuId.toString(), name: 'day');
    controller.setValueSelection(
        value: timetable.phongId.toString(), name: 'lab');
    controller.setValueSelection(
        value: timetable.buoiHocId.toString(), name: 'period');

    return Obx(
      () => ConfirmDialog(
        title:
            "Thay đổi lịch ${timetable.maMonHoc!}'${timetable.maLopHocPhan} - N${timetable.maNhom}",
        content: Container(
          width: Get.width / 4,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 40,
                child: LoadingOverlay(
                  child: _buildTextNotification(controller),
                  isLoading: controller.isFetchNotif.value,
                ),
              ),
              const SizedBox(height: 10),
              ListTile(
                leading: const Text('Chọn tuần'),
                trailing: Obx(
                  () => WeekDropdown(
                    weekList: controller.getWeekList(),
                    onChanged: (value) => controller.onChangedDropdown(
                      timetable,
                      value: value!,
                      name: 'week',
                    ),
                    value: controller.weekSelection.value.toString(),
                  ),
                ),
              ),
              ListTile(
                leading: const Text('Chọn thứ'),
                trailing: Obx(
                  () => DayDropdown(
                    dayList: controller.getDayList(),
                    onChanged: (value) => controller.onChangedDropdown(
                      timetable,
                      value: value!,
                      name: 'day',
                    ),
                    value: controller.daySelection.value.toString(),
                  ),
                ),
              ),
              ListTile(
                leading: const Text('Chọn phòng'),
                trailing: Obx(
                  () => LabDropdown(
                    labList: controller.getLabList(),
                    onChanged: (value) => controller.onChangedDropdown(
                      timetable,
                      value: value!,
                      name: 'lab',
                    ),
                    value: controller.labSelection.value.toString(),
                  ),
                ),
              ),
              ListTile(
                leading: const Text('Chọn buổi'),
                trailing: Obx(
                  () => PeriodDropdown(
                    periodsList: controller.getPeriodList(),
                    onChanged: (value) => controller.onChangedDropdown(
                      timetable,
                      value: value!,
                      name: 'period',
                    ),
                    value: controller.periodSelection.value.toString(),
                  ),
                ),
              ),
            ],
          ),
        ),
        isDisableAcceptBtn: controller.isDisableAcceptBtn.value,
        acceptBtnText: 'thay đổi',
        onAcceptPressed: () => controller.updateTimetable(timetable),
        onCancelPressed: () {
          controller.resetValue();
          Get.back();
        },
      ),
    );
  }

  Widget _buildTextNotification(ScheduleTableController controller) {
    if (controller.isLabUnoccupied.value) {
      if (controller.notifications.isEmpty) {
        return Text('Phòng phù họp', style: successStyle);
      } else {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: controller.notifications
              .map((notif) => Text('*$notif', style: errorStyle))
              .toList(),
        );
      }
    } else {
      return Text(
        '*Phòng này đã được xếp lịch!',
        style: errorStyle,
      );
    }
  }
}

class _HeaderCell extends StatelessWidget {
  const _HeaderCell({Key? key, required this.child, this.width})
      : super(key: key);

  final Widget child;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? 150,
      height: 60,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
      decoration: BoxDecoration(
        // color: Colors.blue.withOpacity(0.03),
        border: Border.all(color: Colors.black, width: 0.1),
      ),
      child: Center(child: child),
    );
  }
}

class _ContentCell extends StatelessWidget {
  const _ContentCell({Key? key, required this.child, this.width, this.color})
      : super(key: key);

  final Widget child;
  final double? width;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? 150,
      height: 75,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
      decoration: BoxDecoration(
        color: color ?? Colors.transparent,
        border: Border.all(color: Colors.black, width: 0.1),
      ),
      child: Center(child: child),
    );
  }
}

class _LabLabel extends StatelessWidget {
  const _LabLabel({Key? key, required this.text}) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.lato(
        textStyle: const TextStyle(
          color: kRed,
        ),
      ),
    );
  }
}

class _CustomText extends StatelessWidget {
  const _CustomText({Key? key, required this.text, this.color})
      : super(key: key);

  final String text;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(
        color: color ?? kBlack,
        fontSize: 14,
      ),
    );
  }
}

class _CustomErrTile extends StatelessWidget {
  const _CustomErrTile({
    Key? key,
    required this.text,
    this.icon,
    this.iconColor,
    this.crossAxisAlignment,
  }) : super(key: key);

  final String text;
  final IconData? icon;
  final Color? iconColor;
  final CrossAxisAlignment? crossAxisAlignment;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          icon ?? Icons.close,
          color: iconColor ?? kRed,
          size: 13,
        ),
        const SizedBox(width: 5),
        Text(
          text,
          style: const TextStyle(color: kBlack),
        ),
      ],
    );
  }
}

TextStyle get _headerStyle {
  return GoogleFonts.droidSerif(
    textStyle: const TextStyle(
      color: kBlack,
      fontSize: 14,
      fontWeight: FontWeight.w600,
    ),
  );
}

TextStyle get _subHeaderStyle {
  return GoogleFonts.droidSerif(
    textStyle: const TextStyle(
      color: kPrimary,
      fontSize: 14,
    ),
  );
}
