import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:stacktim_booking/logic/models/computer/computer.dart';
import 'package:stacktim_booking/logic/models/status/status.dart';
import 'package:stacktim_booking/logic/models/user/user.dart';

part 'booking.freezed.dart';
part 'booking.g.dart';

@Freezed(makeCollectionsUnmodifiable: false)
class Booking with _$Booking {
  const factory Booking({
    @JsonKey(name: 'id') String? id,
    @JsonKey(name: 'user_id') String? userId,
    @JsonKey(name: 'status_id') String? statusId,
    @JsonKey(name: 'computer_id') String? computerId,
    @JsonKey(name: 'title') String? title,
    @JsonKey(name: 'booked_at') String? bookedAt,
    @JsonKey(name: 'begin_at') String? beginAt,
    @JsonKey(name: 'end_at') String? endAt,
    @JsonKey(name: 'duration') int? duration,
    @JsonKey(name: 'user') User? user,
    @JsonKey(name: 'computer') Computer? computer,
    @JsonKey(name: 'status') Status? status,
  }) = _Booking;

  factory Booking.fromJson(Map<String, dynamic> json) =>
      _$BookingFromJson(json);
}

extension OnBookingJson on Map<String, dynamic> {
  Booking get toJwt {
    return Booking.fromJson(this);
  }
}
