import 'package:flutter/material.dart';
import 'package:lab_registration_management/app/core/value/constants/app_constants.dart';
import 'package:get/get.dart';

class ConfirmDialog extends StatelessWidget {
  const ConfirmDialog({
    Key? key,
    required this.content,
    required this.onAcceptPressed,
    required this.onCancelPressed,
    this.title,
    this.primaryColor,
    this.centerTitle = false,
    this.isUppercase = true,
    this.isDisableAcceptBtn = false,
    this.cancelBtnText = "hủy",
    this.acceptBtnText = "thêm",
  }) : super(key: key);

  final String? title;
  final Color? primaryColor;
  final Widget content;
  final bool centerTitle;
  final String cancelBtnText;
  final String acceptBtnText;
  final bool isUppercase;
  final bool isDisableAcceptBtn;
  final VoidCallback onAcceptPressed;
  final VoidCallback onCancelPressed;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        title!,
        style: TextStyle(color: primaryColor ?? kPrimary),
        textAlign: centerTitle ? TextAlign.center : TextAlign.start,
      ),
      content: content,
      actions: <Widget>[
        const SizedBox(height: 10),
        TextButton(
          onPressed: onCancelPressed,
          child: Text(
            isUppercase ? cancelBtnText.toUpperCase() : cancelBtnText,
          ),
          style: TextButton.styleFrom(primary: primaryColor ?? kPrimary),
        ),
        ElevatedButton(
          onPressed: isDisableAcceptBtn ? null : onAcceptPressed,
          child: Text(isUppercase ? acceptBtnText.toUpperCase() : acceptBtnText,),
          style: ElevatedButton.styleFrom(
            primary: primaryColor ?? kPrimary,
          ),
        ),
        const SizedBox(width: 5),
      ],
    );
  }
}
