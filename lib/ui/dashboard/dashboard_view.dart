import 'dart:developer';

import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:scroll_date_picker/scroll_date_picker.dart';
import 'package:stacktim_booking/helper/color.dart';
import 'package:stacktim_booking/helper/strings.dart';
import 'package:stacktim_booking/helper/style.dart';
import 'package:stacktim_booking/ui/dashboard/dashboard_view_controller.dart';
import 'package:stacktim_booking/ui/dashboard/section/body/reservation_listing.dart';
import 'package:stacktim_booking/ui/dashboard/section/header/chip_filter.dart';
import 'package:stacktim_booking/ui/dashboard/section/header/search_bar_reservation.dart';
import 'package:stacktim_booking/ui/dashboard/section/header/stack_credit.dart';
import 'package:stacktim_booking/widget/x_app_bar.dart';
import 'package:stacktim_booking/widget/x_mobile_scaffold.dart';
import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';

class DashboardView extends GetView<DashboardViewController> {
  const DashboardView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final pageIndexNotifier = ValueNotifier(0);
    SliverWoltModalSheetPage datePicker(BuildContext modalSheetContext) {
      DashboardViewController controller = DashboardViewController();
      Rx<DateTime> selectedDate = DateTime.now().obs;
      const double pagePadding = 16.0;
      const double buttonHeight = 56.0;
      const double bottomPaddingForButton = 150.0;
      return WoltModalSheetPage(
        topBarTitle: Text(
          "Réservation de la salle",
          style: titleArvo.copyWith(fontSize: 18),
        ),
        backgroundColor: backgroundColor,
        hasSabGradient: false,
        isTopBarLayerAlwaysVisible: true,
        trailingNavBarWidget: IconButton(
          padding: const EdgeInsets.all(pagePadding),
          icon: const Icon(Icons.close),
          onPressed: Navigator.of(modalSheetContext).pop,
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
            pagePadding,
            pagePadding,
            pagePadding,
            bottomPaddingForButton,
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    "Etape 1 : ",
                    style: titleArvo.copyWith(
                      fontSize: 18,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                  Text(
                    "Selectionner une date",
                    style: titleArvo.copyWith(
                      fontSize: 16,
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 250,
                child: Obx(
                  () => ScrollDatePicker(
                    selectedDate: selectedDate.value,
                    options: const DatePickerOptions(
                      backgroundColor: Colors.transparent,
                    ),
                    locale: const Locale('fr'),
                    onDateTimeChanged: (DateTime value) {
                      controller.checkIsFree(value.toString());
                      log(value.toLocal().toString());
                      HapticFeedback.vibrate();
                      selectedDate.value = value;
                    },
                  ),
                ),
              ),
              Obx(
                () => controller.isNotFree.value
                    ? Padding(
                        padding: const EdgeInsets.only(top: 15.0),
                        child: Text(
                          "La date choisie est déjà pleine !",
                          style: titleArvo.copyWith(
                            fontSize: 14,
                            color: redChip,
                          ),
                        ),
                      )
                    : const SizedBox.shrink(),
              )
            ],
          ),
        ),
        stickyActionBar: Padding(
          padding: const EdgeInsets.all(pagePadding),
          child: Column(
            children: [
              ElevatedButton(
                onPressed: () {
                  HapticFeedback.vibrate();
                  pageIndexNotifier.value = pageIndexNotifier.value + 1;
                },
                child: const SizedBox(
                  height: buttonHeight,
                  width: double.infinity,
                  child: Center(
                      child: Text(
                    "J'ai choisi ma date !",
                  )),
                ),
              ),
            ],
          ),
        ),
      );
    }

    SliverWoltModalSheetPage datePicker2(BuildContext modalSheetContext) {
      const double pagePadding = 16.0;
      const double buttonHeight = 56.0;
      const double bottomPaddingForButton = 150.0;
      return WoltModalSheetPage(
        topBarTitle: Text(
          "Réservation de la salle",
          style: titleArvo.copyWith(fontSize: 18),
        ),
        backgroundColor: backgroundColor,
        hasSabGradient: false,
        isTopBarLayerAlwaysVisible: true,
        trailingNavBarWidget: IconButton(
          padding: const EdgeInsets.all(pagePadding),
          icon: const Icon(Icons.close),
          onPressed: Navigator.of(modalSheetContext).pop,
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
            pagePadding,
            pagePadding,
            pagePadding,
            bottomPaddingForButton,
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    "Etape 2 : ",
                    style: titleArvo.copyWith(
                      fontSize: 18,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                  Text(
                    "Selectionner un horaire",
                    style: titleArvo.copyWith(
                      fontSize: 16,
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
        stickyActionBar: Padding(
          padding: const EdgeInsets.all(pagePadding),
          child: Column(
            children: [
              ElevatedButton(
                onPressed: () {
                  HapticFeedback.vibrate();
                  pageIndexNotifier.value = pageIndexNotifier.value - 1;
                },
                child: const SizedBox(
                  height: buttonHeight,
                  width: double.infinity,
                  child: Center(
                      child: Text(
                    "Retour",
                  )),
                ),
              ),
            ],
          ),
        ),
      );
    }

    return XMobileScaffold(
      bottomNavIndex: 0,
      gapLocation: GapLocation.end,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          const double pageBreakpoint = 768.0;
          WoltModalSheet.show<void>(
            pageIndexNotifier: pageIndexNotifier,
            context: context,
            pageListBuilder: (modalSheetContext) {
              return [
                datePicker(
                  modalSheetContext,
                ),
                datePicker2(modalSheetContext)
              ];
            },
            modalTypeBuilder: (context) {
              final size = MediaQuery.of(context).size.width;
              if (size < pageBreakpoint) {
                return WoltModalType.bottomSheet;
              } else {
                return WoltModalType.dialog;
              }
            },
            onModalDismissedWithBarrierTap: () {
              debugPrint('Closed modal sheet with barrier tap');
              Navigator.of(context).pop();
              pageIndexNotifier.value = 0;
            },
            maxDialogWidth: 560,
            minDialogWidth: 400,
            minPageHeight: 0.0,
            maxPageHeight: 0.9,
          );
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
        (state) => SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Column(
            children: [
              StackCredit(controller: controller),
              SearchBarReservation(controller: controller),
              ChipFilter(controller: controller),
              ReservationListing(controller: controller),
            ],
          ),
        ),
      ),
    );
  }
}
