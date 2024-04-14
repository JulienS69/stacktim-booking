import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stacktim_booking/helper/color.dart';
import 'package:stacktim_booking/helper/strings.dart';
import 'package:stacktim_booking/logic/models/calendar_data_source/calendar_data_source.dart';
import 'package:stacktim_booking/navigation/route.dart';
import 'package:stacktim_booking/ui/calendar/calendar_view_controller.dart';
import 'package:stacktim_booking/widget/x_app_bar.dart';
import 'package:stacktim_booking/widget/x_error_page.dart';
import 'package:stacktim_booking/widget/x_loader_stacktim.dart';
import 'package:stacktim_booking/widget/x_mobile_scaffold.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class CalendarPage extends GetView<CalendarViewController> {
  const CalendarPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return XMobileScaffold(
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
        title: '',
        centerTitle: true,
        imagePath: logoOverSlug,
      ),
      body: controller.obx(
        onLoading: const XLoaderStacktim(),
        onError: (error) => XErrorPage(
          contentTitle:
              "Une erreur s'est produite lors de la récupération du calendrier",
          onPressedRetry: () {
            controller.onInit();
          },
          bottomNavIndex: 1,
        ),
        (state) => Column(
          children: [
            Expanded(
              flex: 3,
              child: SfCalendar(
                view: CalendarView.month,
                todayHighlightColor: Colors.transparent,
                allowedViews: const [
                  CalendarView.month,
                ],
                firstDayOfWeek: 1,
                initialDisplayDate: DateTime.now(),
                headerStyle: const CalendarHeaderStyle(
                  backgroundColor: Colors.transparent,
                ),
                dataSource: XCalendarDataSource(controller.bookingList),
                todayTextStyle: const TextStyle(color: Colors.white),
                onViewChanged: (viewChangedDetails) {
                  controller.getMonthlyBookings(
                    viewChangedDetails.visibleDates.first.month,
                  );
                },
                onTap: (calendarTapDetails) {
                  Get.toNamed(
                    Routes.calendarDetail,
                    arguments: {
                      'date': calendarTapDetails.date,
                      'calendarTapDetails': calendarTapDetails
                    },
                  );
                },
                monthCellBuilder: (context, details) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      details.appointments.length >= 5
                          ? Text(
                              '${details.date.day}',
                              style: const TextStyle(
                                color: redStackTim,
                              ),
                            )
                          : (details.appointments.isNotEmpty &&
                                  details.appointments.length < 5)
                              ? Text(
                                  '${details.date.day}',
                                  style: const TextStyle(
                                    color: Colors.blue,
                                  ),
                                )
                              : Text(
                                  '${details.date.day}',
                                  style: const TextStyle(
                                    color: Colors.white,
                                  ),
                                )
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
            Padding(
              padding: const EdgeInsets.only(left: 18, right: 18, bottom: 18),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(18)),
                width: double.infinity,
                child: const Padding(
                  padding: EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Légende',
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          Text(
                            'Jour avec beaucoup de session',
                            style: TextStyle(
                              color: redStackTim,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          Text(
                            'Jour avec peu de session',
                            style: TextStyle(
                              color: blueChip,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              'Jour sans session',
                              style: TextStyle(
                                overflow: TextOverflow.ellipsis,
                              ),
                              maxLines: 2,
                            ),
                          ),
                        ],
                      ),
                    ],
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
