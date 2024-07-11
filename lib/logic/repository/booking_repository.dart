import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart' as dio;
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:stacktim_booking/logic/models/booking/booking.dart';

import '../../core/rest_api_repository.dart';

class BookingRepository extends RestApiRepository {
  BookingRepository()
      : super(
            client: Get.find<dio.Dio>(tag: 'stacktimApi'),
            controller: '/bookings');

  Future<Either<dynamic, List<Booking>>> getMyBookings() async {
    return await handlingPostResponse(
      queryRoute: "$controller/search",
      showError: false,
      showSuccess: false,
      isCustomResponse: true,
      body: {
        "search": {
          "limit": 1000,
          "scopes": [
            {
              "name": "ownBookings",
            },
          ],
          "filters": [
            {
              "field": "canceled_at",
              "operator": "=",
              "value": null,
            },
          ],
          "sorts": [
            {
              "field": "booked_at",
              "direction": "desc",
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
          if (l is Map && l.containsKey("message")) {
            return left(l["message"]);
          } else {
            return left(l);
          }
        },
        (r) async {
          return right(
              r['data'].map<Booking>((e) => Booking.fromJson(e)).toList());
        },
      ),
    );
  }

  Future<Either<dynamic, List<Booking>>> getBooking(
      {required String currentBookingId}) async {
    return await handlingPostResponse(
      queryRoute: "$controller/search",
      showError: false,
      showSuccess: false,
      isCustomResponse: true,
      body: {
        "search": {
          "scopes": [
            {
              "name": "overlappingBookings",
              "parameters": [currentBookingId]
            }
          ],
          "includes": [
            {"relation": "user"},
            {"relation": "computer"},
            {"relation": "status"},
          ],
        },
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
              r['data'].map<Booking>((e) => Booking.fromJson(e)).toList());
        },
      ),
    );
  }

  Future<Either<dynamic, List<Booking>>> getCalendarMonthlyBooking(
      {required int monthNumber}) async {
    return await handlingPostResponse(
      queryRoute: "$controller/search",
      showError: false,
      showSuccess: false,
      isCustomResponse: true,
      body: {
        "limit": 1000,
        "search": {
          "scopes": [
            {
              "name": "monthBookings",
              "parameters": [monthNumber],
            }
          ],
          "filters": [
            {
              "field": "canceled_at",
              "operator": "=",
              "value": null,
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
          if (l is Map && l.containsKey("message")) {
            return left(l["message"]);
          } else {
            return left(l);
          }
        },
        (r) async {
          return right(
            r['data'].map<Booking>((e) => Booking.fromJson(e)).toList(),
          );
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
          if (l is Map && l.containsKey("message")) {
            return left(l["message"]);
          } else {
            return left(l);
          }
        },
        (r) async {
          return right(Booking.fromJson(r));
        },
      ),
    );
  }

  Future<Either<String, Booking>> cancelBooking({
    required String currentBookingId,
  }) async {
    return await handlingPostResponse(
      queryRoute: "$controller/mutate",
      showError: false,
      showSuccess: false,
      isCustomResponse: true,
      body: {
        "mutate": [
          {
            "operation": "update",
            "key": currentBookingId,
            "attributes": {
              "canceled_at":
                  DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now()),
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
          return right(Booking.fromJson(r));
        },
      ),
    );
  }

  Future<Either<dynamic, Booking>> updateBooking({
    required String currentBookingId,
    required bool isChecking,
    required File pictureFile,
    required String attachmentName,
  }) async {
    dio.FormData formData = dio.FormData.fromMap({
      "mutate": [
        {
          "operation": "update",
          "key": currentBookingId,
        }
      ],
      "collection": isChecking ? "checkin" : "checkout"
    });

    if (pictureFile.path.isNotEmpty) {
      try {
        final file = await dio.MultipartFile.fromFile(
          pictureFile.path,
          filename: attachmentName,
        );
        formData.files.add(MapEntry("image", file));
      } catch (e) {
        Sentry.captureException(
          e,
        );
        return left("Error attaching file: $e");
      }
    }

    return await handlingPostResponse(
      queryRoute: "$controller/mutate",
      showError: false,
      showSuccess: false,
      body: formData,
      header: {
        'Content-Type': 'multipart/form-data',
      },
    ).then(
      (value) => value.fold(
        (l) async {
          Sentry.captureException(
            l,
          );
          if (l is Map && l.containsKey("message")) {
            return left(l["message"]);
          } else {
            return left(l);
          }
        },
        (r) async {
          return right(Booking.fromJson(r));
        },
      ),
    );
  }
}
