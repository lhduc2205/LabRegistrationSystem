import 'package:flutter/material.dart';
import 'package:lab_registration_management/app/core/value/constants/app_constants.dart';

class ColoredButton extends StatelessWidget {
  const ColoredButton({
    Key? key,
    required this.widget,
    required this.onPressed,
    this.color,
    this.bgColor,
  }) : super(key: key);

  final Widget widget;
  final VoidCallback onPressed;
  final Color? color;
  final Color? bgColor;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(

      style: ElevatedButton.styleFrom(
          textStyle: TextStyle(
            color: color ?? kPrimary,
            // fontSize: 16,
          ),
          onPrimary: color ?? kPrimary,
          primary: bgColor ?? Colors.blue.shade50,
          minimumSize: const Size.fromHeight(45),
          shape: const StadiumBorder()
      ),
      onPressed: onPressed,
      child: widget,
    );
  }

}
