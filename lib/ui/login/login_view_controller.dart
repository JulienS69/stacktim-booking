import 'package:get/get.dart';

import '../../helper/strings.dart';

class LoginViewController extends GetxController with StateMixin {
  List<String> imageList = [
    one,
    two,
    three,
    four,
    five,
    five,
  ];

  LoginViewController();

  @override
  Future<void> onReady() async {
    change(null, status: RxStatus.loading());
    print("aaaaaaaaaa");
    change(null, status: RxStatus.success());
    super.onReady();
  }
}
