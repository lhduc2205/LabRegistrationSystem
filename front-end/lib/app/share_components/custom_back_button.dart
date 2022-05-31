import 'package:flutter/material.dart';

class CustomBackButton extends StatelessWidget {
  const CustomBackButton({
    Key? key,
    required this.onPressed,
    this.text,
  }) : super(key: key);

  final Function()? onPressed;
  final String? text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        TextButton(
          onPressed: onPressed,
          child: Row(
            children: [
              const Icon(Icons.keyboard_backspace),
              const SizedBox(width: 3),
              Text(text ?? 'Quay lại'),
            ],
          ),
        ),
      ],
    );
  }
}
