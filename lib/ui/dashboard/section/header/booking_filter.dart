import 'package:flutter/widgets.dart';
import 'package:stacktim_booking/helper/functions.dart';
import 'package:stacktim_booking/ui/dashboard/dashboard_view_controller.dart';
import 'package:stacktim_booking/widget/x_selectable_chip.dart';

class BookingFilter extends StatelessWidget {
  const BookingFilter({
    super.key,
    required this.controller,
  });

  final DashboardViewController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 15.0, right: 15.0, top: 15.0),
          child: Row(
            children: [
              Expanded(
                  child: Wrap(
                alignment: WrapAlignment.center,
                crossAxisAlignment: WrapCrossAlignment.center,
                spacing: 35,
                children: List.generate(
                  controller.statusList.length,
                  (index) => XSelectableChip(
                      label: getStringByStatusTag(
                          controller.statusList[index].slug ?? ''),
                      chipColor: getColorChipByStatusTag(
                          controller.statusList[index].slug ?? "")),
                ),
              ))
            ],
          ),
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
