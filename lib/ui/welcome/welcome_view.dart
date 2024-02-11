import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simple_progress_indicators/simple_progress_indicators.dart';
import 'package:stacktim_booking/helper/strings.dart';
import 'package:stacktim_booking/ui/welcome/welcome_view_controller.dart';

class WelcomeView extends GetResponsiveView<WelcomeViewController> {
  WelcomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return controller.obx((state) => Scaffold(
            body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              logo,
              height: 100,
            ),
            const Padding(
              padding: EdgeInsets.only(top: 8.0),
              child: Text(
                "Préparation de ton application",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                      child: ProgressBarAnimation(
                        duration: const Duration(seconds: 2),
                        gradient: const LinearGradient(
                          colors: [
                            Colors.blue,
                            Colors.purple,
                          ],
                        ),
                        backgroundColor: Colors.grey.withOpacity(0.4),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        )));
  }
}
