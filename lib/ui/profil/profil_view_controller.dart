import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacktim_booking/helper/functions.dart';
import 'package:stacktim_booking/helper/local_storage.dart';
import 'package:stacktim_booking/helper/snackbar.dart';
import 'package:stacktim_booking/logic/models/user/user.dart';
import 'package:stacktim_booking/logic/repository/user_repository.dart';
import 'package:stacktim_booking/navigation/route.dart';

class ProfilViewController extends GetxController with StateMixin {
  UserRepository userRepository = UserRepository();
  User currentUser = const User();
  RxBool isSkeletonLoading = true.obs;
  RxBool isEditing = false.obs;
  TextEditingController nickNameController = TextEditingController();
  RxString nickName = "".obs;
  final pageIndexNotifier = ValueNotifier(0);

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

  Future<void> updateCurrentUser() async {
    await userRepository
        .updateNickName(
            nickName: nickName.value, userUuid: currentUser.id ?? "0")
        .then(
          (value) => value.fold(
            (l) {
              showSnackbar("Un problème est survenue !", SnackStatusEnum.error);
            },
            (r) {
              showSnackbar(
                  "Ton pseudo a bien été modifié !", SnackStatusEnum.success);
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
