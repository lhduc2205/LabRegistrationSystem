import 'package:flutter/material.dart';
import 'package:lab_registration_management/app/data/models/lab_model.dart';

import '../roundedDropdown.dart';


class LabDropdown extends StatelessWidget {
  const LabDropdown({
    Key? key,
    required this.labList,
    required this.onChanged,
    required this.value,
    this.width,
  }) : super(key: key);

  final List<LabModel> labList;
  final Function(String?)? onChanged;
  final String value;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return RoundedDropdown(
      width: width,
      items: labList.map<DropdownMenuItem<String>>((lab) {
        return DropdownMenuItem<String>(
          value: lab.id.toString(),
          child: Text(
            lab.tenPhong.toUpperCase(),
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