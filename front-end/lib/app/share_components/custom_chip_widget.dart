import 'package:flutter/material.dart';

class CustomChipWidget extends StatelessWidget {
  const CustomChipWidget(
      {Key? key, required this.label, required this.primary,})
      : super(key: key);

  final String label;
  final Color primary;

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(label),
      backgroundColor: primary.withOpacity(0.1),
      labelStyle: TextStyle(fontSize: 14, color: primary),
    );
  }
}

