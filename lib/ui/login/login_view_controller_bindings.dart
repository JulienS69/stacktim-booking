import 'package:get/get.dart';
import 'package:stacktim_booking/ui/login/login_view_controller.dart';

class LoginViewControllerBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => LoginViewController(),
    );
  }
}
