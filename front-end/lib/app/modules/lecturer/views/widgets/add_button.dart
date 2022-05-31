part of lecturer;

class _AddButton extends StatelessWidget {
  const _AddButton({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final LecturerController controller;

  @override
  Widget build(BuildContext context) {
    return DefaultButton(
      child: const Text('Thêm'),
      onPressed: () => Get.dialog(
        // _CustomAlertDialog(),
        ConfirmDialog(
          title: "Thêm Giảng viên",
          content: SingleChildScrollView(
            child:  _LecturerForm(
              controller: controller,
            ),
          ),
          onAcceptPressed: () => controller.handleCreatedSubmit(),
          onCancelPressed: () => Get.back(),
        ),
        barrierDismissible: false,
      ),
    );
  }
}
