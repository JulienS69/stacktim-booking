import 'package:get/get.dart';
import 'package:stacktim_booking/ui/splash_screen/liquid_swipe_view.dart/liquid_swipe_view_controller.dart';

class LiquidSwipeViewControllerBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => LiquidSwipeViewController(),
    );
  }
}
