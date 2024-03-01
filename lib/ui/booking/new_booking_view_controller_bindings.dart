import 'package:get/get.dart';
import 'package:stacktim_booking/ui/booking/new_booking_view_controller.dart';

class NewBookingViewControllerBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => NewBookingViewController(),
    );
  }
}
