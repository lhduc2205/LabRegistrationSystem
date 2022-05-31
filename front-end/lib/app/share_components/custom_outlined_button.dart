import 'package:flutter/material.dart';
import 'package:lab_registration_management/app/core/value/constants/app_constants.dart';

class CustomOutlinedButton extends StatelessWidget {
  const CustomOutlinedButton({
    Key? key,
    required this.onPressed,
    required this.child,
    required this.icon,
    this.primaryColor = kPrimary,
    this.padding = 12,
  }) : super(key: key);

  final VoidCallback onPressed;
  final Widget child;
  final IconData icon;
  final Color primaryColor;
  final double padding;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon),
      label: child,
      style: OutlinedButton.styleFrom(
        primary: primaryColor,
        side: BorderSide(color: primaryColor),
        padding: EdgeInsets.all(padding),
      ),
    );
  }
}
