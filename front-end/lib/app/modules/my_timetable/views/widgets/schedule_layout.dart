part of my_timetable;

class _ScheduleLayout extends StatelessWidget {
  const _ScheduleLayout({
    Key? key,
    required this.isScheduleMode,
    required this.controller,
  }) : super(key: key);

  final bool isScheduleMode;
  final MyTimetableController controller;

  @override
  Widget build(BuildContext context) {
    return isScheduleMode
        ? _buildScheduleTable()
        : _buildScheduleWithTableMode();
  }

  Widget _buildScheduleWithTableMode() {
    return const SizedBox.expand(
      child: _ScheduleDatatable(),
    );
  }

  ScheduleTableLayout _buildScheduleTable() {
    return ScheduleTableLayout(
      tabController: controller.tabController2,
      tabs: controller.curSemestersList
          .map((semester) => Text('T${semester.tuanId}'))
          .toList(),
      onTap: (index) {
        controller.getTimetableByWeekAndPeriod(
          index + 1,
          controller.periodSelection.value,
        );
      },
      semesters: controller.curSemestersList,
      scheduleTable: Obx(
        () => ScheduleTable(
          timetableList: controller.timetableFiltered,
          startDate: controller.startDate.value,
          week: controller.weekSelection.value,
          isClone: false,
          labErr: controller.labErr,
        ),
      ),
    );
  }
}
