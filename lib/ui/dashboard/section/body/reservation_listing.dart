import 'package:flutter/material.dart';
import 'package:stacktim_booking/helper/date_time_helper.dart';
import 'package:stacktim_booking/logic/models/booking/booking.dart';
import 'package:stacktim_booking/ui/dashboard/dashboard_view_controller.dart';
import 'package:stacktim_booking/widget/x_chevron.dart';

class ReservationListing extends StatelessWidget {
  const ReservationListing({
    super.key,
    required this.controller,
  });

  final DashboardViewController controller;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: controller.bookingList.length,
      itemBuilder: (context, index) {
        Booking currentBooking = controller.bookingList[index];
        return Container(
          margin: const EdgeInsets.all(20.0),
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(20)),
            boxShadow: [
              BoxShadow(
                color: Colors.grey[500]!,
                blurRadius: 10,
                blurStyle: BlurStyle.outer,
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                currentBooking.title ?? "Aucun titre",
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 8.0),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      currentBooking.duration != null
                          ? currentBooking.duration! > 1
                              ? 'Stack crédit utilisé : ${currentBooking.duration ?? 0} unités'
                              : 'Stack crédit utilisé : ${currentBooking.duration ?? 0} unité'
                          : "Aucun crédit utilisé",
                      style: const TextStyle(
                        color: Colors.white70,
                        overflow: TextOverflow.clip,
                      ),
                    ),
                  ),
                  controller
                      .getChipByStatusTag(currentBooking.status?.slug ?? ""),
                  const SizedBox(
                    width: 10,
                  ),
                  Chevron(
                    direction: ChevronDirection.right,
                    size: 10.0,
                    color: controller.getColorsByStatusTag(
                      statusTag: currentBooking.status?.slug ?? "",
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      formatDateAndTime(
                          beginAt: currentBooking.beginAt ?? "",
                          bookedAt: currentBooking.bookedAt ?? "",
                          endAt: currentBooking.endAt ?? ""),
                      style: const TextStyle(
                        color: Colors.white70,
                        overflow: TextOverflow.clip,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
