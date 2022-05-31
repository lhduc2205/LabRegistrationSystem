part of my_timetable;

class _PeriodDropdown extends StatelessWidget {
  const _PeriodDropdown({
    Key? key,
    required this.periodsList,
    required this.onChanged,
    required this.value,
    this.color,
  }) : super(key: key);

  final List<PeriodModel> periodsList;
  final Function(String?)? onChanged;
  final String value;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return RoundedDropdown(
      bgColor: color ?? Colors.transparent,
      items: periodsList.map<DropdownMenuItem<String>>((period) {
        return DropdownMenuItem<String>(
          value: period.id.toString(),
          child: Text(
            period.tenBuoiHoc.capitalizeFirst!,
            overflow: TextOverflow.fade,
            softWrap: false,
            maxLines: 1,
          ),
        );
      }).toList(),
      value: value,
      onChanged: onChanged,
    );
  }
}
