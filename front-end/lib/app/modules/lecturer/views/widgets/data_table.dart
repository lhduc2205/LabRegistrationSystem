part of lecturer;

class _LecturerDataTable extends StatelessWidget {
  const _LecturerDataTable({
    Key? key,
    required this.lecturers,
    required this.controller,
  }) : super(key: key);

  final List<LecturerModel> lecturers;
  final LecturerController controller;

  @override
  Widget build(BuildContext context) {
    final columns = [
      'Mã GV',
      'Họ tên',
      'Bộ môn',
      'Email',
      'Số điện thoại',
      'Ngày sinh',
      'Giới tính',
    ];
    return PaginatedDataTable(
      columns: _getColumns(columns),
      source: _DataTableSource(
        lecturers: lecturers,
        controller: controller,
      ),
      rowsPerPage: DataTableService.getRowsPerPage(lecturers.length),
      // sortColumnIndex: 0,
    );
  }


  List<DataColumn> _getColumns(List<String> columns) {
    return columns
        .map(
          (String column) => DataColumn(
            label: _CustomTitleTable(text: column),
          ),
        )
        .toList();
  }
}
class _CustomTitleTable extends StatelessWidget {
  const _CustomTitleTable({
    Key? key,
    required this.text,
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: headerTitleRobotoStyle,
      overflow: TextOverflow.ellipsis,
    );
  }
}
