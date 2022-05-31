import 'package:flutter/material.dart';
import 'package:lab_registration_management/app/core/value/constants/app_constants.dart';

class LargeButton extends StatelessWidget {
  const LargeButton({
    Key? key,
    required this.widget,
    required this.onPressed,
    this.color = kDeepBlue,
    this.padding = const EdgeInsets.all(25),
    this.fontWeight,
  }) : super(key: key);

  final Widget widget;
  final VoidCallback onPressed;
  final Color color;
  final EdgeInsets padding;
  final FontWeight? fontWeight;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        textStyle: TextStyle(
          color: Colors.white,
          fontWeight: fontWeight ?? FontWeight.bold,
          fontSize: 16,
        ),
        primary: kDeepBlue,
        minimumSize: const Size.fromHeight(60),
        shape: const StadiumBorder()
      ),
      onPressed: onPressed,
      child: widget,
    );
  }
}
