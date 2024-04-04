import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stacktim_booking/helper/color.dart';
import 'package:stacktim_booking/helper/strings.dart';
import 'package:stacktim_booking/navigation/route.dart';
import 'package:stacktim_booking/ui/calendar/calendar_view_controller.dart';
import 'package:stacktim_booking/widget/x_app_bar.dart';
import 'package:stacktim_booking/widget/x_loader_stacktim.dart';
import 'package:stacktim_booking/widget/x_mobile_scaffold.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class CalendarPage extends GetView<CalendarViewController> {
  const CalendarPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return controller.obx(
      onLoading: const XLoaderStacktim(),
      (state) => XMobileScaffold(
        bottomNavIndex: 1,
        gapLocation: GapLocation.end,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Get.offAndToNamed(Routes.dashboard, arguments: {
              'openSheet': true,
            });
          },
          backgroundColor: Colors.black,
          child: Image.asset(
            logo,
            height: 35,
          ),
        ),
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
                todayHighlightColor: Colors.transparent,
                todayTextStyle: const TextStyle(color: Colors.white),
                onTap: (calendarTapDetails) {
                  Get.toNamed(
                    Routes.calendarDetail,
                    arguments: {
                      'date': calendarTapDetails.date,
                    },
                  );
                },
                monthCellBuilder: (context, details) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      details.date.day.isEven
                          ? Text(
                              '${details.date.day}',
                              style: const TextStyle(
                                color: redStackTim,
                              ),
                            )
                          : Text(
                              '${details.date.day}',
                              style: const TextStyle(
                                color: Colors.white,
                              ),
                            ),
                    ],
                  );
                },
                selectionDecoration: BoxDecoration(
                  color: Colors.transparent,
                  border: Border.all(
                    color: Colors.transparent,
                  ),
                ),
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
                padding: const EdgeInsets.only(left: 18, right: 18, bottom: 18),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(18)),
                  height: 300,
                  width: double.infinity,
                  child: const Padding(
                    padding: EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Légende',
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Text(
                              '27',
                              style: TextStyle(
                                color: redStackTim,
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              'Session pleine',
                              style: TextStyle(),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Text(
                              '23',
                              style: TextStyle(
                                color: blueChip,
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: Text(
                                'Quelques places encore disponibles',
                                style: TextStyle(
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Text(
                              '20',
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: Text(
                                'Toutes les places sont actuellement libres',
                                style: TextStyle(
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
