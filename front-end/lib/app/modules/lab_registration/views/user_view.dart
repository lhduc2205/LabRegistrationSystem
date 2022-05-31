part of lab_registration;

class _UserView extends StatelessWidget {
  const _UserView({
    Key? key,
    required this.controller,
    required this.timetableController,
  }) : super(key: key);

  final LabRegistrationController controller;
  final TimetableController timetableController;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const _Title(title: 'Đăng kí lịch'),
            TextButton.icon(
              onPressed: () async => controller.onRefresh(),
              icon: const Icon(Icons.refresh),
              label: const Text('Refresh'),
            )
          ],
        ),
        const SizedBox(height: kSpacing),
        Expanded(
          child: controller.isAssigned.value
              ? _CustomCard(
                  header: _buildCardHeader(),
                  body: _buildCardBody(),
                )
              : Center(
                  child: Text(
                    'Chưa được phân công giảng dạy',
                    style: errorStyle,
                  ),
                ),
        ),
      ],
    );
  }

  Widget _buildCardHeader() {
    return Obx(
      () => Align(
        alignment: Alignment.centerLeft,
        child: _TabBarLabel(
          tabController: controller.tabController,
          onTap: (index) => controller.onTapTabBar(index),
          activeColor: controller.activeTabBarColor.value,
        ),
      ),
    );
  }

  Widget _buildCardBody() {
    return Align(
      alignment: Alignment.topLeft,
      child: Container(
        padding: const EdgeInsets.all(kSpacing),
        child: TabBarView(
          physics: const NeverScrollableScrollPhysics(),
          controller: controller.tabController,
          children: [
            _LabRegistrationTab(controller: controller),
            _LabRegistrationTabByExcel(controller: controller),
            _ResultTab(
              controller: controller,
              timetableController: timetableController,
            ),
          ],
        ),
      ),
    );
  }
}
