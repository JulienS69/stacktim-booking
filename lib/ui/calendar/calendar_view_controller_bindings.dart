import 'package:get/get.dart';
import 'package:stacktim_booking/logic/repository/booking_repository.dart';
import 'package:stacktim_booking/logic/repository/user_repository.dart';
import 'package:stacktim_booking/ui/calendar/calendar_view_controller.dart';

class CalendarViewControllerBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => CalendarViewController(
        bookingRepository: BookingRepository(),
        userRepository: UserRepository(),
      ),
    );
  }
}
