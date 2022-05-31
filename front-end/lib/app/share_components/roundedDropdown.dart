import 'package:flutter/material.dart';
import 'package:lab_registration_management/app/core/value/constants/app_constants.dart';

class RoundedDropdown extends StatelessWidget {
  const RoundedDropdown({
    Key? key,
    required this.items,
    required this.value,
    required this.onChanged,
    this.primaryColor = kPrimary,
    this.bgColor,
    this.width,
  }) : super(key: key);

  final List<DropdownMenuItem<String>> items;
  final String value;
  final Function(String?)? onChanged;
  final Color primaryColor;
  final Color? bgColor;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: 40,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: bgColor ?? Colors.transparent,
        border: Border.all(color: kFontColorPallets[0].withOpacity(0.1)),
        borderRadius: BorderRadius.circular(20),
      ),
      child: ClipRRect(
        child: DropdownButton<String>(
            style: const TextStyle(
              overflow: TextOverflow.ellipsis,
              color: kBlack
            ),
            value: value,
            icon: const Icon(Icons.arrow_drop_down_outlined),
            iconEnabledColor: kPrimary,
            elevation: 12,
            // isExpanded: true,
            underline: Container(),
            onChanged: onChanged,
            items: items
        ),
      ),
    );
  }
}