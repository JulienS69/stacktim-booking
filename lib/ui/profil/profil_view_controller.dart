import 'package:get/get.dart';

class ProfilViewController extends GetxController with StateMixin {
  ProfilViewController();

  @override
  Future<void> onReady() async {
    change(null, status: RxStatus.loading());
    change(null, status: RxStatus.success());
    super.onReady();
  }
}
