import 'package:flutter/material.dart';
import 'package:lab_registration_management/app/core/value/constants/app_constants.dart';

class DefaultDropdown extends StatelessWidget {
  const DefaultDropdown({
    Key? key,
    required this.items,
    required this.value,
    required this.onChanged,
    this.primaryColor = kPrimary,
    this.width,
  }) : super(key: key);

  final List<DropdownMenuItem<String>> items;
  final String value;
  final Function(String?)? onChanged;
  final Color primaryColor;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return Container(
      // width: width,
      height: 50,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        border: Border.all(color: kGrey),
        borderRadius: BorderRadius.circular(10),
      ),
      child: ClipRRect(
        child: DropdownButton<String>(
          style: const TextStyle(
            overflow: TextOverflow.ellipsis,
          ),
          value: value,
          icon: const Icon(Icons.arrow_drop_down_outlined),
          iconEnabledColor: primaryColor,
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