import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
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
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';

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
        onPressed: () {
          const double pageBreakpoint = 768.0;
          WoltModalSheet.show<void>(
            pageIndexNotifier: pageIndexNotifier,
            context: context,
            pageListBuilder: (modalSheetContext) {
              return [
                scrollDatePicker(
                  modalSheetContext: modalSheetContext,
                  pageIndexNotifier: pageIndexNotifier,
                ),
                datePicker2(
                  modalSheetContext: modalSheetContext,
                  pageIndexNotifier: pageIndexNotifier,
                )
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
        (state) => Column(
          children: [
            StackCredit(controller: controller),
            SearchBarReservation(controller: controller),
            ChipFilter(controller: controller),
            Expanded(
              child: ReservationListing(
                controller: controller,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

SliverWoltModalSheetPage scrollDatePicker({
  required BuildContext modalSheetContext,
  required ValueNotifier pageIndexNotifier,
}) {
  DashboardViewController controller = DashboardViewController();
  const double pagePadding = 16.0;
  const double bottomPaddingForButton = 150.0;
  return WoltModalSheetPage(
    forceMaxHeight: true,
    topBarTitle: Text(
      "Réservation de la salle",
      style: titleArvo.copyWith(fontSize: 18),
    ),
    backgroundColor: backgroundColorSheet,
    hasSabGradient: false,
    isTopBarLayerAlwaysVisible: true,
    leadingNavBarWidget: IconButton(
        padding: const EdgeInsets.all(pagePadding),
        icon: const Icon(Icons.close),
        onPressed: () {
          if (!controller.checkFormIsEmpty()) {
            AwesomeDialog(
              context: modalSheetContext,
              dialogType: DialogType.question,
              dialogBackgroundColor: backgroundColor,
              animType: AnimType.rightSlide,
              title: 'Attention',
              desc:
                  'Voulez-vous vraiment supprimer les informations que vous avez saisies ?',
              btnOkText: 'Oui',
              btnCancelText: 'Annuler',
              btnCancelOnPress: () {},
              btnOkOnPress: () {
                Navigator.of(modalSheetContext).pop();
              },
            ).show();
          } else {
            Navigator.of(modalSheetContext).pop();
          }
        }),
    trailingNavBarWidget: IconButton(
      padding: const EdgeInsets.all(pagePadding),
      icon: const Icon(Icons.check),
      onPressed: () {
        Navigator.of(modalSheetContext).pop();
      },
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
          BookingTitle(
            controller: controller,
            modalSheetContext: modalSheetContext,
          ),
          BookingDatePicker(controller: controller),
          const SizedBox(
            height: 20,
          ),
          Obx(
            () => controller.timeSelected.isNotEmpty
                ? InkWell(
                    onTap: () {
                      controller.showTimePicker(modalSheetContext);
                    },
                    child: Row(
                      children: [
                        const Text(
                          "Horraire choisie : ",
                          style: TextStyle(
                              color: Colors.white, fontFamily: 'ArvoBold'),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          "${controller.hourSelected} heures et ${controller.minutesSelected} minutes",
                          style: const TextStyle(
                            color: Colors.white60,
                            decoration: TextDecoration.underline,
                            fontFamily: 'ArvoBold',
                          ),
                        ),
                        const Spacer(),
                        const Padding(
                          padding: EdgeInsets.only(right: 15.0),
                          child: Icon(
                            Icons.schedule,
                            color: Colors.white,
                          ),
                        )
                      ],
                    ),
                  )
                : const SizedBox.shrink(),
          )
        ],
      ),
    ),
    stickyActionBar: const Padding(
      padding: EdgeInsets.all(pagePadding),
      child: Column(
        children: [
          // ElevatedButton(
          //   onPressed: () {
          //     HapticFeedback.vibrate();
          //     pageIndexNotifier.value = pageIndexNotifier.value + 1;
          //   },
          //   child: const SizedBox(
          //     height: buttonHeight,
          //     width: double.infinity,
          //     child: Center(
          //         child: Text(
          //       "J'ai choisi ma date !",
          //     )),
          //   ),
          // ),
        ],
      ),
    ),
  );
}

class BookingDatePicker extends StatelessWidget {
  const BookingDatePicker({
    super.key,
    required this.controller,
  });

  final DashboardViewController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 10,
        ),
        Obx(() => Row(
              children: [
                const Text(
                  "Date choisie : ",
                  style: TextStyle(color: Colors.white, fontFamily: 'ArvoBold'),
                ),
                const SizedBox(
                  width: 5,
                ),
                controller.dateSelected.isNotEmpty
                    ? InkWell(
                        onTap: () {
                          if (controller.isShowingDatePicker.value) {
                            controller.isShowingDatePicker.value = false;
                          } else {
                            controller.isShowingDatePicker.value = true;
                          }
                        },
                        child: Text(
                          controller.dateSelected.value.capitalizeFirst!,
                          style: const TextStyle(
                            color: Colors.white60,
                            decoration: TextDecoration.underline,
                            fontFamily: 'ArvoBold',
                          ),
                        ),
                      )
                    : const SizedBox.shrink(),
                controller.dateSelected.isNotEmpty
                    ? const Spacer()
                    : const SizedBox.shrink(),
                controller.dateSelected.isNotEmpty
                    ? InkWell(
                        onTap: () {
                          if (controller.isShowingDatePicker.value) {
                            controller.isShowingDatePicker.value = false;
                          } else {
                            controller.isShowingDatePicker.value = true;
                          }
                        },
                        overlayColor:
                            const MaterialStatePropertyAll(Colors.transparent),
                        child: const Padding(
                          padding: EdgeInsets.only(right: 15.0),
                          child: Icon(
                            Icons.date_range,
                            color: Colors.white,
                          ),
                        ),
                      )
                    : const SizedBox.shrink()
              ],
            )),
        const SizedBox(
          height: 20,
        ),
        Obx(
          () => controller.isShowingDatePicker.value
              ? SfDateRangePicker(
                  controller: controller.dateController,
                  selectionMode: DateRangePickerSelectionMode.single,
                  monthViewSettings: const DateRangePickerMonthViewSettings(
                    weekendDays: [
                      DateTime.sunday,
                      DateTime.saturday,
                    ],
                  ),
                  monthCellStyle: const DateRangePickerMonthCellStyle(
                    weekendTextStyle: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  selectionColor: Colors.red,
                  selectionTextStyle: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                  onSelectionChanged: (date) async {
                    await controller.checkDateAvalaible(date.value, context);
                  },
                  showNavigationArrow: true,
                )
              : const SizedBox.shrink(),
        ),
        Obx(
          () => SizedBox(
            height: 50,
            width: 200,
            child: controller.isShowLoading.value ||
                    !controller.isDatePicked.value
                ? ElevatedButton(
                    onPressed: () async {
                      if (controller.isShowingDatePicker.value) {
                        controller.isShowingDatePicker.value = false;
                      } else {
                        controller.isShowingDatePicker.value = true;
                      }
                    },
                    style: const ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(Colors.black),
                    ),
                    child: !controller.isDatePicked.value &&
                            !controller.isShowLoading.value
                        ? const Text(
                            'Selectionner une date',
                            style: TextStyle(color: Colors.white),
                          )
                        : controller.isShowLoading.value
                            ? Stack(
                                alignment: Alignment.center,
                                children: [
                                  const CircularProgressIndicator(
                                    backgroundColor: Colors.white,
                                  ),
                                  Image.asset(
                                    logo,
                                    height: 15,
                                  )
                                ],
                              )
                            : const SizedBox.shrink(),
                  )
                : const SizedBox.shrink(),
          ),
        ),
      ],
    );
  }
}

class BookingTitle extends StatelessWidget {
  BuildContext modalSheetContext;
  BookingTitle({
    super.key,
    required this.modalSheetContext,
    required this.controller,
  });

  final DashboardViewController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          cursorColor: grey13,
          autofocus: true,
          textAlign: TextAlign.center,
          keyboardAppearance: Brightness.dark,
          maxLength: 32,
          onTapOutside: (d) {
            FocusScope.of(modalSheetContext).requestFocus(FocusNode());
          },
          decoration: const InputDecoration(
            hintText: 'Titre de la réservation',
            hintStyle: TextStyle(
              color: Colors.white,
              fontFamily: 'ArvoBold',
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.black, width: 0.0),
            ),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.black, width: 0.0),
            ),
          ),
          style: const TextStyle(
            color: Colors.green,
            fontFamily: 'ArvoBold',
            decoration: TextDecoration.none,
          ),
          onChanged: (value) {},
          controller: controller.titleController,
        ),
        const SizedBox(
          height: 15,
        ),
      ],
    );
  }
}

SliverWoltModalSheetPage datePicker2({
  required BuildContext modalSheetContext,
  required ValueNotifier pageIndexNotifier,
}) {
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
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
