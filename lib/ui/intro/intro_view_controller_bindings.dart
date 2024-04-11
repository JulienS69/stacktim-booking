import 'package:get/get.dart';
import 'package:stacktim_booking/ui/intro/intro_view_controller.dart';

class IntroViewControllerBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => IntroViewController(),
    );
  }
}
