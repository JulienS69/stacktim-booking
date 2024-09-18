import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart' as dio;
import 'package:get/get.dart';
import 'package:stacktim_booking/logic/models/game/game.dart';

import '../../core/rest_api_repository.dart';

class GameRepository extends RestApiRepository {
  GameRepository()
      : super(
            client: Get.find<dio.Dio>(tag: 'stacktimApi'),
            controller: '/games');

  Future<Either<dynamic, List<Game>>> getGameList() async {
    return await handlingPostResponse(
      queryRoute: "$controller/search",
      showError: false,
      showSuccess: false,
      isCustomResponse: true,
      body: {
        "limit": 1000,
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
          return right(
            r['data'].map<Game>((e) => Game.fromJson(e)).toList(),
          );
        },
      ),
    );
  }
}
