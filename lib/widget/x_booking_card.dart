import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stacktim_booking/helper/color.dart';
import 'package:stacktim_booking/helper/date_time_helper.dart';
import 'package:stacktim_booking/helper/functions.dart';

import '../logic/models/booking/booking.dart';
import '../navigation/route.dart';
import 'x_chevron.dart';

class XBookingCard extends StatelessWidget {
  const XBookingCard({
    super.key,
    required this.currentBooking,
    required this.isInProgress,
    this.hue,
  });

  final Booking currentBooking;
  final bool isInProgress;
  final double? hue;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        isInProgress
            ? const Padding(
                padding: EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Lorsque ta session est terminée, il est nécessaire de bien confirmer la fin de celle-ci en cliquant sur le bouton ci-dessous, sinon tu risques de perdre des crédits. 😬',
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              )
            : const SizedBox.shrink(),
        //STUB - CARD
        InkWell(
          onTap: () {
            Get.toNamed(
              Routes.bookingDetail,
              arguments: {"bookingId": currentBooking.id},
            );
          },
          focusColor: Colors.transparent,
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent,
          child: Container(
            margin: const EdgeInsets.all(20.0),
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(20)),
              color: cardColor,
              boxShadow: [
                BoxShadow(
                  color: isInProgress
                      ? const Color.fromARGB(255, 34, 97, 36)
                      : Colors.grey[500]!,
                  blurRadius: isInProgress ? 60 : 10,
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
                    getChipByStatusTag(currentBooking.status?.slug ?? ""),
                    const SizedBox(
                      width: 10,
                    ),
                    Chevron(
                      direction: ChevronDirection.right,
                      size: 10.0,
                      color: getColorsByStatusTag(
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
          ),
        ),
        //STUB - BUTTON END SESSION
        isInProgress
            ? GestureDetector(
                onTap: () {
                  // TODO REDIRECT SUR LA PRISE DE PHOTO DE FIN
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 100),
                  width: double.infinity,
                  margin: const EdgeInsets.all(20.0),
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [
                        HSLColor.fromAHSL(1.0, hue ?? 0.0, 1.0, 0.5).toColor(),
                        Colors.black,
                      ],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey[500]!,
                        blurRadius: 10,
                        blurStyle: BlurStyle.outer,
                      ),
                    ],
                  ),
                  child: const Center(
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            "J'ai terminé ma session",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            : const SizedBox.shrink(),
      ],
    );
  }
}
