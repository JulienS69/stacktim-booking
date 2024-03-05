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

  SeatWidget({
    required this.seatNumber,
    required this.isSelected,
    required this.onSelect,
  });

  @override
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

class SeatSelectionScreen extends StatefulWidget {
  @override
  _SeatSelectionScreenState createState() => _SeatSelectionScreenState();
}

class _SeatSelectionScreenState extends State<SeatSelectionScreen> {
  int? selectedSeat;
  DashboardViewController dashboardViewController = DashboardViewController();
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
          Positioned.fill(
            bottom: 80,
            child: Center(
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
                  dashboardViewController.seatSelected.value =
                      selectedSeat ?? 0;
                  log(dashboardViewController.seatSelected.value.toString());
                },
              );
            }),
          ),
          Obx(
            () => dashboardViewController.seatSelected.value != 0
                ? Align(
                    alignment: Alignment.bottomCenter,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: const ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(Colors.black),
                        foregroundColor: MaterialStatePropertyAll(Colors.white),
                        textStyle: MaterialStatePropertyAll(arvoStyle),
                      ),
                      child: const SizedBox(
                        height: 50,
                        width: 150,
                        child: Center(
                          child: Text(
                            "J'ai choisi mon siège",
                          ),
                        ),
                      ),
                    ),
                  )
                : const SizedBox.shrink(),
          )
        ],
      ),
    );
  }
}
