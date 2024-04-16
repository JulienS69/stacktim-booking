import 'package:get/get.dart';
import 'package:stacktim_booking/logic/repository/holliday_repository.dart';

import '../../logic/models/booking/booking.dart';
import '../../logic/repository/booking_repository.dart';

class CalendarViewController extends GetxController with StateMixin {
  final BookingRepository bookingRepository;
  HolidayRepository holidayRepository = HolidayRepository();
  List<Booking> bookingList = [];
  List<DateTime>? holidaysList;

  CalendarViewController({
    required this.bookingRepository,
  });

  @override
  void onInit() async {
    change(null, status: RxStatus.loading());
    try {
      await fetchHolidays();
      await getMonthlyBookings(DateTime.now().month);
      change(null, status: RxStatus.success());
    } catch (e) {
      change(null, status: RxStatus.error());
    }

    super.onInit();
  }

  getMonthlyBookings(int month) async {
    await bookingRepository.getCalendarMonthlyBooking(monthNumber: month).then(
          (value) => value.fold(
            (l) => bookingList = [],
            (r) {
              bookingList = r;
            },
          ),
        );
  }

  Future<void> fetchHolidays() async {
    try {
      final holidays = await holidayRepository.fetchFrenchHolidays(2024);
      holidaysList = holidays
          .map((holiday) => DateTime.parse(holiday.dateHoliday ?? ""))
          .toList();
    } catch (e) {
      //TODO SentryLog impossible de récupérer les jours fériés
    }
  }
}
