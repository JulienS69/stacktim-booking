import 'package:stacktim_booking/logic/models/booking/booking.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class XCalendarDataSource extends CalendarDataSource<Booking> {
  XCalendarDataSource(List<Booking> source) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return appointments![index].beginAt.toLocal();
  }

  @override
  DateTime getEndTime(int index) {
    return appointments![index].endAt.toLocal();
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
