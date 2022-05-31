part of lab_registration;

class _LabRegistrationTab extends StatelessWidget {
  const _LabRegistrationTab({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final LabRegistrationController controller;

  @override
  Widget build(BuildContext context) {
    final labelColumns = [
      'Mã HP',
      'Môn học',
      'Nhóm HP',
      'Nhóm TH',
      'Số sinh viên',
      'Chọn tuần',
    ];

    return PaginatedDataTable(
      columns: _getColumns(labelColumns),
      source: _GroupDataTableSource(
        courseGroup: controller.courseGroup,
        controller: controller,
      ),
      rowsPerPage:
          DataTableService.getRowsPerPage(controller.courseGroup.length),
      // sortColumnIndex: 0,
    );
  }

  List<DataColumn> _getColumns(List<String> columns) {
    return columns
        .map(
          (String column) => DataColumn(
            label: Text(
              column,
              style: headerTitleRobotoStyle,
            ),
          ),
        )
        .toList();
  }
}

class _GroupDataTableSource extends DataTableSource {
  _GroupDataTableSource({
    required this.courseGroup,
    required this.controller,
  });

  final List<CourseGroup> courseGroup;
  final LabRegistrationController controller;

  @override
  DataRow? getRow(int index) {
    var _data = courseGroup[index];
    return DataRow(
      cells: [
        DataCell(Text(_data.maMonHoc!)),
        DataCell(Text(_data.tenMonHoc!.capitalizeFirst!)),
        DataCell(Text(_data.maLopHocPhan!.capitalizeFirst!)),
        DataCell(Text(_data.maNhom.toString())),
        DataCell(Text(_data.soLuongSinhVien.toString())),
        DataCell(
          _data.trangThai
              ? const Text('Đã đăng kí', style: TextStyle(color: kGreen))
              : Obx(
                  () => Radio(
                    value: courseGroup[index].id,
                    groupValue: controller.groupSelection.value,
                    onChanged: (value) {
                      controller.groupSelection.value = value as int;
                      final courseGroup = controller.courseGroup
                          .firstWhere((element) => element.id == value);
                      _showDialog(courseGroup);
                    },
                  ),
                ),
        ),
      ],
    );
  }

  _showDialog(CourseGroup courseGroup) {
    Get.dialog(
      Obx(
        () => ConfirmDialog(
          title: '${courseGroup.maMonHoc}\'${courseGroup.maLopHocPhan} - N${courseGroup.maNhom}',
          content: SizedBox(
            width: Get.width / 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Obx(
                  () => Visibility(
                    visible: controller.weekListSelection.isEmpty,
                    child: const Text(
                      '*Vui lòng chọn tuần thực hành',
                      style: TextStyle(
                          color: kRed,
                          fontStyle: FontStyle.italic,
                          fontSize: 13),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Wrap(
                  children: [
                    for (int i = 1; i <= 16; i++)
                      _WeekCheckBox(
                        label: 'Tuần $i',
                        isWeekSelected: controller.isWeekSelected(i),
                        onChanged: (value) => controller.setWeekSelected(i),
                      ),
                  ],
                ),
              ],
            ),
          ),
          isDisableAcceptBtn: controller.weekListSelection.isEmpty,
          onAcceptPressed: () {
            if (controller.weekListSelection.isNotEmpty) {
              controller.registerWeek().then((_) {
                controller.weekListSelection.clear();
                Get.back();
              });
            }
          },
          onCancelPressed: () {
            controller.groupSelection.value = 0;
            controller.weekListSelection.clear();
            Get.back();
          },
          acceptBtnText: 'Đăng kí',
        ),
      ),
    );
  }

  @override
  // TODO: implement isRowCountApproximate
  bool get isRowCountApproximate => false;

  @override
  // TODO: implement rowCount
  int get rowCount => courseGroup.length;

  @override
  // TODO: implement selectedRowCount
  int get selectedRowCount => 0;
}

class _WeekCheckBox extends StatelessWidget {
  const _WeekCheckBox({
    Key? key,
    required this.label,
    required this.isWeekSelected,
    required this.onChanged,
  }) : super(key: key);

  final String label;
  final bool isWeekSelected;
  final Function(bool?)? onChanged;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 120,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Checkbox(
            value: isWeekSelected,
            onChanged: onChanged,
          ),
          const SizedBox(width: 5),
          Text(label),
        ],
      ),
    );
  }
}
