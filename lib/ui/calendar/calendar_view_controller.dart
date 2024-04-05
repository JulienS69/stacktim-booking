import 'package:get/get.dart';

import '../../logic/models/booking/booking.dart';
import '../../logic/models/calendar_data_source/calendar_data_source.dart';
import '../../logic/repository/booking_repository.dart';

class CalendarViewController extends GetxController with StateMixin {
  final BookingRepository bookingRepository;
  List<Booking> bookingList = [];

  CalendarViewController({
    required this.bookingRepository,
  });

  @override
  void onInit() async {
    change(null, status: RxStatus.loading());
    await getMonthlyBookings(DateTime.now().month);
    change(null, status: RxStatus.success());
    super.onInit();
  }

  XCalendarDataSource getDataSource() {
    return XCalendarDataSource(bookingList);
  }

  getMonthlyBookings(int month) async {
    await bookingRepository.getCalendarMonthlyBooking(monthNumber: month).then(
          (value) => value.fold(
            (l) => bookingList = [],
            (r) => bookingList = r,
          ),
        );
  }
}
