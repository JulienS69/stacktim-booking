import 'package:get/get.dart';
import 'package:stacktim_booking/ui/calendar/calendar_detail/calendar_detail_view_controller.dart';

class CalendarDetailViewControllerBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => CalendarDetailViewController(),
    );
  }
}
