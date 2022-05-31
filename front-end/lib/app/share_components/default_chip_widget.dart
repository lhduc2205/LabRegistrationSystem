import 'package:flutter/material.dart';
import 'package:lab_registration_management/app/core/value/constants/app_constants.dart';

class DefaultChipWidget extends StatelessWidget {
  const DefaultChipWidget({
    Key? key,
    required this.label,
  }) : super(key: key);

  final Widget label;

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: label,
      labelStyle: const TextStyle(fontSize: 14, color: kPrimary),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
      elevation: 0,
      // side: const BorderSide(color: kPrimary),
      backgroundColor: kBgColorPallets[1],
    );
  }
}