import 'package:flutter/material.dart';
import 'package:lab_registration_management/app/core/value/constants/app_constants.dart';

class DefaultButton extends StatelessWidget {
  const DefaultButton({
    Key? key,
    required this.onPressed,
    required this.child,
    this.primaryColor = kPrimary,
    this.padding = 15,
  }) : super(key: key);

  final VoidCallback onPressed;
  final Widget child;
  final Color primaryColor;
  final double padding;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: child,
      style: ElevatedButton.styleFrom(
        primary: primaryColor,
        padding: EdgeInsets.all(padding),
      ),
    );
  }
}
