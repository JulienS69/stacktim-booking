import 'package:get/get.dart';
import 'package:stacktim_booking/ui/booking_detail/booking_detail_view_controller.dart';

class BookingDetailViewControllerBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => BookingDetailViewController(),
    );
  }
}
