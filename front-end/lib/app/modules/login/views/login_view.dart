library login;

import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lab_registration_management/app/core/value/constants/app_constants.dart';
import 'package:lab_registration_management/app/share_components/custom_text.dart';
import 'package:lab_registration_management/app/share_components/large_button.dart';

import '../controllers/login_controller.dart';

// components
part './widgets/login_form.dart';

part './widgets/logo_header.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(kSpacing),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  const _LogoHeader(),
                  const SizedBox(height: kSpacing,),
                  _buildFormLogin(),
                ],
              ),
            ),
          ),
        ),
      )
    );
  }

  Widget _buildFormLogin() {
    return Container(
        constraints: const BoxConstraints(maxWidth: 400),
        padding: const EdgeInsets.all(30),
        decoration: BoxDecoration(
          color: kWhite,
          borderRadius: BorderRadius.circular(kBorderRadius),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(.1),
              offset: const Offset(2, 4),
              spreadRadius: 5,
              blurRadius: 10,
            )
          ],
        ),
        child: _LoginForm(controller: controller,),
    );
  }
}
