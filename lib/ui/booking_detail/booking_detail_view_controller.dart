import 'package:get/get.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:stacktim_booking/helper/functions.dart';
import 'package:stacktim_booking/helper/snackbar.dart';
import 'package:stacktim_booking/logic/models/computer/computer.dart';
import 'package:stacktim_booking/logic/repository/booking_repository.dart';
import 'package:stacktim_booking/navigation/route.dart';

import '../../logic/models/booking/booking.dart';

class BookingDetailViewController extends GetxController with StateMixin {
  String bookingId = "";
  String currentUserId = "";
  BookingRepository bookingRepository = BookingRepository();
  Rx<Booking> currentBooking = const Booking().obs;
  Rx<Computer> computerSelected = const Computer().obs;
  RxList<Booking> currentBookingList = <Booking>[].obs;
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
      await Sentry.captureMessage(
          "Erreur lors de l'initialisation des requêtes. - Booking Détail");
      await Sentry.captureException(e);
      change(null, status: RxStatus.error());
    }
    super.onInit();
  }

  Future<void> getBooking() async {
    return await bookingRepository.getBooking(currentBookingId: bookingId).then(
          (value) => value.fold(
            (l) async {
              await Sentry.captureException(l);
            },
            (r) {
              currentBookingList.value = r;
              getBookingOfCurrentUser();
              checkIsProgressBooking();
            },
          ),
        );
  }

  checkIsProgressBooking() {
    if (currentBooking.value.status?.slug == StatusSlugs.inProgress ||
        (currentBooking.value.status?.slug == StatusSlugs.passee &&
            currentBooking.value.isCheckoutComplete != true)) {
      isInProgress.value = true;
    } else if (currentBooking.value.status?.slug == StatusSlugs.passee &&
        currentBooking.value.isCheckoutComplete == true) {
      isPassed.value = true;
    }
  }

  getBookingOfCurrentUser() {
    var index = 0;
    while (index < currentBookingList.length) {
      var booking = currentBookingList[index];
      if (booking.userId == currentUserId) {
        currentBooking.value = booking;
        computerSelected.value = booking.computer ?? const Computer();
        currentBookingList.removeAt(index);
      } else {
        index++;
      }
    }
  }

  Future<void> cancelBooking() async {
    return await bookingRepository
        .cancelBooking(currentBookingId: bookingId)
        .then(
          (value) => value.fold(
            (l) async {
              await Sentry.captureException(l);
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
      if (Get.arguments.containsKey('currentUserId')) {
        currentUserId = Get.arguments['currentUserId'] ?? "0";
      }
    }
  }
}
