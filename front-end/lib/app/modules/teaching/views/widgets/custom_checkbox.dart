import 'package:flutter/material.dart';

class CustomCheckbox extends StatelessWidget {
  const CustomCheckbox({
    Key? key,
    required this.onChanged,
    required this.primaryColor,
    required this.groupValue,
    required this.label,
  }) : super(key: key);

  final Color primaryColor;
  final Function(Object?)? onChanged;
  final int groupValue;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Radio(
          // fillColor: MaterialStateProperty.all(primaryColor),
          activeColor: primaryColor,
          value: false,
          groupValue: groupValue,
          onChanged: onChanged,
        ),
        Text(label),
      ],
    );
  }
}
