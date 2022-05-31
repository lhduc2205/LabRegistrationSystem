part of lab_registration;

class _DataTableSource extends DataTableSource {
  _DataTableSource({
    required this.registration,
    required this.controller,
    required this.timetableController,
  });

  final List<RegistrationModel> registration;
  final LabRegistrationController controller;
  final TimetableController timetableController;

  @override
  DataRow? getRow(int index) {
    List<int> tuanDK = [];
    List<int> tuanDaXep = [];
    var _data = registration[index];
    var course = controller.findCourse(_data.lopHocPhanId);
    tuanDK.addAll(_data.daXep);
    tuanDK.addAll(_data.chuaXep);
    final timetable = timetableController.findTimetableByGroup(_data.nhomThId);
    timetable.map((e) => tuanDaXep.add(e.tuanId)).toList();

    return DataRow(
      cells: [
        DataCell(Text(_data.maMonHoc!)),
        DataCell(Text(_data.tenMonHoc!.capitalizeFirst!)),
        DataCell(Text(course.maLopHocPhan.capitalizeFirst!)),
        DataCell(Text(_data.maNhom.toString())),
        DataCell(Text(_data.soLuongSinhVien.toString())),
        DataCell(_buildTuanTH(tuanDK)),
        DataCell(_buildTuanTH(tuanDaXep)),
        DataCell(_buildTuanTH(_data.chuaXep)),
      ],
    );
  }

  Widget _buildTuanTH(List tuanTH) {
    tuanTH.sort();
    return Row(
      children: tuanTH.map(
            (tuan) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 3),
            child: Text(tuan.toString()),
          );
        },
      ).toList(),
    );
  }

  @override
  // TODO: implement isRowCountApproximate
  bool get isRowCountApproximate => false;

  @override
  // TODO: implement rowCount
  int get rowCount => registration.length;

  @override
  // TODO: implement selectedRowCount
  int get selectedRowCount => 0;
}