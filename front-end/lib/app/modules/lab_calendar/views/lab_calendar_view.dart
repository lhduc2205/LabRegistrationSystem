import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:lab_registration_management/app/core/value/constants/app_constants.dart';
import 'package:lab_registration_management/app/core/value/helpers/responsiveness.dart';
import 'package:lab_registration_management/app/modules/lab_calendar/controllers/lab_calendar_controller.dart';
import 'package:rolling_switch/rolling_switch.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class LabCalendarView extends GetView<LabCalendarController> {
  const LabCalendarView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(kSpacing),
        child: SfDataGrid(
          columnWidthMode: ResponsiveWidget.isLargeScreen(context)
              ? ColumnWidthMode.fill
              : ColumnWidthMode.none,
          source: controller.employeeDataSource,
          frozenColumnsCount: 1,
          headerRowHeight: 80,

          // onQueryRowHeight: (details) {
          //   return details.getIntrinsicRowHeight(details.rowIndex);
          // },
          columns: _buildColumns(),
        ),
      ),
    );
  }

  TextStyle get _customDayStyle {
    return TextStyle(
        color: kFontColorPallets[0],
        fontSize: 16,
        fontWeight: FontWeight.bold,
        overflow: TextOverflow.ellipsis);
  }

  List<GridColumn> _buildColumns() {
    return controller.headerTable.asMap().entries.map((entry) {
      int idx = entry.key;
      String val = entry.value;
      String name = "Thứ ${idx + 1}";
      if (idx == 0) {
        name = "Phòng";
      }
      if (idx == controller.headerTable.length - 1) {
        name = "Chủ nhật";
      }
      return GridColumn(
        columnName: idx.toString(),
        label: Container(
          width: 200,
          padding: const EdgeInsets.all(16.0),
          alignment: Alignment.center,
          child: Text(
            name,
            style: _customDayStyle,
          ),
        ),
      );
    }).toList();
  }
}
