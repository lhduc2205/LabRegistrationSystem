part of my_timetable;

class _ScheduleDatatable extends StatelessWidget {
  const _ScheduleDatatable({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MyTimetableController>(
      builder: (controller) => PaginatedDataTable(
        columns: controller.columns.asMap().entries.map((entries) {
          // if (entries.key == controller.currentSortColumn) {
          //   return DataColumn(
          //     label: Text(
          //       entries.value,
          //       style: headerTitleRobotoStyle,
          //     ),
          //     onSort: (columnIndex, _) => controller.onSort(columnIndex),
          //   );
          // }
          // return DataColumn(
          //   label: Text(
          //     entries.value,
          //     style: headerTitleRobotoStyle,
          //   ),
          // );
          return DataColumn(
            label: Text(
              entries.value,
              style: headerTitleRobotoStyle,
            ),
            onSort: (columnIndex, _) => controller.onSort(columnIndex, entries.value),
          );
        }).toList(),
        source: _DataTableSource(
            timetableList: controller.timetableTableModeFiltered),
        rowsPerPage:
            DataTableService.getRowsPerPage(controller.timetable.length),
        sortColumnIndex: controller.currentSortColumn,
        sortAscending: controller.isAscending,
      ),
    );
  }
}
