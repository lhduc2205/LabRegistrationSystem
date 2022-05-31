part of teaching;

class _LecturerDropdown extends StatelessWidget {
  const _LecturerDropdown({
    Key? key,
    required this.lecturers,
    required this.controller,
    this.width,
    this.primaryColor,
  }) : super(key: key);

  final List<LecturerModel> lecturers;
  final TeachingController controller;
  final double? width;
  final Color? primaryColor;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => DefaultDropdown(
        items: lecturers.map<DropdownMenuItem<String>>((lecturer) {
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
        value: controller.lecturerSelection.value.toString(),
        onChanged: (String? id) {
          controller.setLecturerSelection(id!);
        },
      ),
    );
  }
}
