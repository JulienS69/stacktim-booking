import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:stacktim_booking/logic/models/booking/booking.dart';

import '../../core/rest_api_repository.dart';

class BookingRepository extends RestApiRepository {
  BookingRepository()
      : super(
            client: Get.find<Dio>(tag: 'stacktimApi'), controller: '/bookings');

  Future<Either<dynamic, List<Booking>>> getMyBookings() async {
    return await handlingPostResponse(
      queryRoute: "$controller/search",
      showError: false,
      showSuccess: false,
      isCustomResponse: true,
      body: {
        "search": {
          "scopes": [
            {
              "name": "ownBookings",
            },
          ],
          "includes": [
            {"relation": "user"},
            {"relation": "computer"},
            {"relation": "status"},
          ]
        }
      },
    ).then(
      (value) => value.fold(
        (l) async {
          return left(l['message']);
        },
        (r) async {
          return right(
              r['data'].map<Booking>((e) => Booking.fromJson(e)).toList());
        },
      ),
    );
  }

  Future<Either<dynamic, Booking>> createBooking({
    required Booking currentBooking,
  }) async {
    return await handlingPostResponse(
      queryRoute: "$controller/mutate",
      showError: false,
      showSuccess: false,
      body: {
        "mutate": [
          {
            "operation": "create",
            "attributes": {
              "user_id": currentBooking.userId,
              "status_id": currentBooking.statusId,
              "computer_id": currentBooking.computerId,
              "title": currentBooking.title,
              "booked_at": currentBooking.bookedAt,
              "begin_at": currentBooking.beginAt,
              "end_at": currentBooking.endAt,
              "duration": currentBooking.duration,
            }
          }
        ]
      },
    ).then(
      (value) => value.fold(
        (l) async {
          return left(l['message']);
        },
        (r) async {
          return right(Booking.fromJson(r));
        },
      ),
    );
  }
}
