part of login;

class _LoginForm extends StatelessWidget {
  const _LoginForm({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final LoginController controller;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: controller.formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text(
              "Đăng nhập",
              style: GoogleFonts.roboto(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: kDeepBlue,
              ),
            ),
          ),
          const SizedBox(height: kSpacing * 2),

          _CustomFormField(
            label: "Email",
            controller: controller.emailController,
            icon: IconlyLight.message,
            validator: (value) => controller.validateEmail(value),
          ),
          const SizedBox(height: 15),

          _CustomFormField(
            obscureText: true,
            label: "Mật khẩu",
            controller: controller.passwordController,
            icon: IconlyLight.lock,
            validator: (value) => controller.validatePassword(value),
          ),

          const SizedBox(height: kSpacing),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Obx(
                    () => Checkbox(
                      value: controller.isRemember.value,
                      onChanged: (value) =>
                          controller.onChangeRememberPassword(value),
                      fillColor: MaterialStateProperty.all(kDeepBlue),
                    ),
                  ),
                  const CustomText(
                    text: "Nhớ mật khẩu",
                  ),
                ],
              ),
              const CustomText(text: "Quên mật khẩu?", color: kPrimary)
            ],
          ),
          const SizedBox(height: kSpacing * 2),
          // Get.offAllNamed(rootRoute);
          _buildDefaultButton(),
          const SizedBox(height: 15),
        ],
      ),
    );
  }

  Widget _buildDefaultButton() {
    return Obx(
      () => LargeButton(
        onPressed: controller.handleSubmit,
        widget: controller.isAPICallProcess.value
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  CircularProgressIndicator(
                    color: kWhite,
                  ),
                  SizedBox(
                    width: 10
                  ),
                  Text('Đang xác thực...'),
                ],
              )
            : const Text("Đăng nhập"),
      ),
    );
  }
}

class _CustomFormField extends StatelessWidget {
  const _CustomFormField(
      {Key? key,
      required this.validator,
      required this.label,
      this.controller,
      this.obscureText = false,
      this.textInputType = TextInputType.text,
      this.icon})
      : super(key: key);

  final Function(String value) validator;
  final String label;
  final bool obscureText;
  final TextInputType textInputType;
  final IconData? icon;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) => validator(value!),
      obscureText: obscureText,
      keyboardType: textInputType,
      controller: controller,
      style: TextStyle(color: kFontColorPallets[0]),
      decoration: InputDecoration(
        labelText: label,
        suffixIcon: Icon(
          icon,
          color: kFontColorPallets[2],
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }
}
