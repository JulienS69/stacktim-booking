// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'booking.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Booking _$BookingFromJson(Map<String, dynamic> json) {
  return _Booking.fromJson(json);
}

/// @nodoc
mixin _$Booking {
  @JsonKey(name: 'id')
  String? get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'user_id')
  String? get userId => throw _privateConstructorUsedError;
  @JsonKey(name: 'status_id')
  String? get statusId => throw _privateConstructorUsedError;
  @JsonKey(name: 'computer_id')
  String? get computerId => throw _privateConstructorUsedError;
  @JsonKey(name: 'title')
  String? get title => throw _privateConstructorUsedError;
  @JsonKey(name: 'booked_at')
  String? get bookedAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'begin_at')
  String? get beginAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'end_at')
  String? get endAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'duration')
  int? get duration => throw _privateConstructorUsedError;
  @JsonKey(name: 'user')
  User? get user => throw _privateConstructorUsedError;
  @JsonKey(name: 'computer')
  Computer? get computer => throw _privateConstructorUsedError;
  @JsonKey(name: 'status')
  Status? get status => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $BookingCopyWith<Booking> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BookingCopyWith<$Res> {
  factory $BookingCopyWith(Booking value, $Res Function(Booking) then) =
      _$BookingCopyWithImpl<$Res, Booking>;
  @useResult
  $Res call(
      {@JsonKey(name: 'id') String? id,
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
      @JsonKey(name: 'status') Status? status});

  $UserCopyWith<$Res>? get user;
  $ComputerCopyWith<$Res>? get computer;
  $StatusCopyWith<$Res>? get status;
}

