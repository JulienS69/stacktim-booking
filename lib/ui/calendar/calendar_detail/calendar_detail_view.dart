import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:stacktim_booking/ui/calendar/calendar_detail/calendar_detail_view_controller.dart';
import 'package:stacktim_booking/widget/x_booking_detail.dart';
import 'package:stacktim_booking/widget/x_loader_stacktim.dart';

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
          title: DateFormat.yMMMEd().format(controller.dateTimeSelected),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 5,
                itemBuilder: (context, index) {
                  return BookingDetail(
                    bookingDate: "14 Janvier 2023",
                    bookingTitle: "Training CSGO & Rocket League",
                    fullName: "Dheeraj TILHOO",
                    nickName: 'DHEEDHEE',
                    isCurrentUser: false,
                  );
                },
              ),
              const SizedBox(
                height: 100,
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
