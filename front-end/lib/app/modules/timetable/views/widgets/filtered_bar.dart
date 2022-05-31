part of timetable;

class _FilteredBar extends StatelessWidget {
  const _FilteredBar({
    Key? key,
    required this.periodsList,
    required this.controller,
    this.isAdmin = false,
  }) : super(key: key);

  final List<PeriodModel> periodsList;
  final TimetableController controller;
  final bool isAdmin;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            const Icon(
              IconlyBold.filter,
              color: kPrimary,
            ),
            const SizedBox(width: 10),
            Obx(
              () => _PeriodDropdown(
                color: kWhite,
                periodsList: periodsList,
                onChanged: (id) => controller.setPeriodSelection(id),
                value: controller.periodSelection.value.toString(),
              ),
            ),
            const SizedBox(width: 10),
          ],
        ),
        Visibility(
          visible: isAdmin,
          child: Obx(
            () => controller.isEditedMode.value
                ? ElevatedButton.icon(
                    icon: const Icon(Icons.done_all),
                    label: const Text('Hoàn tất'),
                    style: defaultButtonStyle(primaryColor: kPrimary),
                    onPressed: () => controller.setEditedModel(false),
                  )
                : ElevatedButton.icon(
                    icon: const Icon(Icons.edit),
                    label: const Text('Chỉnh sửa'),
                    style: defaultButtonStyle(primaryColor: kGreen),
                    onPressed: () => controller.setEditedModel(true),
                  ),
          ),
        )
      ],
    );
  }
}
