import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/string_extensions.dart';
import 'package:lab_registration_management/app/data/models/period_model.dart';

import '../roundedDropdown.dart';


class PeriodDropdown extends StatelessWidget {
  const PeriodDropdown({
    Key? key,
    required this.periodsList,
    required this.onChanged,
    required this.value,
    this.width,
  }) : super(key: key);

  final List<PeriodModel> periodsList;
  final Function(String?)? onChanged;
  final String value;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return RoundedDropdown(
      width: width,
      items: periodsList.map<DropdownMenuItem<String>>((period) {
        return DropdownMenuItem<String>(
          value: period.id.toString(),
          child: Text(
            period.tenBuoiHoc.capitalizeFirst!,
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