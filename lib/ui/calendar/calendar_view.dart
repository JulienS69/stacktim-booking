import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stacktim_booking/widget/x_mobile_scaffold.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../../widget/x_app_bar.dart';
import 'calendar_view_controller.dart';

class CalendarPage extends GetView<CalendarViewController> {
  const CalendarPage({super.key});

  @override
  Widget build(BuildContext context) {
    return XMobileScaffold(
      bottomNavIndex: 1,
      appBar: const XPageHeader(
        title: 'Calendrier',
        centerTitle: true,
      ),
      body: SfCalendar(
        view: CalendarView.month,
        cellBorderColor: Colors.transparent,
        monthViewSettings: MonthViewSettings(
          showAgenda: true,
          appointmentDisplayMode: MonthAppointmentDisplayMode.none,
          agendaViewHeight: Get.height * 0.4,
          agendaItemHeight: 170,
        ),
        showNavigationArrow: true,
      ),
    );
  }
}
