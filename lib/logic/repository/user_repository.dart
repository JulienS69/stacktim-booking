import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:stacktim_booking/logic/models/user/user.dart';

import '../../core/rest_api_repository.dart';

class UserRepository extends RestApiRepository {
  UserRepository()
      : super(client: Get.find<Dio>(tag: 'stacktimApi'), controller: '/users');

  Future<Either<dynamic, User>> getCurrentUser() async {
    return await handlingGetResponse(
      queryRoute: "$controller/current",
      showError: false,
      showSuccess: false,
      isCustomResponse: true,
    ).then(
      (value) => value.fold(
        (l) async {
          return left(l['message']);
        },
        (r) async {
          return right(User.fromJson(r));
        },
      ),
    );
  }
}
