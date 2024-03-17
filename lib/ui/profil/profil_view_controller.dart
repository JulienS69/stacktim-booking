import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacktim_booking/helper/functions.dart';

class ProfilViewController extends GetxController with StateMixin {
  ProfilViewController();

  @override
  Future<void> onReady() async {
    change(null, status: RxStatus.loading());
    change(null, status: RxStatus.success());
    super.onReady();
  }

  Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(LocalStorageKey.jwt.name);
  }
}
