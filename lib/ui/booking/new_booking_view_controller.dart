import 'package:get/get.dart';

class NewBookingViewController extends GetxController with StateMixin {
  NewBookingViewController();

  @override
  Future<void> onReady() async {
    change(null, status: RxStatus.loading());
    change(null, status: RxStatus.success());
    super.onReady();
  }
}
