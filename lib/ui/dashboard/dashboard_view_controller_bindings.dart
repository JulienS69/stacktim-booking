import 'package:get/get.dart';
import 'package:stacktim_booking/ui/dashboard/dashboard_view_controller.dart';

class DashboardViewControllerBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => DashboardViewController(),
    );
  }
}
