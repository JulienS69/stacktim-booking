import 'package:flutter/material.dart';
import 'package:stacktim_booking/ui/dashboard/dashboard_view_controller.dart';
import 'package:stacktim_booking/ui/new_booking/first_sheet/booking_schedule.dart';
import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';

import 'second_sheet/seat_picker.dart';
import 'third_sheet/booking_summary.dart';

class NewBookingSheet {
  final DashboardViewController controller;

  NewBookingSheet({
    required this.controller,
  });

  Future<void> showModalSheet(
      BuildContext context, ValueNotifier<int> pageIndexNotifier) async {
    const double pageBreakpoint = 768.0;
    WoltModalSheet.show<void>(
      pageIndexNotifier: pageIndexNotifier,
      context: context,
      pageListBuilder: (modalSheetContext) {
        return [
          bookingSchedule(
            modalSheetContext: modalSheetContext,
            pageIndexNotifier: pageIndexNotifier,
          ),
          seatPicker(
            modalSheetContext: modalSheetContext,
            pageIndexNotifier: pageIndexNotifier,
            controller: controller,
          ),
          bookingSummary(
            controller: controller,
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
  }
}
