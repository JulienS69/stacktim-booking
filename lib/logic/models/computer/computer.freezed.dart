// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'computer.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Computer _$ComputerFromJson(Map<String, dynamic> json) {
  return _Computer.fromJson(json);
}

/// @nodoc
mixin _$Computer {
  @JsonKey(name: 'id')
  String? get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'number')
  int? get number => throw _privateConstructorUsedError;
  @JsonKey(name: 'slug')
  String? get slug => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_under_maintenance')
  bool? get isUnderMaintenance => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_available')
  bool? get isAvailable => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ComputerCopyWith<Computer> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ComputerCopyWith<$Res> {
  factory $ComputerCopyWith(Computer value, $Res Function(Computer) then) =
      _$ComputerCopyWithImpl<$Res, Computer>;
  @useResult
  $Res call(
      {@JsonKey(name: 'id') String? id,
      @JsonKey(name: 'number') int? number,
      @JsonKey(name: 'slug') String? slug,
      @JsonKey(name: 'is_under_maintenance') bool? isUnderMaintenance,
      @JsonKey(name: 'is_available') bool? isAvailable});
}

/// @nodoc
class _$ComputerCopyWithImpl<$Res, $Val extends Computer>
    implements $ComputerCopyWith<$Res> {
  _$ComputerCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? number = freezed,
    Object? slug = freezed,
    Object? isUnderMaintenance = freezed,
    Object? isAvailable = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      number: freezed == number
          ? _value.number
          : number // ignore: cast_nullable_to_non_nullable
              as int?,
      slug: freezed == slug
          ? _value.slug
          : slug // ignore: cast_nullable_to_non_nullable
              as String?,
      isUnderMaintenance: freezed == isUnderMaintenance
          ? _value.isUnderMaintenance
          : isUnderMaintenance // ignore: cast_nullable_to_non_nullable
              as bool?,
      isAvailable: freezed == isAvailable
          ? _value.isAvailable
          : isAvailable // ignore: cast_nullable_to_non_nullable
              as bool?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ComputerImplCopyWith<$Res>
    implements $ComputerCopyWith<$Res> {
  factory _$$ComputerImplCopyWith(
          _$ComputerImpl value, $Res Function(_$ComputerImpl) then) =
      __$$ComputerImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'id') String? id,
      @JsonKey(name: 'number') int? number,
      @JsonKey(name: 'slug') String? slug,
      @JsonKey(name: 'is_under_maintenance') bool? isUnderMaintenance,
      @JsonKey(name: 'is_available') bool? isAvailable});
}

/// @nodoc
class __$$ComputerImplCopyWithImpl<$Res>
    extends _$ComputerCopyWithImpl<$Res, _$ComputerImpl>
    implements _$$ComputerImplCopyWith<$Res> {
  __$$ComputerImplCopyWithImpl(
      _$ComputerImpl _value, $Res Function(_$ComputerImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? number = freezed,
    Object? slug = freezed,
    Object? isUnderMaintenance = freezed,
    Object? isAvailable = freezed,
  }) {
    return _then(_$ComputerImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      number: freezed == number
          ? _value.number
          : number // ignore: cast_nullable_to_non_nullable
              as int?,
      slug: freezed == slug
          ? _value.slug
          : slug // ignore: cast_nullable_to_non_nullable
              as String?,
      isUnderMaintenance: freezed == isUnderMaintenance
          ? _value.isUnderMaintenance
          : isUnderMaintenance // ignore: cast_nullable_to_non_nullable
              as bool?,
      isAvailable: freezed == isAvailable
          ? _value.isAvailable
          : isAvailable // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ComputerImpl implements _Computer {
  const _$ComputerImpl(
      {@JsonKey(name: 'id') this.id,
      @JsonKey(name: 'number') this.number,
      @JsonKey(name: 'slug') this.slug,
      @JsonKey(name: 'is_under_maintenance') this.isUnderMaintenance,
      @JsonKey(name: 'is_available') this.isAvailable});

  factory _$ComputerImpl.fromJson(Map<String, dynamic> json) =>
      _$$ComputerImplFromJson(json);

  @override
  @JsonKey(name: 'id')
  final String? id;
  @override
  @JsonKey(name: 'number')
  final int? number;
  @override
  @JsonKey(name: 'slug')
  final String? slug;
  @override
  @JsonKey(name: 'is_under_maintenance')
  final bool? isUnderMaintenance;
  @override
  @JsonKey(name: 'is_available')
  final bool? isAvailable;

  @override
  String toString() {
    return 'Computer(id: $id, number: $number, slug: $slug, isUnderMaintenance: $isUnderMaintenance, isAvailable: $isAvailable)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ComputerImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.number, number) || other.number == number) &&
            (identical(other.slug, slug) || other.slug == slug) &&
            (identical(other.isUnderMaintenance, isUnderMaintenance) ||
                other.isUnderMaintenance == isUnderMaintenance) &&
            (identical(other.isAvailable, isAvailable) ||
                other.isAvailable == isAvailable));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, number, slug, isUnderMaintenance, isAvailable);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ComputerImplCopyWith<_$ComputerImpl> get copyWith =>
      __$$ComputerImplCopyWithImpl<_$ComputerImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ComputerImplToJson(
      this,
    );
  }
}

abstract class _Computer implements Computer {
  const factory _Computer(
      {@JsonKey(name: 'id') final String? id,
      @JsonKey(name: 'number') final int? number,
      @JsonKey(name: 'slug') final String? slug,
      @JsonKey(name: 'is_under_maintenance') final bool? isUnderMaintenance,
      @JsonKey(name: 'is_available') final bool? isAvailable}) = _$ComputerImpl;

  factory _Computer.fromJson(Map<String, dynamic> json) =
      _$ComputerImpl.fromJson;

  @override
  @JsonKey(name: 'id')
  String? get id;
  @override
  @JsonKey(name: 'number')
  int? get number;
  @override
  @JsonKey(name: 'slug')
  String? get slug;
  @override
  @JsonKey(name: 'is_under_maintenance')
  bool? get isUnderMaintenance;
  @override
  @JsonKey(name: 'is_available')
  bool? get isAvailable;
  @override
  @JsonKey(ignore: true)
  _$$ComputerImplCopyWith<_$ComputerImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
