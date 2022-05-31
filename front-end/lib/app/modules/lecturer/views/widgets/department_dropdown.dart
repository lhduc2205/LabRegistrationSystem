part of lecturer;

class _DepartmentDropdown extends StatelessWidget {
  const _DepartmentDropdown({
    Key? key,
    required this.departments,
    required this.controller,
    this.primaryColor = kPrimary,
  }) : super(key: key);

  final List<DepartmentModel> departments;
  final LecturerController controller;
  final Color primaryColor;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => SizedBox(
        width: 200,
        // padding: const EdgeInsets.symmetric(horizontal: 16),
        // decoration: BoxDecoration(
        //   border: Border.all(color: kFontColorPallets[2]),
        //   borderRadius: BorderRadius.circular(5),
        // ),
        child: ClipRRect(
          child: DropdownButton<String>(
            style: const TextStyle(
              overflow: TextOverflow.ellipsis,
            ),
            value: controller.departmentSelection.value.toString(),
            icon: const Icon(Icons.arrow_drop_down_outlined),
            iconEnabledColor: primaryColor,
            elevation: 16,
            isExpanded: true,
            underline: Container(height: 1, color: kFontColorPallets[2],),
            onChanged: (String? id) {
              controller.setDepartmentSelection(id!);
            },
            items: departments.map<DropdownMenuItem<String>>((department) {
              return DropdownMenuItem<String>(
                value: department.id.toString(),
                child: Text(
                  department.tenBoMon.capitalizeFirst!,
                  overflow: TextOverflow.fade,
                  softWrap: false,
                  maxLines: 1,
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
