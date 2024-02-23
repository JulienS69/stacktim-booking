import 'package:get/get.dart';
import 'package:stacktim_booking/ui/profil/profil_view_controller.dart';

class ProfilViewControllerBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => ProfilViewController(),
    );
  }
}
