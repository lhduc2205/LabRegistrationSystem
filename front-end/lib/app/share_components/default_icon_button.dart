import 'package:flutter/material.dart';
import 'package:lab_registration_management/app/core/value/constants/app_constants.dart';

class DefaultIconButton extends StatelessWidget {
  const DefaultIconButton({
    Key? key,
    required this.icon,
    required this.onPressed,
    this.color,
    this.splashRadius,
    this.size,
  }) : super(key: key);

  final IconData icon;
  final VoidCallback onPressed;
  final Color? color;
  final double? splashRadius;
  final double? size;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      splashRadius: splashRadius ?? 20,
      icon: Icon(
        icon,
        color: color ?? kPrimary,
        size: size ?? 25,
      ),
    );
  }
}
