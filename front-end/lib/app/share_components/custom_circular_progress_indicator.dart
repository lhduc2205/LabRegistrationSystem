import 'package:flutter/material.dart';
import 'package:lab_registration_management/app/core/value/constants/app_constants.dart';

class CustomCircularProgessIndicator extends StatelessWidget {
  const CustomCircularProgessIndicator({Key? key, this.color}) : super(key: key);
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        color: color ?? kPrimary,
      ),
    );
  }
}
