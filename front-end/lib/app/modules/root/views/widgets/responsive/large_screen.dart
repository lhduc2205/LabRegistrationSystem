import 'package:flutter/material.dart';
import 'package:lab_registration_management/app/local_navigator.dart';
import 'package:lab_registration_management/app/modules/root/views/widgets/side_bar/side_bar.dart';

class LargeScreen extends StatelessWidget {
  const LargeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(width: 250, child: SideBar()),
        Expanded(flex: 5, child: localNavigator())
      ],
    );
  }
}
