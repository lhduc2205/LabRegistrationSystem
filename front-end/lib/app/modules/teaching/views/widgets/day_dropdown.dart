part of teaching;

class _DayDropdown extends StatelessWidget {
  const _DayDropdown({
    Key? key,
    required this.days,
    required this.controller,
    required this.value,
    this.width,
    this.primaryColor,
  }) : super(key: key);

  final List<DayModel> days;
  final TeachingController controller;
  final String value;
  final double? width;
  final Color? primaryColor;

  @override
  Widget build(BuildContext context) {
    return DefaultDropdown(
      items: days.map<DropdownMenuItem<String>>((session) {
        return DropdownMenuItem<String>(
          value: session.id.toString(),
          child: Text(
            session.tenThu.capitalizeFirst!,
            overflow: TextOverflow.fade,
            softWrap: false,
            maxLines: 1,
          ),
        );
      }).toList(),
      value: value,
      onChanged: (String? id) {
        controller.setDaySelection(id!);
      },
    );
  }
}
