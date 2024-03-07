import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
// import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stacktim_booking/helper/strings.dart';
import 'package:stacktim_booking/ui/booking/new_booking_view.dart';
import 'package:stacktim_booking/ui/dashboard/dashboard_view_controller.dart';
import 'package:stacktim_booking/ui/dashboard/section/body/reservation_listing.dart';
import 'package:stacktim_booking/ui/dashboard/section/header/chip_filter.dart';
import 'package:stacktim_booking/ui/dashboard/section/header/search_bar_reservation.dart';
import 'package:stacktim_booking/ui/dashboard/section/header/stack_credit.dart';
import 'package:stacktim_booking/widget/x_app_bar.dart';
import 'package:stacktim_booking/widget/x_mobile_scaffold.dart';

class DashboardView extends GetView<DashboardViewController> {
  const DashboardView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final pageIndexNotifier = ValueNotifier(0);
    return XMobileScaffold(
      bottomNavIndex: 0,
      gapLocation: GapLocation.end,
      floatingActionButton: FloatingActionButton(
        key: controller.fabButtonKey,
        onPressed: () {
          NewBookingSheet().showModalSheet(context, pageIndexNotifier);
        },
        backgroundColor: Colors.black,
        child: Image.asset(
          logo,
          height: 35,
        ),
      ),
      appBar: const XPageHeader(
        title: '',
        imagePath: logo,
      ),
      body: controller.obx(
        (state) {
          controller.showTutorialOnDashboard(context);
          return Column(
            children: [
              StackCredit(
                controller: controller,
              ),
              SearchBarReservation(controller: controller),
              ChipFilter(controller: controller),
              Expanded(
                child: ReservationListing(
                  controller: controller,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
