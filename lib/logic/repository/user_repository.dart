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
          if (l is Map && l.containsKey("message")) {
            return left(l["message"]);
          } else {
            return left(l);
          }
        },
        (r) async {
          return right(
            User.fromJson(r),
          );
        },
      ),
    );
  }

  Future<Either<dynamic, List<User>>> getAdministrators() async {
    return await handlingPostResponse(
      queryRoute: "$controller/search",
      showError: false,
      showSuccess: false,
      isCustomResponse: true,
      body: {
        "search": {
          "filters": [
            {
              "field": "roles.name",
              "operator": "=",
              "value": "Stacktim Admin",
            },
          ],
        }
      },
    ).then(
      (value) => value.fold(
        (l) async {
          if (l is Map && l.containsKey("message")) {
            return left(l["message"]);
          } else {
            return left(l);
          }
        },
        (r) async {
          return right(r['data'].map<User>((e) => User.fromJson(e)).toList());
        },
      ),
    );
  }

  Future<Either<dynamic, User>> updateNickName({
    required String userUuid,
    required String nickName,
  }) async {
    return await handlingPostResponse(
      queryRoute: "$controller/mutate",
      showError: false,
      showSuccess: false,
      body: {
        "mutate": [
          {
            "operation": "update",
            "key": userUuid,
            "attributes": {
              "nickname": nickName,
            }
          }
        ]
      },
    ).then(
      (value) => value.fold(
        (l) async {
          if (l is Map && l.containsKey("message")) {
            return left(l["message"]);
          } else {
            return left(l);
          }
        },
        (r) async {
          return right(User.fromJson(r));
        },
      ),
    );
  }

  Future<Either<dynamic, dynamic>> updateStackCredits({
    required String creditId,
    required int credits,
  }) async {
    return await handlingPostResponse(
      queryRoute: "/credits/mutate",
      showError: false,
      showSuccess: false,
      body: {
        "mutate": [
          {
            "operation": "update",
            "key": creditId,
            "attributes": {
              "available": credits,
            }
          }
        ]
      },
    ).then(
      (value) => value.fold(
        (l) async {
          if (l is Map && l.containsKey("message")) {
            return left(l["message"]);
          } else {
            return left(l);
          }
        },
        (r) async {
          return right(r);
        },
      ),
    );
  }
}
