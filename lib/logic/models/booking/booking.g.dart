// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'booking.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$BookingImpl _$$BookingImplFromJson(Map<String, dynamic> json) =>
    _$BookingImpl(
      id: json['id'] as String?,
      userId: json['user_id'] as String?,
      statusId: json['status_id'] as String?,
      computerId: json['computer_id'] as String?,
      title: json['title'] as String?,
      bookedAt: json['booked_at'] as String?,
      beginAt: json['begin_at'] as String?,
      endAt: json['end_at'] as String?,
      duration: json['duration'] as int?,
      user: json['user'] == null
          ? null
          : User.fromJson(json['user'] as Map<String, dynamic>),
      computer: json['computer'] == null
          ? null
          : Computer.fromJson(json['computer'] as Map<String, dynamic>),
      status: json['status'] == null
          ? null
          : Status.fromJson(json['status'] as Map<String, dynamic>),
      isCheckinComplete: json['is_checkin_completed'] as bool?,
      isCheckoutComplete: json['is_checkout_completed'] as bool?,
    );

Map<String, dynamic> _$$BookingImplToJson(_$BookingImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userId,
      'status_id': instance.statusId,
      'computer_id': instance.computerId,
      'title': instance.title,
      'booked_at': instance.bookedAt,
      'begin_at': instance.beginAt,
      'end_at': instance.endAt,
      'duration': instance.duration,
      'user': instance.user,
      'computer': instance.computer,
      'status': instance.status,
      'is_checkin_completed': instance.isCheckinComplete,
      'is_checkout_completed': instance.isCheckoutComplete,
    };
