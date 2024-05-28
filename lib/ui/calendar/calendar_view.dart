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
      bottomKey: controller.calendardButtonKey,
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
              ), (state) {
        controller.showTutorialOnDashboard(context);
        return Column(
          children: [
            Expanded(
              flex: 3,
              child: SfCalendar(
                view: CalendarView.month,
                todayHighlightColor: Colors.transparent,
                blackoutDates: controller.holidaysList,
                blackoutDatesTextStyle: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w300,
                  color: Color.fromARGB(255, 83, 83, 83),
                ),
                firstDayOfWeek: 1,
                initialDisplayDate: DateTime.now(),
                headerStyle: const CalendarHeaderStyle(
                  backgroundColor: Colors.transparent,
                  textAlign: TextAlign.center,
                ),
                dataSource: XCalendarDataSource(controller.bookingList),
                todayTextStyle: const TextStyle(color: Colors.white),
                onViewChanged: (viewChangedDetails) {
                  controller.getMonthlyBookings(
                    viewChangedDetails.visibleDates.first.month,
                  );
                },
                minDate: DateTime(2024),
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
                                color: redChip,
                              ),
                            )
                          : (details.appointments.isNotEmpty &&
                                  details.appointments.length < 5)
                              ? Text(
                                  '${details.date.day}',
                                  style: const TextStyle(
                                    color: blueChip,
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
            Padding(
              padding: const EdgeInsets.only(left: 18, right: 18, bottom: 18),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(18)),
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        'Légende :',
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Container(
                            width: 15,
                            height: 15,
                            decoration: BoxDecoration(
                              color: redChip,
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          const Expanded(
                            child: Text(
                              'Journée avec de nombreuses sessions',
                              style: TextStyle(
                                color: redChip,
                                overflow: TextOverflow.ellipsis,
                              ),
                              maxLines: 2,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          Container(
                            width: 15,
                            height: 15,
                            decoration: BoxDecoration(
                              color: blueChip,
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          const Expanded(
                            child: Text(
                              'Journée avec peu de sessions',
                              style: TextStyle(
                                color: blueChip,
                                overflow: TextOverflow.ellipsis,
                              ),
                              maxLines: 2,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          Container(
                            width: 15,
                            height: 15,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          const Expanded(
                            child: Text(
                              'Journée sans sessions',
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
        );
      }),
    );
  }
}
