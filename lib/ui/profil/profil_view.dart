import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stacktim_booking/helper/strings.dart';
import 'package:stacktim_booking/widget/x_app_bar.dart';
import 'package:stacktim_booking/widget/x_mobile_scaffold.dart';

import 'profil_view_controller.dart';

class ProfilView extends GetView<ProfilViewController> {
  const ProfilView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return XMobileScaffold(
      appBar: const XPageHeader(
        title: '',
        imagePath: logo,
      ),
      gapLocation: GapLocation.end,
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.black,
        child: Image.asset(
          logo,
          height: 35,
        ),
      ),
      bottomNavIndex: 2,
      body: controller.obx(
        (state) => const SingleChildScrollView(
          child: Column(
            children: [
              Text("test"),
            ],
          ),
        ),
      ),
    );
  }
}
