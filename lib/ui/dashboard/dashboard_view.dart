import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stacktim_booking/helper/strings.dart';
import 'package:stacktim_booking/ui/dashboard/dashboard_view_controller.dart';
import 'package:stacktim_booking/widget/x_app_bar.dart';
import 'package:stacktim_booking/widget/x_chevron.dart';
import 'package:stacktim_booking/widget/x_mobile_scaffold.dart';

class DashboardView extends GetView<DashboardViewController> {
  const DashboardView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return XMobileScaffold(
      appBar: const XPageHeader(
        title: '',
        imagePath: logo,
      ),
      content: controller.obx(
        (state) => SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 150,
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 15.0,
                  right: 15.0,
                ),
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: controller.statusList.length,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: const EdgeInsets.all(20.0),
                        padding: const EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                              10.0), // Border radius de 10
                          gradient: LinearGradient(
                            colors: [
                              Colors.grey[900]!, // Couleur de fond sombre

                              Colors.white,
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.3),
                              spreadRadius: 1,
                              blurRadius: 5,
                              offset: const Offset(3, 5),
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
                                      statusTag: controller
                                          .statusList[index].statusName!),
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
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
