import 'package:get/get.dart';

import '../../helper/strings.dart';

class DashboardViewController extends GetxController with StateMixin {
  List<String> imageList = [
    one,
    two,
    three,
    four,
    five,
    five,
  ];

  DashboardViewController();

  @override
  Future<void> onReady() async {
    change(null, status: RxStatus.loading());
    change(null, status: RxStatus.success());
    super.onReady();
  }
}
