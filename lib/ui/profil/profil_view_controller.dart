import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacktim_booking/helper/functions.dart';
import 'package:stacktim_booking/helper/local_storage.dart';
import 'package:stacktim_booking/logic/models/user/user.dart';
import 'package:stacktim_booking/logic/repository/user_repository.dart';
import 'package:stacktim_booking/navigation/route.dart';

class ProfilViewController extends GetxController with StateMixin {
  UserRepository userRepository = UserRepository();
  User currentUser = const User();
  RxBool isSkeletonLoading = true.obs;

  @override
  Future<void> onReady() async {
    change(null, status: RxStatus.success());
    await getCurrentUser();
    isSkeletonLoading.value = false;
    super.onReady();
  }

  Future<void> getCurrentUser() async {
    return await userRepository.getCurrentUser().then(
          (value) => value.fold(
            (l) {},
            (r) {
              currentUser = r;
            },
          ),
        );
  }

  Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(LocalStorageKey.jwt.name);
  }

  reloadTutorial() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(LocalStorageKeyEnum.isShowTutorial.name, true);
    Get.offAllNamed(Routes.dashboard);
  }
}
