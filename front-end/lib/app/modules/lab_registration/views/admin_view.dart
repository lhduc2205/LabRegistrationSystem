part of lab_registration;

class _AdminView extends StatelessWidget {
  const _AdminView({
    Key? key,
    required this.controller, required this.timetableController,
  }) : super(key: key);

  final LabRegistrationController controller;
  final TimetableController timetableController;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: kWhite,
      body: ListView(
        children: [
          _buildHeaderRow(),
          const SizedBox(height: kSpacing),
          _buildActionRow(context),
          const SizedBox(height: kSpacing),
          Obx(
            () => PaginatedDataTable(
              columns: _getColumns(controller.labelColumns),
              source: _DataTableSource(
                registration: controller.registrationFiltered.value,
                timetableController: timetableController,
                controller: controller,
              ),
              rowsPerPage: DataTableService.getRowsPerPage(
                  controller.registration.length,
                  defaultLength: 6),
              // sortColumnIndex: 0,
            ),
          ),
        ],
      ),
    );
  }

  Row _buildHeaderRow() {
    var _navigationController = NavigationController.instance;
    var _sideBarController = Get.find<SideBarController>();

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomBackButton(
          onPressed: () {
            _navigationController.navigateTo(timeTablePageRoute);
            _sideBarController.changeActiveItemTo(timetablePageDisplayName);
          },
          text: 'Lịch thực hành',
        ),
        const _ScheduleButton()
      ],
    );
  }

  Row _buildActionRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: ResponsiveWidget.isSmallScreen(context)
              ? Column(
                  children: [
                    Lottie.asset(LottiePath.calendarBooking, height: 100),
                    const SizedBox(height: 10),
                    _SchedulingButton(
                      controller: controller,
                    ),
                  ],
                )
              : Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Lottie.asset(LottiePath.calendarBooking, height: 100),
                    _SchedulingButton(
                      controller: controller,
                    ),
                  ],
                ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextButton.icon(
              onPressed: () async => controller.onRefresh(),
              icon: const Icon(Icons.refresh),
              label: const Text('Refresh'),
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: 200,
              child: Obx(
                () => SearchBar(
                  searchController: controller.searchController,
                  isHideCloseBtn: controller.isHideCloseBtn.value,
                  onChanged: (value) => controller.onChangedSearchBtn(value),
                  onTapCloseBtn: controller.onTapCloseBtn,
                ),
              ),
            ),
          ],
        )
      ],
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

class _ScheduleButton extends StatelessWidget {
  const _ScheduleButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _navigationController = NavigationController.instance;

    return ElevatedButton.icon(
      onPressed: () => _navigationController.navigateTo(
        timetableClonePageRoute,
      ),
      icon: const Icon(IconlyBold.calendar),
      label: const Text('Lịch mẫu'),
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.all(15),
      ),
    );
  }
}
