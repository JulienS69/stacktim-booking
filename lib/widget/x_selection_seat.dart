import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:stacktim_booking/helper/color.dart';
import 'package:stacktim_booking/helper/strings.dart';
import 'package:stacktim_booking/helper/style.dart';
import 'package:stacktim_booking/ui/dashboard/dashboard_view_controller.dart';

class SeatWidget extends StatefulWidget {
  final int seatNumber;
  final bool isSelected;
  final Function(bool) onSelect;

  const SeatWidget({
    super.key,
    required this.seatNumber,
    required this.isSelected,
    required this.onSelect,
  });

  @override
  // ignore: library_private_types_in_public_api
  _SeatWidgetState createState() => _SeatWidgetState();
}

class _SeatWidgetState extends State<SeatWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.onSelect(!widget.isSelected);
      },
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.all(4),
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: widget.isSelected ? redStackTim : Colors.transparent,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Image.asset(
              seat,
              height: 50,
            ),
          ),
          // Text(
          //   widget.seatNumber.toString(),
          //   style: const TextStyle(
          //     color: Colors.white,
          //     fontSize: 16,
          //   ),
          // ),
        ],
      ),
    );
  }
}

// ignore: must_be_immutable
class SeatSelectionScreen extends StatefulWidget {
  ValueNotifier<dynamic> pageIndexNotifier;
  final DashboardViewController dashboardViewController;

  SeatSelectionScreen({
    super.key,
    required this.pageIndexNotifier,
    required this.dashboardViewController,
  });
  @override
  // ignore: library_private_types_in_public_api
  _SeatSelectionScreenState createState() => _SeatSelectionScreenState();
}

class _SeatSelectionScreenState extends State<SeatSelectionScreen> {
  int? selectedSeat;
  void toggleSeatSelection(int seatNumber) {
    setState(
      () {
        if (selectedSeat == seatNumber) {
          selectedSeat = null;
        } else {
          selectedSeat = seatNumber;
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15.0),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              width: 100,
              height: 500,
              decoration: BoxDecoration(
                color: grey10, // Couleur du bureau
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
          GridView.count(
            crossAxisCount: 2,
            mainAxisSpacing: 0,
            childAspectRatio: 2,
            crossAxisSpacing: 4,
            children: List.generate(10, (index) {
              int seatNumber = index + 1;
              bool isSelected = selectedSeat == seatNumber;
              return SeatWidget(
                seatNumber: seatNumber,
                isSelected: isSelected,
                onSelect: (isSelected) {
                  HapticFeedback.selectionClick();
                  toggleSeatSelection(seatNumber);
                  widget.dashboardViewController.seatSelected.value =
                      selectedSeat ?? 0;
                  log(widget.dashboardViewController.seatSelected.value
                      .toString());
                },
              );
            }),
          ),
          Obx(
            () => widget.dashboardViewController.seatSelected.value != 0
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
                                      "Siège sélectionné : N°${widget.dashboardViewController.seatSelected.value} ",
                                      style: arvoStyle.copyWith(
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
                            widget.pageIndexNotifier.value =
                                widget.pageIndexNotifier.value + 1;
                          },
                          child: Row(
                            children: [
                              Expanded(
                                child: Container(
                                  decoration: const BoxDecoration(
                                      color: backgroundColor),
                                  height: 60,
                                  child: const Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "J'ai valide ce siège ",
                                        style: arvoStyle,
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Icon(
                                        Icons.arrow_circle_right_outlined,
                                        color: Colors.white,
                                      )
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
          )
        ],
      ),
    );
  }
}
