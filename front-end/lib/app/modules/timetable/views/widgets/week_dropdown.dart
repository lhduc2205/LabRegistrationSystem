part of timetable;

class _WeekDropdown extends StatelessWidget {
  const _WeekDropdown({
    Key? key,
    required this.weeksList,
    required this.onChanged,
    required this.value,
  }) : super(key: key);

  final List<WeekModel> weeksList;
  final Function(String?)? onChanged;
  final String value;

  @override
  Widget build(BuildContext context) {
    return RoundedDropdown(
      items: weeksList.asMap().entries.map<DropdownMenuItem<String>>((entries) {
        return DropdownMenuItem<String>(
          enabled: entries.value.id != 0,
          value: entries.value.id.toString(),
          child: Text(
            entries.value.tenTuan.capitalizeFirst!,
            overflow: TextOverflow.fade,
            softWrap: false,
            maxLines: 1,
            style: const TextStyle(
              color: kBlack
            ),
          ),
        );
      }).toList(),
      value: value,
      onChanged: onChanged,
    );
  }
}
