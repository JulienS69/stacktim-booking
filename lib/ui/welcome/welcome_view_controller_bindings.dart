import 'package:get/get.dart';
import 'package:stacktim_booking/ui/welcome/welcome_view_controller.dart';

class WelcomeViewControllerBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => WelcomeViewController(),
    );
  }
}
