// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'pivot.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Pivot _$PivotFromJson(Map<String, dynamic> json) {
  return _Pivot.fromJson(json);
}

/// @nodoc
mixin _$Pivot {
  @JsonKey(name: 'model_id')
  String? get modelId => throw _privateConstructorUsedError;
  @JsonKey(name: 'model_type')
  String? get modelType => throw _privateConstructorUsedError;
  @JsonKey(name: 'role_id')
  int? get roleId => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PivotCopyWith<Pivot> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PivotCopyWith<$Res> {
  factory $PivotCopyWith(Pivot value, $Res Function(Pivot) then) =
      _$PivotCopyWithImpl<$Res, Pivot>;
  @useResult
  $Res call(
      {@JsonKey(name: 'model_id') String? modelId,
      @JsonKey(name: 'model_type') String? modelType,
      @JsonKey(name: 'role_id') int? roleId});
}

/// @nodoc
class _$PivotCopyWithImpl<$Res, $Val extends Pivot>
    implements $PivotCopyWith<$Res> {
  _$PivotCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? modelId = freezed,
    Object? modelType = freezed,
    Object? roleId = freezed,
  }) {
    return _then(_value.copyWith(
      modelId: freezed == modelId
          ? _value.modelId
          : modelId // ignore: cast_nullable_to_non_nullable
              as String?,
      modelType: freezed == modelType
          ? _value.modelType
          : modelType // ignore: cast_nullable_to_non_nullable
              as String?,
      roleId: freezed == roleId
          ? _value.roleId
          : roleId // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PivotImplCopyWith<$Res> implements $PivotCopyWith<$Res> {
  factory _$$PivotImplCopyWith(
          _$PivotImpl value, $Res Function(_$PivotImpl) then) =
      __$$PivotImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'model_id') String? modelId,
      @JsonKey(name: 'model_type') String? modelType,
      @JsonKey(name: 'role_id') int? roleId});
}

/// @nodoc
class __$$PivotImplCopyWithImpl<$Res>
    extends _$PivotCopyWithImpl<$Res, _$PivotImpl>
    implements _$$PivotImplCopyWith<$Res> {
  __$$PivotImplCopyWithImpl(
      _$PivotImpl _value, $Res Function(_$PivotImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? modelId = freezed,
    Object? modelType = freezed,
    Object? roleId = freezed,
  }) {
    return _then(_$PivotImpl(
      modelId: freezed == modelId
          ? _value.modelId
          : modelId // ignore: cast_nullable_to_non_nullable
              as String?,
      modelType: freezed == modelType
          ? _value.modelType
          : modelType // ignore: cast_nullable_to_non_nullable
              as String?,
      roleId: freezed == roleId
          ? _value.roleId
          : roleId // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PivotImpl implements _Pivot {
  const _$PivotImpl(
      {@JsonKey(name: 'model_id') this.modelId,
      @JsonKey(name: 'model_type') this.modelType,
      @JsonKey(name: 'role_id') this.roleId});

  factory _$PivotImpl.fromJson(Map<String, dynamic> json) =>
      _$$PivotImplFromJson(json);

  @override
  @JsonKey(name: 'model_id')
  final String? modelId;
  @override
  @JsonKey(name: 'model_type')
  final String? modelType;
  @override
  @JsonKey(name: 'role_id')
  final int? roleId;

  @override
  String toString() {
    return 'Pivot(modelId: $modelId, modelType: $modelType, roleId: $roleId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PivotImpl &&
            (identical(other.modelId, modelId) || other.modelId == modelId) &&
            (identical(other.modelType, modelType) ||
                other.modelType == modelType) &&
            (identical(other.roleId, roleId) || other.roleId == roleId));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, modelId, modelType, roleId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PivotImplCopyWith<_$PivotImpl> get copyWith =>
      __$$PivotImplCopyWithImpl<_$PivotImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PivotImplToJson(
      this,
    );
  }
}

abstract class _Pivot implements Pivot {
  const factory _Pivot(
      {@JsonKey(name: 'model_id') final String? modelId,
      @JsonKey(name: 'model_type') final String? modelType,
      @JsonKey(name: 'role_id') final int? roleId}) = _$PivotImpl;

  factory _Pivot.fromJson(Map<String, dynamic> json) = _$PivotImpl.fromJson;

  @override
  @JsonKey(name: 'model_id')
  String? get modelId;
  @override
  @JsonKey(name: 'model_type')
  String? get modelType;
  @override
  @JsonKey(name: 'role_id')
  int? get roleId;
  @override
  @JsonKey(ignore: true)
  _$$PivotImplCopyWith<_$PivotImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
