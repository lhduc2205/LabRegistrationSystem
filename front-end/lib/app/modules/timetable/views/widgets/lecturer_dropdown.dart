part of timetable;

class _LecturerDropdown extends StatelessWidget {
  const _LecturerDropdown({
    Key? key,
    required this.lecturersList,
    required this.onChanged,
    required this.value,
  }) : super(key: key);

  final List<LecturerModel> lecturersList;
  final Function(String?)? onChanged;
  final String value;

  @override
  Widget build(BuildContext context) {
    return RoundedDropdown(
      items: lecturersList.map<DropdownMenuItem<String>>((lecturer) {
        return DropdownMenuItem<String>(
          value: lecturer.id.toString(),
          child: Text(
            lecturer.hoTen.capitalizeFirstOfEach,
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
