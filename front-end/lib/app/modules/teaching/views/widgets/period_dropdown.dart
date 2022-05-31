part of teaching;

class _PeriodDropdown extends StatelessWidget {
  const _PeriodDropdown({
    Key? key,
    required this.sessions,
    required this.controller,
    required this.value,
    this.width,
    this.primaryColor,
  }) : super(key: key);

  final List<PeriodModel> sessions;
  final TeachingController controller;
  final String value;
  final double? width;
  final Color? primaryColor;

  @override
  Widget build(BuildContext context) {
    return DefaultDropdown(
      items: sessions.map<DropdownMenuItem<String>>((session) {
        return DropdownMenuItem<String>(
          value: session.id.toString(),
          child: Text(
            session.tenBuoiHoc.capitalizeFirst!,
            overflow: TextOverflow.fade,
            softWrap: false,
            maxLines: 1,
          ),
        );
      }).toList(),
      value: value,
      onChanged: (String? id) {
        controller.setSessionSelection(id!);
      },
    );
  }
}
