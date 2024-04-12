import 'dart:developer';

import 'package:get/get.dart';

import '../../../logic/models/booking/booking.dart';

class CalendarDetailViewController extends GetxController with StateMixin {
  DateTime dateTimeSelected = DateTime.now();
  List<Booking> bookings = [];
  @override
  void onInit() {
    change(null, status: RxStatus.loading());
    if (Get.arguments != null) {
      if (Get.arguments.containsKey('date')) {
        dateTimeSelected = Get.arguments['date'];
      }
      if (Get.arguments.containsKey('booking')) {
        bookings = Get.arguments['booking'] as List<Booking>;
        log(bookings.length.toString());
      }
    }
    change(null, status: RxStatus.success());

    super.onInit();
  }
}
