import 'package:flutter/material.dart';
import 'package:lab_registration_management/app/core/value/constants/app_constants.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    Key? key,
    required this.controller,
    this.validator,
    this.hintText,
    this.suffixIcon,
    this.labelText,
    this.obscureText = false,
    this.readOnly = false,
    this.textInputType = TextInputType.text,
    this.floatingLabelBehavior,
  }) : super(key: key);
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final String? hintText;
  final Widget? suffixIcon;
  final String? labelText;
  final bool obscureText;
  final bool readOnly;
  final TextInputType textInputType;
  final FloatingLabelBehavior? floatingLabelBehavior;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText,
      readOnly: readOnly,
      controller: controller,
      keyboardType: textInputType,
      style: const TextStyle(color: kBlack, fontSize: 14),
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        floatingLabelBehavior:
            floatingLabelBehavior ?? FloatingLabelBehavior.auto,
        border: const UnderlineInputBorder(),
        suffixIcon: suffixIcon
      ),
      validator: validator,
    );
  }
}
