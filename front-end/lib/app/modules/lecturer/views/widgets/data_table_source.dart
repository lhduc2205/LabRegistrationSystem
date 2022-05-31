part of lecturer;

class _DataTableSource extends DataTableSource {
  _DataTableSource({
    required this.lecturers,
    required this.controller,
  });

  final List<LecturerModel> lecturers;
  final LecturerController controller;

  @override
  DataRow? getRow(int index) {
    final LecturerModel _data = lecturers[index];
    return DataRow(
      selected: _data.id == controller.selectedIndexRow.value,
      onSelectChanged: (value) {
        controller.onSelectedChanged(value!, _data.id!);
        notifyListeners();
      },
      cells: [
        DataCell(Text(_data.maGv.toString())),
        DataCell(Text(_data.hoTen.capitalizeFirstOfEach)),
        DataCell(Text(_data.tenBoMon!.capitalizeFirst!)),
        DataCell(Text(_data.emailGV)),
        DataCell(Text(_data.sdt)),
        DataCell(Text(DateFormat('dd-MM-yyyy').format(_data.ngaySinh))),
        DataCell(
          Text(TypeHelper.genderToString(_data.gioiTinh).capitalizeFirst!),
        ),

      ],
    );
  }

  @override
  // TODO: implement isRowCountApproximate
  bool get isRowCountApproximate => false;

  @override
  // TODO: implement rowCount
  int get rowCount => lecturers.length;

  @override
  // TODO: implement selectedRowCount
  int get selectedRowCount => 0;

}
