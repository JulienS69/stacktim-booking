import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stacktim_booking/helper/color.dart';
import 'package:stacktim_booking/helper/strings.dart';
import 'package:stacktim_booking/helper/style.dart';
import 'package:stacktim_booking/ui/booking_detail/booking_detail_view_controller.dart';
import 'package:stacktim_booking/widget/x_app_bar.dart';
import 'package:stacktim_booking/widget/x_mobile_scaffold.dart';

class SeatWidget extends StatefulWidget {
  final int seatNumber;
  final bool isSelected;

  const SeatWidget({
    super.key,
    required this.seatNumber,
    required this.isSelected,
  });

  @override
  // ignore: library_private_types_in_public_api
  _SeatWidgetState createState() => _SeatWidgetState();
}

class _SeatWidgetState extends State<SeatWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.all(4),
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    ShaderMask(
                      shaderCallback: (Rect bounds) {
                        return ui.Gradient.linear(
                          const Offset(0, 0),
                          const Offset(50, 50),
                          [
                            Colors.transparent,
                            widget.isSelected
                                ? Colors.red.withOpacity(0.8)
                                : Colors.transparent,
                          ],
                          [0.0, 1.0],
                        );
                      },
                      blendMode: BlendMode.srcATop,
                      child: Image.asset(
                        seat,
                        height: 50,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      widget.isSelected
                          ? "Votre siège"
                          : 'Siège ${widget.seatNumber}',
                      style: TextStyle(
                          color: widget.isSelected ? Colors.red : Colors.white,
                          fontSize: 8,
                          fontWeight: widget.isSelected
                              ? FontWeight.bold
                              : FontWeight.normal),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class SeatPickerDetail extends StatefulWidget {
  final BookingDetailViewController bookingDetailViewController;

  SeatPickerDetail({
    super.key,
    required this.bookingDetailViewController,
  });
  @override
  // ignore: library_private_types_in_public_api
  _SeatSelectionScreenState createState() => _SeatSelectionScreenState();
}

class _SeatSelectionScreenState extends State<SeatPickerDetail> {
  @override
  Widget build(BuildContext context) {
    return XMobileScaffold(
      appBar: const XPageHeader(
        title: 'Plan de la salle',
        centerTitle: true,
        imagePath: logoOverSlug,
      ),
      isShowBottomNavigationBar: false,
      body: Padding(
        padding: const EdgeInsets.only(top: 15.0),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                width: 100,
                height: 550,
                decoration: BoxDecoration(
                  color: grey12, // Couleur du bureau
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Center(
                  child: Image.asset(
                    logo,
                    height: 65,
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: GridView.count(
                crossAxisCount: 2,
                mainAxisSpacing: 10,
                childAspectRatio: 2,
                crossAxisSpacing: 4,
                children: List.generate(10, (index) {
                  int seatNumber = index + 1;
                  bool isSelected = widget.bookingDetailViewController
                          .computerSelected.value.number ==
                      index + 1;
                  return SeatWidget(
                    seatNumber: seatNumber,
                    isSelected: isSelected,
                  );
                }),
              ),
            ),
            Obx(
              () => widget.bookingDetailViewController.computerSelected.value.id
                          ?.isNotEmpty ??
                      false
                  ? Align(
                      alignment: Alignment.bottomCenter,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Container(
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                  ),
                                  height: 60,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Siège sélectionné : N°${widget.bookingDetailViewController.computerSelected.value.number} ",
                                        style: antaStyle.copyWith(
                                          color: backgroundColorSheet,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      const Icon(
                                        Icons.arrow_circle_right_outlined,
                                        color: Colors.white,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    decoration: const BoxDecoration(),
                                    height: 60,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const Icon(
                                          Icons.arrow_circle_left_outlined,
                                          color: Colors.white,
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          "Retour",
                                          style: antaStyle.copyWith(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  : const SizedBox.shrink(),
            ),
          ],
        ),
      ),
    );
  }
}
