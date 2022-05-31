import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/software_controller.dart';

class SoftwareView extends GetView<SoftwareController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SoftwareView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'SoftwareView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
