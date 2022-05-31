part of lab;

class _LabDataTable extends StatelessWidget {
  const _LabDataTable({
    Key? key,
    required this.labs,
    required this.controller,
  }) : super(key: key);

  final List<LabModel> labs;
  final LabController controller;

  @override
  Widget build(BuildContext context) {
    final columns = [
      // '',
      // 'Tên phòng',
      'Bộ môn',
      'Số máy',
      'Phần mềm',
      'RAM',
      'Ổ cứng',
      'CPU',
      'GPU',
    ];
    return PaginatedDataTable(
      columns: _getColumns(columns),
      source: _DataTableSource(
        labs: labs,
        controller: controller,
      ),
      rowsPerPage: DataTableService.getRowsPerPage(labs.length),
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
