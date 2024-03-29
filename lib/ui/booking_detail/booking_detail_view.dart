import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stacktim_booking/helper/strings.dart';
import 'package:stacktim_booking/ui/booking_detail/booking_detail_view_controller.dart';
import 'package:stacktim_booking/widget/x_app_bar.dart';
import 'package:stacktim_booking/widget/x_mobile_scaffold.dart';

import '../../helper/color.dart';

class BookingDetailView extends GetView<BookingDetailViewController> {
  const BookingDetailView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return controller.obx(
      (state) => XMobileScaffold(
        appBar: XPageHeader(
          title: 'fef',
          centerTitle: true,
          imagePath: logoOverSlug,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 5,
                itemBuilder: (context, index) {
                  //TODO A METTRE DANS UN WIDGET GENERIQUE
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Julien Seux',
                                      style: TextStyle(
                                        color: redChip,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Text(
                                      'Virtuor',
                                      style: TextStyle(
                                        color: grey5,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 75,
                                  width: 75,
                                  child: ClipRRect(
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(10),
                                    ),
                                    child: Image.network(
                                      'https://picsum.photos/200',
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const Divider(
                              color: redChip,
                            ),
                            const Text(
                              'Titre de la réservation : Training CSGO & Rocket League',
                            ),
                            const Text(
                              'Réservation prise le 14 Janvier 2023',
                              style: TextStyle(fontSize: 12),
                            ),
                            const Text(
                              'Contacter sur Teams',
                              style: TextStyle(
                                  fontSize: 12,
                                  decoration: TextDecoration.underline),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(
                height: 100,
              )
            ],
          ),
        ),
        bottomSheet: Container(
          color: Colors.black,
          width: double.infinity,
          height: 100,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                const Text(
                  'La salle dispose encore de 8 places à cette date.',
                  style: TextStyle(color: Colors.white),
                ),
                FilledButton(
                  onPressed: () {},
                  child: const Text(
                    'Réserver ma place',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
