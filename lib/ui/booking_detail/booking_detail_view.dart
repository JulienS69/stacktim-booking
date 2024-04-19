import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:stacktim_booking/helper/color.dart';
import 'package:stacktim_booking/helper/functions.dart';
import 'package:stacktim_booking/helper/strings.dart';
import 'package:stacktim_booking/logic/models/booking/booking.dart';
import 'package:stacktim_booking/logic/models/user/user.dart';
import 'package:stacktim_booking/ui/booking_detail/booking_detail_view_controller.dart';
import 'package:stacktim_booking/ui/booking_detail/seat_picker_detail.dart';
import 'package:stacktim_booking/widget/x_app_bar.dart';
import 'package:stacktim_booking/widget/x_booking_detail.dart';
import 'package:stacktim_booking/widget/x_error_page.dart';
import 'package:stacktim_booking/widget/x_mobile_scaffold.dart';

class BookingDetailView extends GetView<BookingDetailViewController> {
  const BookingDetailView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return controller.obx(
      onError: (error) => XErrorPage(
        contentTitle:
            "Une erreur s'est produite lors de la récupération du détail de ta session",
        onPressedRetry: () {
          controller.onInit();
        },
        withAppBar: true,
      ),
      onLoading: const Stack(
        children: [
          Positioned(
            top: 80,
            left: 0,
            right: 0,
            child: LinearProgressIndicator(),
          ),
        ],
      ),
      (state) => XMobileScaffold(
        isShowBottomNavigationBar: false,
        appBar: XPageHeader(
          title: controller.currentBooking.value.id != null
              ? controller.currentBooking.value.title ?? ""
              : 'Réservation',
          centerTitle: true,
          imagePath: logoOverSlug,
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Votre session :",
                      style: TextStyle(
                        fontSize: 18,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ],
                ),
              ),
              BookingDetail(
                bookingDate: formatDateInLocal(
                    datePicked:
                        controller.currentBooking.value.bookedAt.toString()),
                bookingTitle: controller.currentBooking.value.title ?? '',
                fullName: controller.currentBooking.value.user?.fullName ?? '',
                nickName: controller.currentBooking.value.user?.nickName ??
                    'Aucun pseudo',
                isCurrentUser: true,
                userMail: controller.currentBooking.value.user?.email ?? "",
                startedBookingHourPicked:
                    controller.currentBooking.value.beginAt?.substring(0, 5) ??
                        "",
                endedBookingHourPicked:
                    controller.currentBooking.value.endAt?.substring(0, 5) ??
                        "",
                computerSelected:
                    controller.currentBooking.value.computer?.number ?? 0,
                isWithSeat: true,
                onTap: () async {
                  await showDialog(
                    context: Get.context!,
                    builder: (BuildContext context) {
                      return SeatPickerDetail(
                        bookingDetailViewController: controller,
                      );
                    },
                  );
                },
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(
                      controller.currentBookingList.isEmpty
                          ? "Aucunes personne n'a réservé de session sur votre crénau"
                          : "D'autres personnes sont présentes dans le même crénau que le votre : ",
                      style: const TextStyle(
                        fontSize: 10,
                        overflow: TextOverflow.ellipsis,
                      ),
                      maxLines: 2,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
              const Divider(
                color: Colors.white,
              ),
              SizedBox(
                height: controller.currentBookingList.isEmpty ? 0 : 15,
              ),
              controller.currentBookingList.isEmpty
                  ? Lottie.asset(
                      notFound,
                      fit: BoxFit.cover,
                      height: 350,
                      repeat: false,
                    )
                  : const SizedBox.shrink(),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: controller.currentBookingList.length,
                itemBuilder: (context, index) {
                  Booking booking = controller.currentBookingList[index];
                  return BookingDetail(
                    bookingDate: formatDateInLocal(
                        datePicked: booking.bookedAt.toString()),
                    bookingTitle: booking.title ?? '',
                    fullName: booking.user?.fullName ?? '',
                    nickName: booking.user?.nickName ?? 'Aucun pseudo',
                    isCurrentUser: false,
                    userMail: booking.user?.email ?? "",
                    startedBookingHourPicked:
                        booking.beginAt?.substring(0, 5) ?? "",
                    endedBookingHourPicked:
                        booking.endAt?.substring(0, 5) ?? "",
                    computerSelected: booking.computer?.number ?? 0,
                    isWithSeat: true,
                    onTap: () async {
                      await showDialog(
                        context: Get.context!,
                        builder: (BuildContext context) {
                          return SeatPickerDetail(
                            bookingDetailViewController: controller,
                          );
                        },
                      );
                    },
                  );
                },
              ),
              const SizedBox(
                height: 120,
              )
            ],
          ),
        ),
        bottomSheet: controller.currentBooking.value.id != null
            ? Container(
                color: Colors.black,
                width: double.infinity,
                height: 120,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              controller.isInProgress.value
                                  ? "Il est nécéssaire de confirmer la fin de ta session"
                                  : "Tu peux annuler ta réservation jusqu'à 2h avant le début de ta session",
                              style: const TextStyle(color: Colors.white),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      FilledButton(
                        onPressed: () async {
                          AwesomeDialog(
                            context: context,
                            dialogType: DialogType.question,
                            dialogBackgroundColor: backgroundColor,
                            animType: AnimType.rightSlide,
                            title: 'Attention',
                            desc: !controller.isInProgress.value
                                ? 'Souhaites-tu vraiment annuler ta réservation ?'
                                : "Souhaites-tu terminer ta session ?",
                            btnCancelText: 'Je confirme',
                            btnCancelOnPress: () async {
                              if (!controller.isInProgress.value) {
                                await controller.cancelBooking();
                              } else {
                                //TODO PRISE DE PHOTO
                              }
                            },
                            btnOkText: 'Retour',
                            btnOkOnPress: () {},
                            btnOkColor: Colors.black,
                          ).show();
                        },
                        child: Text(
                          controller.isInProgress.value
                              ? "J'ai terminé ma session"
                              : 'Annuler ma réservation',
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            : const SizedBox.shrink(),
      ),
    );
  }
}
