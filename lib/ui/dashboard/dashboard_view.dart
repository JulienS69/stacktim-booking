import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:stacktim_booking/helper/strings.dart';
import 'package:stacktim_booking/ui/dashboard/dashboard_view_controller.dart';
import 'package:stacktim_booking/widget/x_app_bar.dart';

class DashboardView extends GetView<DashboardViewController> {
  const DashboardView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const XPageHeader(
        title: '',
        imagePath: logo,
      ),
      body: controller.obx(
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
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 10.0),
                        child: GlassmorphicContainer(
                          width: 350,
                          height: 80,
                          borderRadius: 20,
                          blur: 20,
                          alignment: Alignment.bottomCenter,
                          border: 2,
                          linearGradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                Colors.black.withOpacity(0.1),
                                controller.getColorsByStatusTag(
                                    statusTag: controller
                                        .statusList[index].statusName!)
                              ],
                              stops: const [
                                0.01,
                                1,
                              ]),
                          borderGradient: const LinearGradient(
                              colors: [Colors.transparent, Colors.transparent]),
                          child: const Text("Bonjour"),
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
