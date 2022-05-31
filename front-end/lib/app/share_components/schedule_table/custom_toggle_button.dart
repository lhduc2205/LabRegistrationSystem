import 'package:flutter/material.dart';
import 'package:lab_registration_management/app/core/value/constants/app_constants.dart';

class CustomToggleButton extends StatelessWidget {
  const CustomToggleButton({
    Key? key,
    required this.children,
    required this.isSelected,
    required this.onPressed,
    this.primaryColor,
    this.selectedColor,
  }) : super(key: key);

  final List<Widget> children;
  final List<bool> isSelected;
  final Function(int) onPressed;
  final Color? primaryColor;
  final Color? selectedColor;

  @override
  Widget build(BuildContext context) {
    return ToggleButtons(
      children: children,
      isSelected: isSelected,
      onPressed: onPressed,
      selectedColor: selectedColor ?? kWhite,
      fillColor: primaryColor ?? kPrimary,
      borderColor: primaryColor ?? kPrimary,
      borderRadius: BorderRadius.circular(5),
      selectedBorderColor: primaryColor ?? kPrimary,
      color:primaryColor ?? kPrimary,
      disabledBorderColor: primaryColor ?? kPrimary,
    );
  }
}
