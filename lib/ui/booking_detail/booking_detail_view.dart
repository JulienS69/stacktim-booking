import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stacktim_booking/helper/strings.dart';
import 'package:stacktim_booking/ui/booking_detail/booking_detail_view_controller.dart';
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
        onPressedRetry: () {},
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
                bookingDate: "14 Janvier 2023",
                bookingTitle: "Training CSGO & Rocket League",
                fullName: "Julien SEUX",
                nickName: 'Virtuor',
                isCurrentUser: true,
              ),
              const SizedBox(
                height: 15,
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(
                      "D'autres personnes sont présentes dans le même crénau que le votre : ",
                      style: TextStyle(
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
              const SizedBox(
                height: 15,
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 5,
                itemBuilder: (context, index) {
                  //TODO A METTRE DANS UN WIDGET GENERIQUE
                  return BookingDetail(
                    bookingDate: "14 Janvier 2023",
                    bookingTitle: "Training CSGO & Rocket League",
                    fullName: "Dheeraj TILHOO",
                    nickName: 'DHEEDHEE',
                    isCurrentUser: false,
                  );
                },
              ),
              const SizedBox(
                height: 100,
              )
            ],
          ),
        ),
        bottomSheet: controller.currentBooking.value.id == null
            ?
            //TODO IF STATEMENT SI LE USER N'A PLUS LA POSSIBILITÉ D'ANNULER SA RÉSERVATION, NE PLUS AFFICHÉ LE BOUTON ET CHANGER LE TEXTE
            Container(
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
                          // AwesomeDialog(
                          //   context: context,
                          //   dialogType: DialogType.question,
                          //   dialogBackgroundColor: backgroundColor,
                          //   animType: AnimType.rightSlide,
                          //   title: 'Attention',
                          //   desc:
                          //       'Souhaites-tu vraiment annuler ta réservation ?',
                          //   btnCancelText: 'Je confirme',
                          //   btnCancelOnPress: () {
                          //     //TODO ROUTE POUR ANNULER LA RÉSERVATION
                          //   },
                          //   btnOkText: 'Annuler',
                          //   btnOkOnPress: () {},
                          //   btnOkColor: Colors.black,
                          // ).show();
                          if (!controller.isInProgress.value &&
                              !controller.isPassed.value) {
                            await controller.cancelBooking();
                          }
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
