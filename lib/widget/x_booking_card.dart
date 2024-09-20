import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stacktim_booking/helper/color.dart';
import 'package:stacktim_booking/helper/date_time_helper.dart';
import 'package:stacktim_booking/helper/functions.dart';
import 'package:stacktim_booking/helper/strings.dart';
import 'package:stacktim_booking/navigation/route.dart';

import '../logic/models/booking/booking.dart';
import 'x_chevron.dart';

class XBookingCard extends StatelessWidget {
  const XBookingCard({
    super.key,
    required this.currentBooking,
    required this.isInProgress,
    required this.userId,
    required this.isCheckedIn,
    this.onTapCheckout,
    this.hue,
  });

  final Booking currentBooking;
  final bool isInProgress;
  final double? hue;
  final String? userId;
  final bool? isCheckedIn;
  final void Function()? onTapCheckout;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        isInProgress ||
                (currentBooking.isCheckoutComplete != true &&
                    currentBooking.status?.slug == StatusSlugs.passee)
            ? const Padding(
                padding: EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Lorsque ta session est terminée, il est nécessaire de bien confirmer la fin de celle-ci en cliquant sur le bouton ci-dessous, sinon tu risques de recevoir des pénalités. 😬',
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              )
            : const SizedBox.shrink(),
        //STUB - CARD
        Stack(
          children: [
            InkWell(
              onTap: () {
                Get.toNamed(
                  Routes.bookingDetail,
                  arguments: {
                    "bookingId": currentBooking.id,
                    "currentUserId": userId
                  },
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
                          : (currentBooking.isCheckoutComplete != true &&
                                  currentBooking.status?.slug ==
                                      StatusSlugs.passee)
                              ? Colors.red[500]!
                              : Colors.grey[500]!,
                      blurRadius: isInProgress ? 60 : 10,
                      blurStyle: BlurStyle.outer,
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          currentBooking.title != null
                              ? currentBooking.title!
                              : currentBooking.game?.label ?? "Aucun titre",
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
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
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 35.0, top: 30),
                  child: Align(
                    alignment: Alignment.topRight,
                    child: Visibility(
                      visible:
                          currentBooking.game?.media?.first.originalUrl != null,
                      child: TweenAnimationBuilder<double>(
                        tween: Tween<double>(begin: 0.0, end: 1.0),
                        duration: const Duration(seconds: 2),
                        curve: Curves.easeInOut,
                        builder: (context, value, child) {
                          return Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5.0),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.white.withOpacity(0.8),
                                  blurRadius: value * 15,
                                  spreadRadius: value * 3,
                                ),
                              ],
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(5.0),
                              child: SizedBox(
                                height: 35,
                                child: CachedNetworkImage(
                                  imageUrl: currentBooking
                                          .game?.media?.first.originalUrl ??
                                      "",
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
        //STUB - BUTTON END SESSION
        isInProgress ||
                (currentBooking.isCheckoutComplete != true &&
                    currentBooking.status?.slug == StatusSlugs.passee)
            ? GestureDetector(
                onTap: () {
                  if (onTapCheckout != null) {
                    onTapCheckout!();
                  }
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

void showPhotoDialog(
  BuildContext context,
  void Function() onTap,
  bool isCheckedIn,
) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) => PopScope(
      canPop: isCheckedIn,
      onPopInvoked: (s) {
        AwesomeDialog(
          context: context,
          dialogType: DialogType.warning,
          dialogBackgroundColor: backgroundColor,
          animType: AnimType.rightSlide,
          title: 'Attention',
          desc:
              "Tu dois prendre la photo de ta place (de ton setup) avant de jouer",
          btnOkText: 'Retour',
          btnOkOnPress: () {},
          btnOkColor: Colors.black,
        ).show();
      },
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          AwesomeDialog(
            context: context,
            dialogType: DialogType.warning,
            dialogBackgroundColor: backgroundColor,
            animType: AnimType.rightSlide,
            title: 'Attention',
            desc:
                "Tu dois prendre la photo de ta place (de ton setup) avant de jouer",
            btnOkText: 'Retour',
            btnOkOnPress: () {},
            btnOkColor: Colors.black,
          ).show();
        },
        child: Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              color: backgroundColor,
            ),
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                InkWell(
                  onTap: () {
                    onTap();
                  },
                  child: Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Image.asset(camera),
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  "Ta session a commencé, il est nécessaire de prendre une photo de ta place avant de commencer à jouer",
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 15,
                ),
                ElevatedButton(
                  onPressed: () async {
                    onTap();
                  },
                  child: const Text('Prendre ma photo'),
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}
