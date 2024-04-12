import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
// import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stacktim_booking/helper/strings.dart';
import 'package:stacktim_booking/ui/dashboard/dashboard_view_controller.dart';
import 'package:stacktim_booking/ui/dashboard/section/body/booking_listing.dart';
import 'package:stacktim_booking/ui/dashboard/section/body/empty_booking.dart';
import 'package:stacktim_booking/ui/dashboard/section/header/booking_search_bar.dart';
import 'package:stacktim_booking/ui/dashboard/section/header/stack_credit.dart';
import 'package:stacktim_booking/ui/new_booking/new_booking_view.dart';
import 'package:stacktim_booking/widget/x_app_bar.dart';
import 'package:stacktim_booking/widget/x_error_page.dart';
import 'package:stacktim_booking/widget/x_loader_stacktim.dart';
import 'package:stacktim_booking/widget/x_mobile_scaffold.dart';

class DashboardView extends GetView<DashboardViewController> {
  const DashboardView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return XMobileScaffold(
      bottomNavIndex: 0,
      gapLocation: GapLocation.end,
      floatingActionButton: FloatingActionButton(
        key: controller.fabButtonKey,
        onPressed: () {
          controller.checkCreditBeforeCreateBooking();
        },
        backgroundColor: Colors.black,
        child: Image.asset(
          logo,
          height: 35,
        ),
      ),
      appBar: const XPageHeader(
        title: '',
        imagePath: logoOverSlug,
      ),
      body: controller.obx(
        onLoading: const XLoaderStacktim(),
        onError: (error) => XErrorPage(
          contentTitle:
              "Une erreur s'est produite lors de la récupération de tes sessions",
          onPressedRetry: () {
            //TODO RETRY LES REQUÊTES
          },
        ),
        (state) {
          controller.showTutorialOnDashboard(context);
          return Column(
            children: [
              StackCredit(
                controller: controller,
              ),
              Obx(
                () => controller.bookingList.isNotEmpty
                    ? BookingSearchBar(controller: controller)
                    : const SizedBox.shrink(),
              ),
              //SECTION - FILTERS
              // controller.bookingList.isNotEmpty
              //     ? BookingFilter(controller: controller)
              //     : const SizedBox.shrink(),
              Obx(() => controller.bookingList.isNotEmpty
                  ? Expanded(
                      child: BookingListing(
                        controller: controller,
                      ),
                    )
                  : EmptyBooking(
                      onPressed: () {
                        NewBookingSheet(controller: controller).showModalSheet(
                            context, controller.pageIndexNotifier);
                      },
                    )),
            ],
          );
        },
      ),
    );
  }
}
