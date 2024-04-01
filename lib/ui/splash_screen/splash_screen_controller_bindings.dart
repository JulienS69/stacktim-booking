import 'package:get/get.dart';
import 'package:stacktim_booking/ui/splash_screen/splash_screen_controller.dart';

class SplashScreenControllerBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => SplashScreenController(),
    );
  }
}
