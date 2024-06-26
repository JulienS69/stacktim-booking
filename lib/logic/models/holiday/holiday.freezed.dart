// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'holiday.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Holiday _$HolidayFromJson(Map<String, dynamic> json) {
  return _Holiday.fromJson(json);
}

/// @nodoc
mixin _$Holiday {
  @JsonKey(name: 'date')
  String? get dateHoliday => throw _privateConstructorUsedError;
  @JsonKey(name: 'nom_jour_ferie')
  String? get nameHoliday => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $HolidayCopyWith<Holiday> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HolidayCopyWith<$Res> {
  factory $HolidayCopyWith(Holiday value, $Res Function(Holiday) then) =
      _$HolidayCopyWithImpl<$Res, Holiday>;
  @useResult
  $Res call(
      {@JsonKey(name: 'date') String? dateHoliday,
      @JsonKey(name: 'nom_jour_ferie') String? nameHoliday});
}

/// @nodoc
class _$HolidayCopyWithImpl<$Res, $Val extends Holiday>
    implements $HolidayCopyWith<$Res> {
  _$HolidayCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? dateHoliday = freezed,
    Object? nameHoliday = freezed,
  }) {
    return _then(_value.copyWith(
      dateHoliday: freezed == dateHoliday
          ? _value.dateHoliday
          : dateHoliday // ignore: cast_nullable_to_non_nullable
              as String?,
      nameHoliday: freezed == nameHoliday
          ? _value.nameHoliday
          : nameHoliday // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$HolidayImplCopyWith<$Res> implements $HolidayCopyWith<$Res> {
  factory _$$HolidayImplCopyWith(
          _$HolidayImpl value, $Res Function(_$HolidayImpl) then) =
      __$$HolidayImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'date') String? dateHoliday,
      @JsonKey(name: 'nom_jour_ferie') String? nameHoliday});
}

/// @nodoc
class __$$HolidayImplCopyWithImpl<$Res>
    extends _$HolidayCopyWithImpl<$Res, _$HolidayImpl>
    implements _$$HolidayImplCopyWith<$Res> {
  __$$HolidayImplCopyWithImpl(
      _$HolidayImpl _value, $Res Function(_$HolidayImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? dateHoliday = freezed,
    Object? nameHoliday = freezed,
  }) {
    return _then(_$HolidayImpl(
      dateHoliday: freezed == dateHoliday
          ? _value.dateHoliday
          : dateHoliday // ignore: cast_nullable_to_non_nullable
              as String?,
      nameHoliday: freezed == nameHoliday
          ? _value.nameHoliday
          : nameHoliday // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$HolidayImpl implements _Holiday {
  const _$HolidayImpl(
      {@JsonKey(name: 'date') this.dateHoliday,
      @JsonKey(name: 'nom_jour_ferie') this.nameHoliday});

  factory _$HolidayImpl.fromJson(Map<String, dynamic> json) =>
      _$$HolidayImplFromJson(json);

  @override
  @JsonKey(name: 'date')
  final String? dateHoliday;
  @override
  @JsonKey(name: 'nom_jour_ferie')
  final String? nameHoliday;

  @override
  String toString() {
    return 'Holiday(dateHoliday: $dateHoliday, nameHoliday: $nameHoliday)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HolidayImpl &&
            (identical(other.dateHoliday, dateHoliday) ||
                other.dateHoliday == dateHoliday) &&
            (identical(other.nameHoliday, nameHoliday) ||
                other.nameHoliday == nameHoliday));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, dateHoliday, nameHoliday);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$HolidayImplCopyWith<_$HolidayImpl> get copyWith =>
      __$$HolidayImplCopyWithImpl<_$HolidayImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$HolidayImplToJson(
      this,
    );
  }
}

abstract class _Holiday implements Holiday {
  const factory _Holiday(
          {@JsonKey(name: 'date') final String? dateHoliday,
          @JsonKey(name: 'nom_jour_ferie') final String? nameHoliday}) =
      _$HolidayImpl;

  factory _Holiday.fromJson(Map<String, dynamic> json) = _$HolidayImpl.fromJson;

  @override
  @JsonKey(name: 'date')
  String? get dateHoliday;
  @override
  @JsonKey(name: 'nom_jour_ferie')
  String? get nameHoliday;
  @override
  @JsonKey(ignore: true)
  _$$HolidayImplCopyWith<_$HolidayImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
