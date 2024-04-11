import 'package:get/get.dart';

class CalendarDetailViewController extends GetxController with StateMixin {
  DateTime dateTimeSelected = DateTime.now();
  @override
  void onInit() {
    change(null, status: RxStatus.loading());
    if (Get.arguments != null) {
      if (Get.arguments.containsKey('date')) {
        dateTimeSelected = Get.arguments['date'];
      }
    }
    change(null, status: RxStatus.success());

    super.onInit();
  }
}
