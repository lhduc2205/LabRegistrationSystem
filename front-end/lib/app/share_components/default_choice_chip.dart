import 'package:flutter/material.dart';
import 'package:lab_registration_management/app/core/value/constants/app_constants.dart';

class DefaultChoiceChip extends StatelessWidget {
  const DefaultChoiceChip({
    Key? key,
    required this.text,
    required this.isSelected,
    required this.primaryColor,
    required this.onSelected,
  }) : super(key: key);

  final String text;
  final bool isSelected;
  final Color primaryColor;
  final Function(bool) onSelected;

  @override
  Widget build(BuildContext context) {
    return ChoiceChip(
      label: Text(
        text,
        // style: TextStyle(color: isSelected ? primaryColor : null),
        style: TextStyle(color: isSelected ? kWhite : null),
      ),
      selected: isSelected,
      onSelected: onSelected,
      selectedColor: primaryColor,
    );
  }
}
