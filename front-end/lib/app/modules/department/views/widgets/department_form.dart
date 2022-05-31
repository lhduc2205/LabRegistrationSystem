part of department;

class _DepartmentForm extends StatelessWidget {
  const _DepartmentForm({Key? key, required this.controller}) : super(key: key);

  final DepartmentController controller;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: controller.formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          buildNameField(),
          const SizedBox(
            height: 15,
          ),
          buildAbbreviationField(),
        ],
      ),
    );
  }

  CustomTextFormField buildAbbreviationField() {
    return CustomTextFormField(
        labelText: "Tên viết tắt",
        controller: controller.vietTatCtrl,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Vui lòng nhập tên viết tắt';
          }
          return null;
        });
  }

  CustomTextFormField buildNameField() {
    return CustomTextFormField(
        labelText: "Tên bộ môn",
        controller: controller.tenBMCtrl,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Vui lòng nhập tên bộ môn';
          }
          return null;
        });
  }
}
