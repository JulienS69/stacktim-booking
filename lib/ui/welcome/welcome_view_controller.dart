import 'package:get/get.dart';

import '../../navigation/route.dart';

class WelcomeViewController extends GetxController with StateMixin {
  //A two-second delay is set for loading before redirecting to the dashboard page.
  Future waitBeforeRedirect() async {
    await Future.delayed(const Duration(seconds: 2));
    await Get.offAndToNamed(Routes.dashboard);
  }

  @override
  void onInit() async {
    change(null, status: RxStatus.success());
    await waitBeforeRedirect();
    super.onInit();
  }
}
