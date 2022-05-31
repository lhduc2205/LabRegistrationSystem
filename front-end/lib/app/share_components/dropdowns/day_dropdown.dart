import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/string_extensions.dart';
import 'package:lab_registration_management/app/data/models/day_model.dart';

import '../roundedDropdown.dart';


class DayDropdown extends StatelessWidget {
  const DayDropdown({
    Key? key,
    required this.dayList,
    required this.onChanged,
    required this.value,
    this.width,
  }) : super(key: key);

  final List<DayModel> dayList;
  final Function(String?)? onChanged;
  final String value;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return RoundedDropdown(
      width: width,
      items: dayList.map<DropdownMenuItem<String>>((day) {
        return DropdownMenuItem<String>(
          value: day.id.toString(),
          child: Text(
            day.tenThu.capitalizeFirst!,
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