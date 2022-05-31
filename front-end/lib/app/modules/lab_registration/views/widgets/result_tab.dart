part of lab_registration;

class _ResultTab extends StatelessWidget {
  const _ResultTab({
    Key? key,
    required this.controller,
    required this.timetableController,
  }) : super(key: key);

  final LabRegistrationController controller;
  final TimetableController timetableController;

  @override
  Widget build(BuildContext context) {
    return PaginatedDataTable(
      columns: _getColumns(controller.labelColumns),
      source: _DataTableSource(
        registration: controller.registration,
        timetableController: timetableController,
        controller: controller,
      ),
      rowsPerPage:
          DataTableService.getRowsPerPage(controller.registration.length),
      // sortColumnIndex: 0,
    );
  }

  List<DataColumn> _getColumns(List<String> columns) {
    return columns
        .map(
          (String column) => DataColumn(
            label: Text(
              column,
              style: headerTitleRobotoStyle,
            ),
          ),
        )
        .toList();
  }
}


