import 'package:intl/intl.dart';
import 'package:stacktim_booking/logic/models/booking/booking.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class XCalendarDataSource extends CalendarDataSource<Booking> {
  XCalendarDataSource(List<Booking> source) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    DateFormat inputFormat = DateFormat('yyyy-MM-dd hh:mm:ss');

    DateTime dateTime = inputFormat.parse(
        '${appointments![index].bookedAt} ${appointments![index].beginAt}');
    return dateTime;
  }

  @override
  DateTime getEndTime(int index) {
    DateFormat inputFormat = DateFormat('yyyy-MM-dd hh:mm:ss');

    DateTime dateTime = inputFormat.parse(
        '${appointments![index].bookedAt} ${appointments![index].endAt}');
    return dateTime;
  }

  @override
  String? getNotes(int index) {
    return appointments![index].title;
  }

  @override
  Booking convertAppointmentToObject(
      Booking customData, Appointment appointment) {
    return Booking(
      id: customData.id,
      beginAt: customData.beginAt,
      bookedAt: customData.bookedAt,
      computer: customData.computer,
      computerId: customData.computerId,
      endAt: customData.endAt,
      title: customData.title,
      duration: customData.duration,
      status: customData.status,
      statusId: customData.statusId,
      user: customData.user,
      userId: customData.userId,
    );
  }
}
