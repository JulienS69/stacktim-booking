import 'dart:developer';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:stacktim_booking/helper/color.dart';
import 'package:stacktim_booking/helper/snackbar.dart';
import 'package:stacktim_booking/helper/strings.dart';
import 'package:stacktim_booking/helper/style.dart';
import 'package:stacktim_booking/logic/models/computer/computer.dart';
import 'package:stacktim_booking/ui/dashboard/dashboard_view_controller.dart';

class SeatWidget extends StatefulWidget {
  final int seatNumber;
  final bool isSelected;
  final Function(Computer) onSelectComputer;
  final bool isAvailable;
  final bool isUnderMaintenance;
  final Computer computer;

  const SeatWidget({
    super.key,
    required this.seatNumber,
    required this.isSelected,
    required this.isAvailable,
    required this.isUnderMaintenance,
    required this.computer,
    required this.onSelectComputer,
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
        if (!widget.isAvailable || widget.isUnderMaintenance) {
          HapticFeedback.selectionClick();
          showSnackbar("Vous ne pouvez pas sélectionner ce siège",
              SnackStatusEnum.warning);
        } else {
          widget.onSelectComputer(widget.computer);
        }
      },
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.all(4),
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
              ),
              child: ShaderMask(
                shaderCallback: (Rect bounds) {
                  return ui.Gradient.linear(
                    const Offset(0, 0),
                    const Offset(50, 50),
                    [
                      Colors.transparent,
                      widget.isAvailable
                          ? Colors.transparent
                          : widget.isUnderMaintenance
                              ? Colors.amber.withOpacity(0.5)
                              : Colors.red.withOpacity(0.5),
                    ],
                    [0.0, 1.0],
                  );
                },
                blendMode: BlendMode.srcATop,
                child: Container(
                  decoration: BoxDecoration(
                    color: widget.isSelected ? Colors.red : Colors.transparent,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Image.asset(
                          seat,
                          height: 50,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          widget.isUnderMaintenance
                              ? 'PC en maintenance'
                              : !widget.isAvailable
                                  ? 'Indisponible '
                                  : 'Siège ${widget.seatNumber}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 8,
                          ),
                        ),
                      ],
                    ),
                  ),
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
              height: 550,
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
            mainAxisSpacing: 10,
            childAspectRatio: 2,
            crossAxisSpacing: 4,
            children: List.generate(
                widget.dashboardViewController.computersList.length, (index) {
              Computer computer =
                  widget.dashboardViewController.computersList[index];
              int seatNumber = index + 1;
              bool isSelected = selectedSeat == seatNumber;
              return SeatWidget(
                seatNumber: seatNumber,
                isSelected: isSelected,
                isAvailable: computer.isAvailable ?? false,
                isUnderMaintenance: computer.isUnderMaintenance ?? false,
                computer: computer,
                onSelectComputer: (computer) {
                  HapticFeedback.selectionClick();
                  toggleSeatSelection(seatNumber);
                  widget.dashboardViewController.computerSelected.value =
                      selectedSeat ?? 0;
                  widget.dashboardViewController.computerUuidSelected =
                      computer.id ?? "";
                  log(widget.dashboardViewController.computerSelected.value
                      .toString());
                },
              );
            }),
          ),
          Obx(
            () => widget.dashboardViewController.computerSelected.value != 0
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
                                      "Siège sélectionné : N°${widget.dashboardViewController.computerSelected.value} ",
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
