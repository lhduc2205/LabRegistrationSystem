part of timetable;

class _EditedModeLayout extends StatelessWidget {
  const _EditedModeLayout({
    Key? key,
    required this.timetableController,
    required this.scheduleTable,
  }) : super(key: key);

  final TimetableController timetableController;
  final ScheduleTableLayout scheduleTable;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Lịch thực hành', style: headingStyle2),
            const SizedBox(),
          ],
        ),
        const SizedBox(height: kSpacing),
        _FilteredBar(
          periodsList: timetableController.periodsList,
          controller: timetableController,
          isAdmin: true,
        ),
        const SizedBox(height: 10),
        timetableController.tabController == null
            ? Container()
            : Expanded(
                child: scheduleTable,
              ),
        const SizedBox(height: kSpacing),
        _buildScheduleWaitingBar(timetableController),
      ],
    );
  }

  Widget _buildScheduleWaitingBar(TimetableController controller) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: ScheduleWaitingBar(controller: controller),
    );
  }
}
