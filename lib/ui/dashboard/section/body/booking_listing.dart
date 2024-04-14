import 'dart:async';

import 'package:flutter/material.dart';
import 'package:stacktim_booking/helper/functions.dart';
import 'package:stacktim_booking/logic/models/booking/booking.dart';
import 'package:stacktim_booking/ui/dashboard/dashboard_view_controller.dart';
import 'package:stacktim_booking/widget/x_booking_card.dart';

class BookingListing extends StatefulWidget {
  const BookingListing({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final DashboardViewController controller;

  @override
  BookingListingState createState() => BookingListingState();
}

class BookingListingState extends State<BookingListing> {
  Timer? timer;
  double hue = 0.0; // Début avec la couleur rouge

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  void _startTimer() {
    timer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      setState(() {
        hue += 2.0;
        if (hue >= 240.0) {
          // Arrêter à la couleur noire (qui est à 240°)
          hue = 0.0; // Revenir à la couleur rouge
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
            ? XBookingCard(
                currentBooking: currentBooking,
                isInProgress: isInProgress,
                userId: widget.controller.currentUser.id ?? "0",
              )
            : XBookingCard(
                currentBooking: currentBooking,
                isInProgress: true,
                hue: hue,
                userId: widget.controller.currentUser.id ?? "0",
              );
      },
    );
  }
}
