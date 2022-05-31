part of my_timetable;

class _FilteredBar extends StatelessWidget {
  const _FilteredBar({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final MyTimetableController controller;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Obx(
          () => controller.toggleSelection[0]
              ? _PeriodDropdown(
                  periodsList: controller.periodsList,
                  onChanged: (String? id) => controller.setPeriodSelection(id!),
                  value: controller.periodSelection.value.toString(),
                )
              : SizedBox(
                  width: 250,
                  child: SearchBar(
                    searchController: controller.searchController,
                    isHideCloseBtn: controller.isHideCloseBtn.value,
                    onChanged: (value) => controller.onChangedInput(value),
                    onTapCloseBtn: () => controller.onTapCloseBtn(),
                  ),
                ),
        ),
        Obx(
          () => _ToggleButton(
            isSelected: controller.toggleSelection.value,
            onPressed: (int index) => controller.onPressedToggle(index),
          ),
        ),
      ],
    );
  }
}

class _ToggleButton extends StatelessWidget {
  const _ToggleButton({
    Key? key,
    required this.isSelected,
    required this.onPressed,
  }) : super(key: key);

  final List<bool> isSelected;
  final Function(int) onPressed;

  @override
  Widget build(BuildContext context) {
    return CustomToggleButton(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            children: const [
              Icon(Icons.calendar_today, size: 20),
              SizedBox(width: 5),
              Text('Dạng lịch'),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            children: const [
              Icon(Icons.view_list, size: 20),
              SizedBox(width: 5),
              Text('Dạng bảng'),
            ],
          ),
        ),
      ],
      isSelected: isSelected,
      onPressed: onPressed,
    );
  }
}
