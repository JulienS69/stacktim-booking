import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stacktim_booking/helper/date_time_helper.dart';
import 'package:stacktim_booking/helper/functions.dart';
import 'package:stacktim_booking/logic/models/booking/booking.dart';
import 'package:stacktim_booking/ui/dashboard/dashboard_view_controller.dart';
import 'package:stacktim_booking/widget/x_chevron.dart';

import '../../../../helper/color.dart';
import '../../../../navigation/route.dart';

class ReservationListing extends StatefulWidget {
  const ReservationListing({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final DashboardViewController controller;

  @override
  _ReservationListingState createState() => _ReservationListingState();
}

class _ReservationListingState extends State<ReservationListing> {
  Timer? _timer;
  double _hue = 0.0; // Début avec la couleur rouge

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(milliseconds: 100), (timer) {
      setState(() {
        _hue += 2.0;
        if (_hue >= 240.0) {
          // Arrêter à la couleur noire (qui est à 240°)
          _hue = 0.0; // Revenir à la couleur rouge
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: widget.controller.bookingList.length,
      itemBuilder: (context, index) {
        Booking currentBooking = widget.controller.bookingList[index];
        bool isInProgress =
            currentBooking.status?.slug == StatusSlugs.inProgress;
        return currentBooking.status?.slug != StatusSlugs.inProgress
            ? InkWell(
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
                          widget.controller.getChipByStatusTag(
                              currentBooking.status?.slug ?? ""),
                          const SizedBox(
                            width: 10,
                          ),
                          Chevron(
                            direction: ChevronDirection.right,
                            size: 10.0,
                            color: widget.controller.getColorsByStatusTag(
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
                ))
            : Column(
                children: [
                  const Padding(
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
                  ),
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
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20)),
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
                              widget.controller.getChipByStatusTag(
                                  currentBooking.status?.slug ?? ""),
                              const SizedBox(
                                width: 10,
                              ),
                              Chevron(
                                direction: ChevronDirection.right,
                                size: 10.0,
                                color: widget.controller.getColorsByStatusTag(
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
                  GestureDetector(
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
                            HSLColor.fromAHSL(1.0, _hue, 1.0, 0.5).toColor(),
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
                        child: Text(
                          "J'ai terminé ma session",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              );
      },
    );
  }
}
