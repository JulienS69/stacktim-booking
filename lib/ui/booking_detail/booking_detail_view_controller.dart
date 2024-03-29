import 'package:get/get.dart';
import 'package:stacktim_booking/logic/repository/booking_repository.dart';

class BookingDetailViewController extends GetxController with StateMixin {
  String bookingId = "";
  BookingRepository bookingRepository = BookingRepository();

  @override
  void onInit() async {
    try {
      await getBookingId();
    } catch (e) {}
    change(null, status: RxStatus.success());
    super.onInit();
  }

  @override
  Future<void> onReady() async {
    change(null, status: RxStatus.loading());
    change(null, status: RxStatus.success());
    super.onReady();
  }

  getBookingId() {
    if (Get.arguments != null) {
      if (Get.arguments.containsKey('bookingId')) {
        bookingId = Get.arguments['bookingId'] ?? "0";
      }
    }
  }
}
