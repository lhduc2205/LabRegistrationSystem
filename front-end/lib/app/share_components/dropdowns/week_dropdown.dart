import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/string_extensions.dart';
import 'package:lab_registration_management/app/data/models/week_model.dart';

import '../roundedDropdown.dart';


class WeekDropdown extends StatelessWidget {
  const WeekDropdown({
    Key? key,
    required this.weekList,
    required this.onChanged,
    required this.value,
    this.width,
  }) : super(key: key);

  final List<WeekModel> weekList;
  final Function(String?)? onChanged;
  final String value;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return RoundedDropdown(
      width: width,
      items: weekList.map<DropdownMenuItem<String>>((week) {
        return DropdownMenuItem<String>(
          value: week.id.toString(),
          child: Text(
            week.tenTuan.capitalizeFirst!,
            overflow: TextOverflow.fade,
            softWrap: false,
            maxLines: 1,
          ),
        );
      }).toList(),
      value: value,
      onChanged: onChanged,
    );
  }
}