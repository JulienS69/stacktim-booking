import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
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
    this.hue,
  });

  final Booking currentBooking;
  final bool isInProgress;
  final double? hue;
  final String? userId;

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
                              currentBooking.status?.slug == StatusSlugs.passee)
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
        isInProgress ||
                (currentBooking.isCheckoutComplete != true &&
                    currentBooking.status?.slug == StatusSlugs.passee)
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

void showPhotoDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) => PopScope(
      canPop: false,
      onPopInvoked: (s) {
        // AwesomeDialog(
        //   context: context,
        //   dialogType: DialogType.warning,
        //   dialogBackgroundColor: backgroundColor,
        //   animType: AnimType.rightSlide,
        //   title: 'Attention',
        //   desc:
        //       "Tu dois prendre la photo de ta place (de ton setup) avant de jouer",
        //   btnOkText: 'Retour',
        //   btnOkOnPress: () {},
        //   btnOkColor: Colors.black,
        // ).show();
      },
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          // AwesomeDialog(
          //   context: context,
          //   dialogType: DialogType.warning,
          //   dialogBackgroundColor: backgroundColor,
          //   animType: AnimType.rightSlide,
          //   title: 'Attention',
          //   desc: "Tu dois prendre la photo de ta place (de ton setup) avant de jouer",
          //   btnOkText: 'Retour',
          //   btnOkOnPress: () {},
          //   btnOkColor: Colors.black,
          // ).show();
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
                  onTap: () async {
                    final ImagePicker picker = ImagePicker();
                    //TODO LAUNCH CAMERA PICKER
                    final XFile? photo =
                        await picker.pickImage(source: ImageSource.camera);
                    //TODO APRES LA REQUETE
                    // controller.isCheckInTime.value = false
                    //  bookingIdToChecking = "";
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
                    //TODO Mettre en place la requête
                    final ImagePicker picker = ImagePicker();
                    //TODO LAUNCH CAMERA PICKER
                    final XFile? photo = await picker.pickImage(
                        source: ImageSource.camera,
                        requestFullMetadata: false,
                        imageQuality: 80);
                    //TODO APRES LA REQUETE
                    // controller.isCheckInTime.value = false
                    //  bookingIdToChecking = "";
                    // refresh la liste de booking (onInit())
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
