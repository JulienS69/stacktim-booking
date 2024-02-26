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
