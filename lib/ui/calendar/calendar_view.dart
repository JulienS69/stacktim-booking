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
      body: Column(
        children: [
          Expanded(
            flex: 3,
            child: SfCalendar(
              view: CalendarView.month,
              cellBorderColor: Colors.transparent,
              monthViewSettings: MonthViewSettings(
                dayFormat: 'EEE',
                appointmentDisplayMode: MonthAppointmentDisplayMode.none,
                agendaViewHeight: Get.height * 0.3,
                agendaItemHeight: 170,
              ),
              showNavigationArrow: true,
            ),
          ),
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.only(left: 18,right: 18,bottom: 18),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(18)),
                height: 300,
                width: double.infinity,
              ),
            ),
          )
        ],
      ),
    );
  }
}
