part of lecturer;

class _GenderCheckBox extends StatelessWidget {
  const _GenderCheckBox({
    Key? key,
    required this.controller,
    required this.primaryColor,
  }) : super(key: key);

  final LecturerController controller;
  final Color primaryColor;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Row(
        children: [
          Row(
            children: [
              Radio(
                // fillColor: MaterialStateProperty.all(primaryColor),
                activeColor: primaryColor,
                value: false,
                groupValue: controller.isFemale.value,
                onChanged: (bool? value) => controller.setGender(value!),
              ),
              const Text(
                'Nam',
              ),
            ],
          ),
          const SizedBox(width: 10),
          Row(
            children: [
              Radio(
                value: true,
                activeColor: primaryColor,
                // fillColor: MaterialStateProperty.all(primaryColor),
                groupValue: controller.isFemale.value,
                onChanged: (bool? value) => controller.setGender(value!),
              ),
              const Text(
                'Nữ',
              ),
            ],
          ),
        ],
      ),
    );
  }
}
