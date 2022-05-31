part of teaching;

class _SubjectDropdown extends StatelessWidget {
  const _SubjectDropdown({
    Key? key,
    required this.subjects,
    required this.controller,
    required this.value,
    this.maHPLabel = false,
    this.width,
    this.primaryColor = kPrimary,
  }) : super(key: key);

  final List<SubjectModel> subjects;
  final TeachingController controller;
  final String value;
  final bool maHPLabel;
  final double? width;
  final Color primaryColor;

  @override
  Widget build(BuildContext context) {
    SubjectModel subject = SubjectModel(
      id: 0,
      maMonHoc: 'Tất cả',
      tenMonHoc: 'Tất cả',
      soTinChi: 0,
      vietTat: 'tc',
    );
    int index = subjects.indexWhere((subject) => subject.id == 0);
    if (index < 0) {
      subjects.insert(0, subject);
    } else {
      subjects.removeAt(index);
      subjects.insert(0, subject);
    }

    return DefaultDropdown(
      width: width,
      items: subjects.map<DropdownMenuItem<String>>((subject) {
        return DropdownMenuItem<String>(
          value: subject.id.toString(),
          child: Text(
            maHPLabel ? subject.maMonHoc : subject.tenMonHoc.capitalizeFirst!,
            overflow: TextOverflow.fade,
            softWrap: false,
            maxLines: 1,
          ),
        );
      }).toList(),
      value: value,
      onChanged: (String? id) {
        controller.setSubjectSelection(id!, isSetId: maHPLabel);
      },
    );
  }
}
