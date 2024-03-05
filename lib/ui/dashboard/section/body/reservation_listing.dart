import 'package:flutter/material.dart';
import 'package:stacktim_booking/ui/dashboard/dashboard_view_controller.dart';
import 'package:stacktim_booking/widget/x_chevron.dart';

class ReservationListing extends StatelessWidget {
  const ReservationListing({
    super.key,
    required this.controller,
  });

  final DashboardViewController controller;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: controller.statusList.length,
      itemBuilder: (context, index) {
        return Container(
          margin: const EdgeInsets.all(20.0),
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(20)),
            boxShadow: [
              BoxShadow(
                color: Colors.grey[500]!,
                blurRadius: 10,
                blurStyle: BlurStyle.outer,
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Training rocket league',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 8.0),
              Row(
                children: [
                  const Expanded(
                    child: Text(
                      'Crédit utilisé : 2 unités',
                      style: TextStyle(
                        color: Colors.white70,
                        overflow: TextOverflow.clip,
                      ),
                    ),
                  ),
                  controller.getChipByStatusTag(
                      controller.statusList[index].statusName!),
                  const SizedBox(
                    width: 10,
                  ),
                  Chevron(
                    direction: ChevronDirection.right,
                    size: 10.0,
                    color: controller.getColorsByStatusTag(
                      statusTag: controller.statusList[index].statusName!,
                    ),
                  ),
                ],
              ),
              const Row(
                children: [
                  Expanded(
                    child: Text(
                      'Le 18 octobre de 17h à 18h',
                      style: TextStyle(
                        color: Colors.white70,
                        overflow: TextOverflow.clip,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
