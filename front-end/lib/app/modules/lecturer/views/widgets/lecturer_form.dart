part of lecturer;

class _LecturerForm extends StatelessWidget {
  const _LecturerForm({
    Key? key,
    required this.controller,
    this.primaryColor = kPrimary,
    this.isEditedMode = false,
  }) : super(key: key);

  final LecturerController controller;
  final Color primaryColor;
  final bool isEditedMode;

  @override
  Widget build(BuildContext context) {
    final departmentController = Get.find<DepartmentController>();

    return Form(
      key: controller.formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          buildNameAndIDField(),
          const SizedBox(height: 15),
          buildEmailField(),
          const SizedBox(height: 15),
          isEditedMode ? Container() : buildPasswordField(),
          const SizedBox(height: 15),
          buildPhoneAndBirthDayField(context),
          const SizedBox(height: 15),
          buildDepartmentSelectionField(departmentController),
          const SizedBox(height: 15),
          buildGenderCheckBoxField(),
        ],
      ),
    );
  }

  Row buildGenderCheckBoxField() {
    return Row(
      children: [
        const Text('Giới tính', style: TextStyle(fontSize: 14),),
        const SizedBox(width: kSpacing),
        Expanded(
            child: _GenderCheckBox(
          controller: controller,
          primaryColor: primaryColor,
        )),
      ],
    );
  }

  Row buildDepartmentSelectionField(DepartmentController departmentController) {
    return Row(
      children: [
        const Text("Bộ môn", style: TextStyle(fontSize: 14),),
        const SizedBox(width: 35),
        Expanded(
          child: _DepartmentDropdown(
            departments: departmentController.departmentsList,
            controller: controller,
            primaryColor: primaryColor,
          ),
        ),
      ],
    );
  }

  Row buildPhoneAndBirthDayField(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: CustomTextFormField(
            labelText: "Sđt",
            controller: controller.sdtCtrl,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Vui lòng nhập sđt';
              }
              return null;
            },
          ),
        ),
        const SizedBox(width: kSpacing),
        Expanded(
          child: CustomTextFormField(
            labelText: "Ngày sinh",
            readOnly: true,
            controller: controller.ngaySinhCtrl,
            suffixIcon: DefaultIconButton(
              onPressed: () => controller.selectDate(context),
              icon: IconlyLight.calendar,
              color: primaryColor,
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Vui lòng chọn ngày sinh';
              }
              return null;
            },
          ),
        ),
      ],
    );
  }

  Row buildNameAndIDField() {
    return Row(
      children: [
        Flexible(
          flex: 3,
          child: CustomTextFormField(
            labelText: "Họ tên",
            controller: controller.hoTenCtrl,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Vui lòng nhập họ tên';
              }
              return null;
            },
          ),
        ),
        const SizedBox(width: 15),
        Flexible(
          child: CustomTextFormField(
            labelText: "Mã GV",
            controller: controller.maGvCtrl,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Mã GV';
              }
              if (controller
                      .checkExistIdLecturer(controller.maGvCtrl.text.trim()) &&
                  !isEditedMode) {
                return 'Đã tồn tại';
              }
              return null;
            },
          ),
        ),
      ],
    );
  }

  CustomTextFormField buildPasswordField() {
    return CustomTextFormField(
      obscureText: true,
      labelText: "Mật khẩu",
      controller: controller.passwordCtrl,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Vui lòng nhập tên giảng viên';
        }
        return null;
      },
    );
  }

  CustomTextFormField buildEmailField() {
    return CustomTextFormField(
      labelText: "Email",
      controller: controller.emailCtrl,
      readOnly: isEditedMode,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Vui lòng nhập email';
        }
        if (controller.checkExistEmail(controller.emailCtrl.text.trim()) &&
            !isEditedMode) {
          return 'Email đã tồn tại';
        }
        return null;
      },
    );
  }
}
