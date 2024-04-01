import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:stacktim_booking/helper/strings.dart';

import 'splash_screen_controller.dart';

class SplashScreen extends GetView<SplashScreenController> {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return controller.obx(
      (state) => DecoratedBox(
        decoration: const BoxDecoration(
          color: Color(0xFF191919),
        ),
        child: Center(
          child: Image.asset(
            splash,
            fit: BoxFit.contain,
            height: 300,
            width: double.infinity,
          ),
        ),
      ),
    );
  }
}
