part of subject;

class SubjectDatatable extends StatelessWidget {
  const SubjectDatatable({
    Key? key,
    required this.subjects,
  }) : super(key: key);

  final List<SubjectModel> subjects;

  @override
  Widget build(BuildContext context) {
    final columns = [
      'Mã môn học',
      'Tên môn học',
      'Viết tắt',
      'Số tín chỉ',
      'Phần mềm yêu cầu',
    ];
    return PaginatedDataTable(
      columns: _getColumns(columns),
      source: _DatatableSource(
        subjects: subjects,
      ),
      rowsPerPage: DataTableService.getRowsPerPage(subjects.length),
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
