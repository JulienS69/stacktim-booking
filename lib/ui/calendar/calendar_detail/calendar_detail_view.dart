import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stacktim_booking/helper/functions.dart';
import 'package:stacktim_booking/logic/models/user/user.dart';
import 'package:stacktim_booking/ui/calendar/calendar_detail/calendar_detail_view_controller.dart';
import 'package:stacktim_booking/widget/x_booking_detail.dart';
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
        body: SingleChildScrollView(
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
        ),
        bottomSheet: Container(
          color: Colors.black,
          width: double.infinity,
          height: 100,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                const Text(
                  'La salle dispose encore de 8 places à cette date.',
                  style: TextStyle(color: Colors.white),
                ),
                FilledButton(
                  onPressed: () {},
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
