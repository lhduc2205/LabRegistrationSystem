part of timetable;

class _NormalModeLayout extends StatelessWidget {
  const _NormalModeLayout({
    Key? key,
    required this.navigationController,
    required this.sideBarController,
    required this.timetableController,
    required this.scheduleTable,
    this.isAdmin = false,
  }) : super(key: key);

  final NavigationController navigationController;
  final SideBarController sideBarController;
  final TimetableController timetableController;
  final bool isAdmin;
  final ScheduleTableLayout scheduleTable;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _Title(
          isAdmin: isAdmin,
        ),
        const SizedBox(height: kSpacing),
        _buildFilteredBar(timetableController, isAdmin),
        const SizedBox(height: kSpacing),
        timetableController.tabController == null
            ? Container()
            : Expanded(
                child: scheduleTable,
              ),
      ],
    );
  }

  Widget _buildFilteredBar(TimetableController controller, bool isAdmin) {
    return _FilteredBar(
      controller: controller,
      periodsList: controller.periodsList,
      isAdmin: isAdmin,
    );
  }


}
