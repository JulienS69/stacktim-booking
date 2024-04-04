import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:stacktim_booking/helper/strings.dart';
import 'package:stacktim_booking/ui/booking_detail/booking_detail_view_controller.dart';
import 'package:stacktim_booking/widget/x_app_bar.dart';
import 'package:stacktim_booking/widget/x_booking_detail.dart';
import 'package:stacktim_booking/widget/x_loader_stacktim.dart';
import 'package:stacktim_booking/widget/x_mobile_scaffold.dart';

class BookingDetailView extends GetView<BookingDetailViewController> {
  const BookingDetailView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return controller.obx(
      onLoading: const XLoaderStacktim(),
      (state) => XMobileScaffold(
        isShowBottomNavigationBar: false,
        appBar: XPageHeader(
          title: controller.currentBooking.value.id != null
              ? controller.currentBooking.value.title ?? ""
              : 'Réservation',
          centerTitle: true,
          imagePath: logoOverSlug,
        ),
        body: controller.currentBooking.value.id == null
            ? SingleChildScrollView(
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
              )
            : Center(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Lottie.asset(
                            errorLottie,
                            fit: BoxFit.cover,
                            height: 350,
                            repeat: false,
                          ),
                        ],
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 8.0, right: 8.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                "Une erreur s'est produite lors de la récupération du détail de ta session",
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 18),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 60,
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        child: const Text(
                          "Réessayer",
                        ),
                      )
                    ],
                  ),
                ),
              ),
        bottomSheet: controller.currentBooking.value.id == null
            ?
            //TODO IF STATEMENT SI LE USER N'A PLUS LA POSSIBILITÉ D'ANNULER SA RÉSERVATION, NE PLUS AFFICHÉ LE BOUTON ET CHANGER LE TEXTE
            Container(
                color: Colors.black,
                width: double.infinity,
                height: 100,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      const Text(
                        'Vous pouvez toujours annuler votre réservation',
                        style: TextStyle(color: Colors.white),
                      ),
                      FilledButton(
                        onPressed: () {
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
                        },
                        child: const Text(
                          'Annuler ma réservation',
                          style: TextStyle(color: Colors.white),
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
