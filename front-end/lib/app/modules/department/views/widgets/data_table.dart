part of department;

class _DepartmentDataTable extends StatelessWidget {
  const _DepartmentDataTable({
    Key? key,
    required this.departments,
    required this.controller,
  }) : super(key: key);

  final List<DepartmentModel> departments;
  final DepartmentController controller;

  @override
  Widget build(BuildContext context) {
    final columns = ['#', 'Tên Bộ môn', 'Tên viết tắt'];
    return PaginatedDataTable(
      columns: _getColumns(columns),
      source: _DataTableSource(
        departments: departments,
        controller: controller,
      ),
      rowsPerPage: DataTableService.getRowsPerPage(departments.length),
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
