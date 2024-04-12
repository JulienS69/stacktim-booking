import 'package:get/get.dart';
import 'package:stacktim_booking/helper/functions.dart';
import 'package:stacktim_booking/helper/snackbar.dart';
import 'package:stacktim_booking/logic/repository/booking_repository.dart';
import 'package:stacktim_booking/navigation/route.dart';

import '../../logic/models/booking/booking.dart';

class BookingDetailViewController extends GetxController with StateMixin {
  String bookingId = "";
  BookingRepository bookingRepository = BookingRepository();
  Rx<Booking> currentBooking = const Booking().obs;
  Rx<bool> isInProgress = false.obs;
  Rx<bool> isPassed = false.obs;

  @override
  void onInit() async {
    change(null, status: RxStatus.loading());
    try {
      await getBookingId();
      await getBooking();
      change(null, status: RxStatus.success());
    } catch (e) {
      change(null, status: RxStatus.error());
    }
    super.onInit();
  }

  Future<void> getBooking() async {
    return await bookingRepository.getBooking(currentBookingId: bookingId).then(
          (value) => value.fold(
            (l) {},
            (r) {
              if (r.status?.slug == StatusSlugs.inProgress) {
                isInProgress.value = true;
              } else if (r.status?.slug == StatusSlugs.passee) {
                isPassed.value = true;
              }
              currentBooking.value = r;
            },
          ),
        );
  }

  Future<void> cancelBooking() async {
    return await bookingRepository
        .cancelBooking(currentBookingId: bookingId)
        .then(
          (value) => value.fold(
            (l) {
              showSnackbar(
                  "Impossible d'annuler moins de 2 heures avant le début de la réservation.",
                  SnackStatusEnum.error);
            },
            (r) {
              Get.offAllNamed(Routes.dashboard);
              showSnackbar("Ta réservation vient d'être annulée",
                  SnackStatusEnum.success);
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
