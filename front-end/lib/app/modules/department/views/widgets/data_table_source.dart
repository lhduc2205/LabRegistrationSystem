part of department;

class _DataTableSource extends DataTableSource {
  _DataTableSource({
    required this.departments,
    required this.controller,
  });

  final List<DepartmentModel> departments;
  final DepartmentController controller;

  @override
  DataRow? getRow(int index) {
    final DepartmentModel _data = departments[index];
    return DataRow(
      selected: _data.id == controller.selectedIndexRow.value,
      onSelectChanged: (value) {
        controller.onSelectedChanged(value!, _data.id);
        notifyListeners();
      },
      cells: [
        DataCell(SizedBox(width: 20, child: Text((index + 1).toString()))),
        DataCell(Text(_data.tenBoMon.capitalizeFirst!)),
        DataCell(Text(_data.vietTat)),
      ],
    );
  }

  @override
  // TODO: implement isRowCountApproximate
  bool get isRowCountApproximate => false;

  @override
  // TODO: implement rowCount
  int get rowCount => departments.length;

  @override
  // TODO: implement selectedRowCount
  int get selectedRowCount => 0;
}
