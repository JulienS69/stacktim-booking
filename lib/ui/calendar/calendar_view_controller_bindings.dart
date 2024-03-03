import 'package:get/get.dart';
import 'package:stacktim_booking/ui/calendar/calendar_view_controller.dart';

class CalendarViewControllerBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => CalendarViewController(),
    );
  }
}
