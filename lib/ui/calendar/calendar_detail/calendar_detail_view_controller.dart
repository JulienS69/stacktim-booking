import 'package:get/get.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../../../logic/models/booking/booking.dart';

class CalendarDetailViewController extends GetxController with StateMixin {
  DateTime dateTimeSelected = DateTime.now();
  List<Booking> bookings = [];
  CalendarTapDetails? calendarTapDetails;
  @override
  void onInit() {
    change(null, status: RxStatus.loading());
    if (Get.arguments != null) {
      if (Get.arguments.containsKey('date')) {
        dateTimeSelected = Get.arguments['date'];
      }
      if (Get.arguments.containsKey('calendarTapDetails')) {
        calendarTapDetails = Get.arguments['calendarTapDetails'];
        if (calendarTapDetails?.appointments != null) {
          calendarTapDetails!.appointments?.forEach((booking) {
            bookings.add(booking);
          });
        }
      }
    }
    change(null, status: RxStatus.success());

    super.onInit();
  }
}
