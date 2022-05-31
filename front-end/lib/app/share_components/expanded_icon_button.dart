import 'package:flutter/material.dart';
import 'package:lab_registration_management/app/core/value/constants/app_constants.dart';

class ExpandedIconButton extends StatelessWidget {
  const ExpandedIconButton({
    Key? key,
    required this.label,
    required this.icon,
    required this.onPressed,
  }) : super(key: key);

  final String label;
  final IconData icon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: TextButton.icon(
        onPressed: onPressed,
        icon: Icon(icon),
        label: Text(label),
        style: TextButton.styleFrom(
            minimumSize: const Size.fromHeight(40),
            padding: const EdgeInsets.all(20),
            primary: Colors.red,
            alignment: Alignment.centerLeft),
      ),
    );
  }
}
