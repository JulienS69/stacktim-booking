import 'package:get/get.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:stacktim_booking/logic/repository/booking_repository.dart';

import '../../logic/models/booking/booking.dart';

class BookingDetailViewController extends GetxController with StateMixin {
  String bookingId = "";
  BookingRepository bookingRepository = BookingRepository();
  Rx<Booking> currentBooking = const Booking().obs;

  @override
  void onInit() async {
    try {
      await getBookingId();
      await getBooking();
    } catch (e) {
      Sentry.captureException(e);
    }
    change(null, status: RxStatus.success());
    super.onInit();
  }

  @override
  Future<void> onReady() async {
    change(null, status: RxStatus.loading());
    change(null, status: RxStatus.success());
    super.onReady();
  }

  Future<void> getBooking() async {
    return await bookingRepository.getBooking(currentBookingId: bookingId).then(
          (value) => value.fold(
            (l) {},
            (r) {
              currentBooking.value = r;
            },
          ),
        );
  }

  getBookingId() {
    if (Get.arguments != null) {
      if (Get.arguments.containsKey('bookingId')) {
        bookingId = Get.arguments['bookingId'] ?? "0";
      }
    }
  }
}
