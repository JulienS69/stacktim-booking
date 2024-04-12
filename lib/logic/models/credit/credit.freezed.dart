// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'credit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Credit _$CreditFromJson(Map<String, dynamic> json) {
  return _Credit.fromJson(json);
}

/// @nodoc
mixin _$Credit {
  @JsonKey(name: 'id')
  String? get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'user_id')
  String? get userId => throw _privateConstructorUsedError;
  @JsonKey(name: 'available')
  int? get creditAvailable => throw _privateConstructorUsedError;
  @JsonKey(name: 'used')
  int? get creditUsed => throw _privateConstructorUsedError;
  @JsonKey(name: 'not_yet_used')
  int? get notYetUsed => throw _privateConstructorUsedError;
  @JsonKey(name: 'penalties')
  int? get penalties => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CreditCopyWith<Credit> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CreditCopyWith<$Res> {
  factory $CreditCopyWith(Credit value, $Res Function(Credit) then) =
      _$CreditCopyWithImpl<$Res, Credit>;
  @useResult
  $Res call(
      {@JsonKey(name: 'id') String? id,
      @JsonKey(name: 'user_id') String? userId,
      @JsonKey(name: 'available') int? creditAvailable,
      @JsonKey(name: 'used') int? creditUsed,
      @JsonKey(name: 'not_yet_used') int? notYetUsed,
      @JsonKey(name: 'penalties') int? penalties});
}

/// @nodoc
class _$CreditCopyWithImpl<$Res, $Val extends Credit>
    implements $CreditCopyWith<$Res> {
  _$CreditCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? userId = freezed,
    Object? creditAvailable = freezed,
    Object? creditUsed = freezed,
    Object? notYetUsed = freezed,
    Object? penalties = freezed,
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
      creditAvailable: freezed == creditAvailable
          ? _value.creditAvailable
          : creditAvailable // ignore: cast_nullable_to_non_nullable
              as int?,
      creditUsed: freezed == creditUsed
          ? _value.creditUsed
          : creditUsed // ignore: cast_nullable_to_non_nullable
              as int?,
      notYetUsed: freezed == notYetUsed
          ? _value.notYetUsed
          : notYetUsed // ignore: cast_nullable_to_non_nullable
              as int?,
      penalties: freezed == penalties
          ? _value.penalties
          : penalties // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CreditImplCopyWith<$Res> implements $CreditCopyWith<$Res> {
  factory _$$CreditImplCopyWith(
          _$CreditImpl value, $Res Function(_$CreditImpl) then) =
      __$$CreditImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'id') String? id,
      @JsonKey(name: 'user_id') String? userId,
      @JsonKey(name: 'available') int? creditAvailable,
      @JsonKey(name: 'used') int? creditUsed,
      @JsonKey(name: 'not_yet_used') int? notYetUsed,
      @JsonKey(name: 'penalties') int? penalties});
}

/// @nodoc
class __$$CreditImplCopyWithImpl<$Res>
    extends _$CreditCopyWithImpl<$Res, _$CreditImpl>
    implements _$$CreditImplCopyWith<$Res> {
  __$$CreditImplCopyWithImpl(
      _$CreditImpl _value, $Res Function(_$CreditImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? userId = freezed,
    Object? creditAvailable = freezed,
    Object? creditUsed = freezed,
    Object? notYetUsed = freezed,
    Object? penalties = freezed,
  }) {
    return _then(_$CreditImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      userId: freezed == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String?,
      creditAvailable: freezed == creditAvailable
          ? _value.creditAvailable
          : creditAvailable // ignore: cast_nullable_to_non_nullable
              as int?,
      creditUsed: freezed == creditUsed
          ? _value.creditUsed
          : creditUsed // ignore: cast_nullable_to_non_nullable
              as int?,
      notYetUsed: freezed == notYetUsed
          ? _value.notYetUsed
          : notYetUsed // ignore: cast_nullable_to_non_nullable
              as int?,
      penalties: freezed == penalties
          ? _value.penalties
          : penalties // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CreditImpl implements _Credit {
  const _$CreditImpl(
      {@JsonKey(name: 'id') this.id,
      @JsonKey(name: 'user_id') this.userId,
      @JsonKey(name: 'available') this.creditAvailable,
      @JsonKey(name: 'used') this.creditUsed,
      @JsonKey(name: 'not_yet_used') this.notYetUsed,
      @JsonKey(name: 'penalties') this.penalties});

  factory _$CreditImpl.fromJson(Map<String, dynamic> json) =>
      _$$CreditImplFromJson(json);

  @override
  @JsonKey(name: 'id')
  final String? id;
  @override
  @JsonKey(name: 'user_id')
  final String? userId;
  @override
  @JsonKey(name: 'available')
  final int? creditAvailable;
  @override
  @JsonKey(name: 'used')
  final int? creditUsed;
  @override
  @JsonKey(name: 'not_yet_used')
  final int? notYetUsed;
  @override
  @JsonKey(name: 'penalties')
  final int? penalties;

  @override
  String toString() {
    return 'Credit(id: $id, userId: $userId, creditAvailable: $creditAvailable, creditUsed: $creditUsed, notYetUsed: $notYetUsed, penalties: $penalties)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CreditImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.creditAvailable, creditAvailable) ||
                other.creditAvailable == creditAvailable) &&
            (identical(other.creditUsed, creditUsed) ||
                other.creditUsed == creditUsed) &&
            (identical(other.notYetUsed, notYetUsed) ||
                other.notYetUsed == notYetUsed) &&
            (identical(other.penalties, penalties) ||
                other.penalties == penalties));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, userId, creditAvailable,
      creditUsed, notYetUsed, penalties);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CreditImplCopyWith<_$CreditImpl> get copyWith =>
      __$$CreditImplCopyWithImpl<_$CreditImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CreditImplToJson(
      this,
    );
  }
}

abstract class _Credit implements Credit {
  const factory _Credit(
      {@JsonKey(name: 'id') final String? id,
      @JsonKey(name: 'user_id') final String? userId,
      @JsonKey(name: 'available') final int? creditAvailable,
      @JsonKey(name: 'used') final int? creditUsed,
      @JsonKey(name: 'not_yet_used') final int? notYetUsed,
      @JsonKey(name: 'penalties') final int? penalties}) = _$CreditImpl;

  factory _Credit.fromJson(Map<String, dynamic> json) = _$CreditImpl.fromJson;

  @override
  @JsonKey(name: 'id')
  String? get id;
  @override
  @JsonKey(name: 'user_id')
  String? get userId;
  @override
  @JsonKey(name: 'available')
  int? get creditAvailable;
  @override
  @JsonKey(name: 'used')
  int? get creditUsed;
  @override
  @JsonKey(name: 'not_yet_used')
  int? get notYetUsed;
  @override
  @JsonKey(name: 'penalties')
  int? get penalties;
  @override
  @JsonKey(ignore: true)
  _$$CreditImplCopyWith<_$CreditImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
