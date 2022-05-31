part of teaching;

class _DataTableSource extends DataTableSource {
  _DataTableSource({
    required this.teaching,
    required this.controller,
  });

  final List<CourseModel> teaching;
  final TeachingController controller;

  @override
  DataRow? getRow(int index) {
    final CourseModel _data = teaching[index];
    return DataRow(
      // selected: _data.id == controller.selectedIndexRow.value,
      // onSelectChanged: (value) {
      //   controller.onSelectedChanged(value!, _data.id!);
      //   notifyListeners();
      // },
      cells: [
        DataCell(Text(controller.findSubject(_data.monHocId).maMonHoc)),
        DataCell(Text(controller.findSubject(_data.monHocId).tenMonHoc.capitalizeFirst!)),
        DataCell(Text(_data.maLopHocPhan)),
        DataCell(
          Text(
            _data.soLuongSinhVien != null
                ? _data.soLuongSinhVien.toString()
                : '',
          ),
        ),
        DataCell(
          Text(
            _data.giangVienId != null
                ? controller
                    .findLecturer(_data.giangVienId!)
                    .hoTen
                : '',
          ),
        ),
        DataCell(
          Text(
            controller.findDay(_data.thuId).tenThu.capitalizeFirstOfEach,
          ),
        ),
        DataCell(
          Text(
            controller.findSession(_data.buoiHocId).tenBuoiHoc.capitalizeFirst!,
          ),
        ),
      ],
    );
  }

  @override
  // TODO: implement isRowCountApproximate
  bool get isRowCountApproximate => false;

  @override
  // TODO: implement rowCount
  int get rowCount => teaching.length;

  @override
  // TODO: implement selectedRowCount
  int get selectedRowCount => 0;
}
