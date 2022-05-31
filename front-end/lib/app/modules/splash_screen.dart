import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lab_registration_management/app/core/value/constants/app_constants.dart';
import 'package:lab_registration_management/app/modules/root/bindings/root_binding.dart';
import 'package:lab_registration_management/app/modules/root/views/root_view.dart';
import 'package:lottie/lottie.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    RootBinding().dependencies();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      backgroundColor: kBgColorPallets[2],
      splash: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            ImageRasterPath.CTULogo,
            width: 150,
          ),
          const SizedBox(
            height: kSpacing,
          ),
          Lottie.asset(LottiePath.bubbleLoading, height: 40),
        ],
      ),
      nextScreen: const RootView(),
      splashTransition: SplashTransition.scaleTransition,
      duration: 2000,
      splashIconSize: Get.height,
    );
  }
}
