part of my_timetable;

class _DataTableSource extends DataTableSource {
  _DataTableSource({required this.timetableList});

  final List<TimetableModel> timetableList;

  @override
  DataRow? getRow(int index) {
    TimetableModel timetable = timetableList[index];
    var controller = Get.find<MyTimetableController>();

    return DataRow(
      // selected: _data.id == controller.selectedIndexRow.value,
      // onSelectChanged: (value) {
      //   controller.onSelectedChanged(value!, _data.id!);
      //   notifyListeners();
      // },
      cells: [
        DataCell(Text(controller.findSubject(timetable.monHocId).maMonHoc)),
        DataCell(Text(controller.findSubject(timetable.monHocId).tenMonHoc.capitalizeFirst!)),
        DataCell(Text(timetable.maLopHocPhan)),
        DataCell(Text(timetable.maNhom.toString())),
        DataCell(Text(controller.findWeek(timetable.tuanId).tenTuan.capitalizeFirst!)),
        DataCell(Text(controller.findDay(timetable.thuId).tenThu.capitalizeFirst!)),
        DataCell(Text(controller.findPeriod(timetable.buoiHocId).tenBuoiHoc.capitalizeFirst!)),
        DataCell(Text(controller.findLab(timetable.phongId).tenPhong)),
      ],

    );
  }

  @override
  // TODO: implement isRowCountApproximate
  bool get isRowCountApproximate => false;

  @override
  // TODO: implement rowCount
  int get rowCount => timetableList.length;

  @override
  // TODO: implement selectedRowCount
  int get selectedRowCount => 0;
}