/// @nodoc
class _$BookingCopyWithImpl<$Res, $Val extends Booking>
    implements $BookingCopyWith<$Res> {
  _$BookingCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? userId = freezed,
    Object? statusId = freezed,
    Object? computerId = freezed,
    Object? title = freezed,
    Object? bookedAt = freezed,
    Object? beginAt = freezed,
    Object? endAt = freezed,
    Object? duration = freezed,
    Object? user = freezed,
    Object? computer = freezed,
    Object? status = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      userId: freezed == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String?,
      statusId: freezed == statusId
          ? _value.statusId
          : statusId // ignore: cast_nullable_to_non_nullable
              as String?,
      computerId: freezed == computerId
          ? _value.computerId
          : computerId // ignore: cast_nullable_to_non_nullable
              as String?,
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      bookedAt: freezed == bookedAt
          ? _value.bookedAt
          : bookedAt // ignore: cast_nullable_to_non_nullable
              as String?,
      beginAt: freezed == beginAt
          ? _value.beginAt
          : beginAt // ignore: cast_nullable_to_non_nullable
              as String?,
      endAt: freezed == endAt
          ? _value.endAt
          : endAt // ignore: cast_nullable_to_non_nullable
              as String?,
      duration: freezed == duration
          ? _value.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as int?,
      user: freezed == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as User?,
      computer: freezed == computer
          ? _value.computer
          : computer // ignore: cast_nullable_to_non_nullable
              as Computer?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as Status?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $UserCopyWith<$Res>? get user {
    if (_value.user == null) {
      return null;
    }

    return $UserCopyWith<$Res>(_value.user!, (value) {
      return _then(_value.copyWith(user: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $ComputerCopyWith<$Res>? get computer {
    if (_value.computer == null) {
      return null;
    }

    return $ComputerCopyWith<$Res>(_value.computer!, (value) {
      return _then(_value.copyWith(computer: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $StatusCopyWith<$Res>? get status {
    if (_value.status == null) {
      return null;
    }

    return $StatusCopyWith<$Res>(_value.status!, (value) {
      return _then(_value.copyWith(status: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$BookingImplCopyWith<$Res> implements $BookingCopyWith<$Res> {
  factory _$$BookingImplCopyWith(
          _$BookingImpl value, $Res Function(_$BookingImpl) then) =
      __$$BookingImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'id') String? id,
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
      @JsonKey(name: 'status') Status? status});

  @override
  $UserCopyWith<$Res>? get user;
  @override
  $ComputerCopyWith<$Res>? get computer;
  @override
  $StatusCopyWith<$Res>? get status;
}

/// @nodoc
class __$$BookingImplCopyWithImpl<$Res>
    extends _$BookingCopyWithImpl<$Res, _$BookingImpl>
    implements _$$BookingImplCopyWith<$Res> {
  __$$BookingImplCopyWithImpl(
      _$BookingImpl _value, $Res Function(_$BookingImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? userId = freezed,
    Object? statusId = freezed,
    Object? computerId = freezed,
    Object? title = freezed,
    Object? bookedAt = freezed,
    Object? beginAt = freezed,
    Object? endAt = freezed,
    Object? duration = freezed,
    Object? user = freezed,
    Object? computer = freezed,
    Object? status = freezed,
  }) {
    return _then(_$BookingImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      userId: freezed == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String?,
      statusId: freezed == statusId
          ? _value.statusId
          : statusId // ignore: cast_nullable_to_non_nullable
              as String?,
      computerId: freezed == computerId
          ? _value.computerId
          : computerId // ignore: cast_nullable_to_non_nullable
              as String?,
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      bookedAt: freezed == bookedAt
          ? _value.bookedAt
          : bookedAt // ignore: cast_nullable_to_non_nullable
              as String?,
      beginAt: freezed == beginAt
          ? _value.beginAt
          : beginAt // ignore: cast_nullable_to_non_nullable
              as String?,
      endAt: freezed == endAt
          ? _value.endAt
          : endAt // ignore: cast_nullable_to_non_nullable
              as String?,
      duration: freezed == duration
          ? _value.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as int?,
      user: freezed == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as User?,
      computer: freezed == computer
          ? _value.computer
          : computer // ignore: cast_nullable_to_non_nullable
              as Computer?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as Status?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$BookingImpl implements _Booking {
  const _$BookingImpl(
      {@JsonKey(name: 'id') this.id,
      @JsonKey(name: 'user_id') this.userId,
      @JsonKey(name: 'status_id') this.statusId,
      @JsonKey(name: 'computer_id') this.computerId,
      @JsonKey(name: 'title') this.title,
      @JsonKey(name: 'booked_at') this.bookedAt,
      @JsonKey(name: 'begin_at') this.beginAt,
      @JsonKey(name: 'end_at') this.endAt,
      @JsonKey(name: 'duration') this.duration,
      @JsonKey(name: 'user') this.user,
      @JsonKey(name: 'computer') this.computer,
      @JsonKey(name: 'status') this.status});

  factory _$BookingImpl.fromJson(Map<String, dynamic> json) =>
      _$$BookingImplFromJson(json);

  @override
  @JsonKey(name: 'id')
  final String? id;
  @override
  @JsonKey(name: 'user_id')
  final String? userId;
  @override
  @JsonKey(name: 'status_id')
  final String? statusId;
  @override
  @JsonKey(name: 'computer_id')
  final String? computerId;
  @override
  @JsonKey(name: 'title')
  final String? title;
  @override
  @JsonKey(name: 'booked_at')
  final String? bookedAt;
  @override
  @JsonKey(name: 'begin_at')
  final String? beginAt;
  @override
  @JsonKey(name: 'end_at')
  final String? endAt;
  @override
  @JsonKey(name: 'duration')
  final int? duration;
  @override
  @JsonKey(name: 'user')
  final User? user;
  @override
  @JsonKey(name: 'computer')
  final Computer? computer;
  @override
  @JsonKey(name: 'status')
  final Status? status;

  @override
  String toString() {
    return 'Booking(id: $id, userId: $userId, statusId: $statusId, computerId: $computerId, title: $title, bookedAt: $bookedAt, beginAt: $beginAt, endAt: $endAt, duration: $duration, user: $user, computer: $computer, status: $status)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BookingImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.statusId, statusId) ||
                other.statusId == statusId) &&
            (identical(other.computerId, computerId) ||
                other.computerId == computerId) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.bookedAt, bookedAt) ||
                other.bookedAt == bookedAt) &&
            (identical(other.beginAt, beginAt) || other.beginAt == beginAt) &&
            (identical(other.endAt, endAt) || other.endAt == endAt) &&
            (identical(other.duration, duration) ||
                other.duration == duration) &&
            (identical(other.user, user) || other.user == user) &&
            (identical(other.computer, computer) ||
                other.computer == computer) &&
            (identical(other.status, status) || other.status == status));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, userId, statusId, computerId,
      title, bookedAt, beginAt, endAt, duration, user, computer, status);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$BookingImplCopyWith<_$BookingImpl> get copyWith =>
      __$$BookingImplCopyWithImpl<_$BookingImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BookingImplToJson(
      this,
    );
  }
}

abstract class _Booking implements Booking {
  const factory _Booking(
      {@JsonKey(name: 'id') final String? id,
      @JsonKey(name: 'user_id') final String? userId,
      @JsonKey(name: 'status_id') final String? statusId,
      @JsonKey(name: 'computer_id') final String? computerId,
      @JsonKey(name: 'title') final String? title,
      @JsonKey(name: 'booked_at') final String? bookedAt,
      @JsonKey(name: 'begin_at') final String? beginAt,
      @JsonKey(name: 'end_at') final String? endAt,
      @JsonKey(name: 'duration') final int? duration,
      @JsonKey(name: 'user') final User? user,
      @JsonKey(name: 'computer') final Computer? computer,
      @JsonKey(name: 'status') final Status? status}) = _$BookingImpl;

  factory _Booking.fromJson(Map<String, dynamic> json) = _$BookingImpl.fromJson;

  @override
  @JsonKey(name: 'id')
  String? get id;
  @override
  @JsonKey(name: 'user_id')
  String? get userId;
  @override
  @JsonKey(name: 'status_id')
  String? get statusId;
  @override
  @JsonKey(name: 'computer_id')
  String? get computerId;
  @override
  @JsonKey(name: 'title')
  String? get title;
  @override
  @JsonKey(name: 'booked_at')
  String? get bookedAt;
  @override
  @JsonKey(name: 'begin_at')
  String? get beginAt;
  @override
  @JsonKey(name: 'end_at')
  String? get endAt;
  @override
  @JsonKey(name: 'duration')
  int? get duration;
  @override
  @JsonKey(name: 'user')
  User? get user;
  @override
  @JsonKey(name: 'computer')
  Computer? get computer;
  @override
  @JsonKey(name: 'status')
  Status? get status;
  @override
  @JsonKey(ignore: true)
  _$$BookingImplCopyWith<_$BookingImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
