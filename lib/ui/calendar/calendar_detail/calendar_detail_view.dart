import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stacktim_booking/helper/functions.dart';
import 'package:stacktim_booking/helper/style.dart';
import 'package:stacktim_booking/logic/models/user/user.dart';
import 'package:stacktim_booking/navigation/route.dart';
import 'package:stacktim_booking/ui/calendar/calendar_detail/calendar_detail_view_controller.dart';
import 'package:stacktim_booking/widget/x_booking_detail.dart';
import 'package:stacktim_booking/widget/x_error_page.dart';
import 'package:stacktim_booking/widget/x_loader_stacktim.dart';

import '../../../logic/models/booking/booking.dart';
import '../../../widget/x_app_bar.dart';
import '../../../widget/x_mobile_scaffold.dart';

class CalendarDetailView extends GetView<CalendarDetailViewController> {
  const CalendarDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    return controller.obx(
      onLoading: const XLoaderStacktim(),
      (state) => XMobileScaffold(
        isShowBottomNavigationBar: false,
        appBar: XPageHeader(
          title: formatDateInLocal(
            datePicked: controller.dateTimeSelected.toString(),
          ),
          centerTitle: true,
        ),
        body: controller.bookings.isNotEmpty
            ? SingleChildScrollView(
                child: Column(
                  children: [
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: controller.bookings.length,
                      itemBuilder: (context, index) {
                        Booking booking = controller.bookings[index];
                        return BookingDetail(
                          bookingDate: formatDateInLocal(
                              datePicked: booking.bookedAt.toString()),
                          bookingTitle: booking.title ?? '',
                          fullName: booking.user?.fullName ?? '',
                          nickName: booking.user?.nickName ?? 'Aucun pseudo',
                          isCurrentUser: false,
                          userMail: booking.user?.email ?? "",
                          startedBookingHourPicked:
                              booking.beginAt?.substring(0, 5) ?? "",
                          endedBookingHourPicked:
                              booking.endAt?.substring(0, 5) ?? "",
                          computerSelected: booking.computer?.number ?? 0,
                        );
                      },
                    ),
                    const SizedBox(
                      height: 120,
                    )
                  ],
                ),
              )
            : XErrorPage(
                contentTitle: controller.isPassed
                    ? "Il n'est plus possible de réserver une session à cette date"
                    : "Aucune session réservée pour ce jour.",
                showRetryButton: false,
                onPressedRetry: () {},
              ),
        bottomSheet: Container(
          color: Colors.black,
          width: double.infinity,
          height: controller.isPassed ? 80 : 100,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: controller.isPassed
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Row(
                          children: [
                            Expanded(
                              child: Container(
                                decoration: const BoxDecoration(),
                                height: 60,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(
                                      Icons.arrow_circle_left_outlined,
                                      color: Colors.white,
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      "Revenir au calendrier",
                                      style: antaStyle.copyWith(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                : Column(
                    children: [
                      const Row(
                        children: [
                          Expanded(
                            child: Text(
                              "Il est encore temps de réserver ta session.",
                              style: TextStyle(color: Colors.white),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      FilledButton(
                        onPressed: () {
                          Get.offAllNamed(
                            Routes.dashboard,
                            arguments: {
                              'openSheet': true,
                            },
                          );
                        },
                        child: const Text(
                          'Réserver ma place',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
