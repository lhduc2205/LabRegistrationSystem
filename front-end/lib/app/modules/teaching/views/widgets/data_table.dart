part of teaching;

class _TeachingDataTable extends StatelessWidget {
  const _TeachingDataTable({
    Key? key,
    required this.teaching,
    required this.controller,
  }) : super(key: key);

  final List<CourseModel> teaching;
  final TeachingController controller;

  @override
  Widget build(BuildContext context) {
    final columns = [
      'Mã môn học',
      'Tên môn học',
      'Nhóm HP',
      'Số lượng',
      'Giảng viên dạy',
      'Thứ',
      'Buổi học',
    ];
    return PaginatedDataTable(
      columns: _getColumns(columns),
      source: _DataTableSource(
        teaching: teaching,
        controller: controller,
      ),
      rowsPerPage: teaching.isEmpty
          ? 1
          : teaching.length > 6
              ? 6
              : teaching.length,
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
