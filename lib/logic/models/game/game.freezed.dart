// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'game.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Game _$GameFromJson(Map<String, dynamic> json) {
  return _Game.fromJson(json);
}

/// @nodoc
mixin _$Game {
  @JsonKey(name: 'id')
  String? get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'label')
  String? get label => throw _privateConstructorUsedError;
  @JsonKey(name: 'order')
  int? get order => throw _privateConstructorUsedError;
  @JsonKey(name: 'media')
  List<Media>? get media => throw _privateConstructorUsedError;
  bool? get isSelected => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $GameCopyWith<Game> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GameCopyWith<$Res> {
  factory $GameCopyWith(Game value, $Res Function(Game) then) =
      _$GameCopyWithImpl<$Res, Game>;
  @useResult
  $Res call(
      {@JsonKey(name: 'id') String? id,
      @JsonKey(name: 'label') String? label,
      @JsonKey(name: 'order') int? order,
      @JsonKey(name: 'media') List<Media>? media,
      bool? isSelected});
}

/// @nodoc
class _$GameCopyWithImpl<$Res, $Val extends Game>
    implements $GameCopyWith<$Res> {
  _$GameCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? label = freezed,
    Object? order = freezed,
    Object? media = freezed,
    Object? isSelected = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      label: freezed == label
          ? _value.label
          : label // ignore: cast_nullable_to_non_nullable
              as String?,
      order: freezed == order
          ? _value.order
          : order // ignore: cast_nullable_to_non_nullable
              as int?,
      media: freezed == media
          ? _value.media
          : media // ignore: cast_nullable_to_non_nullable
              as List<Media>?,
      isSelected: freezed == isSelected
          ? _value.isSelected
          : isSelected // ignore: cast_nullable_to_non_nullable
              as bool?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$GameImplCopyWith<$Res> implements $GameCopyWith<$Res> {
  factory _$$GameImplCopyWith(
          _$GameImpl value, $Res Function(_$GameImpl) then) =
      __$$GameImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'id') String? id,
      @JsonKey(name: 'label') String? label,
      @JsonKey(name: 'order') int? order,
      @JsonKey(name: 'media') List<Media>? media,
      bool? isSelected});
}

/// @nodoc
class __$$GameImplCopyWithImpl<$Res>
    extends _$GameCopyWithImpl<$Res, _$GameImpl>
    implements _$$GameImplCopyWith<$Res> {
  __$$GameImplCopyWithImpl(_$GameImpl _value, $Res Function(_$GameImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? label = freezed,
    Object? order = freezed,
    Object? media = freezed,
    Object? isSelected = freezed,
  }) {
    return _then(_$GameImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      label: freezed == label
          ? _value.label
          : label // ignore: cast_nullable_to_non_nullable
              as String?,
      order: freezed == order
          ? _value.order
          : order // ignore: cast_nullable_to_non_nullable
              as int?,
      media: freezed == media
          ? _value._media
          : media // ignore: cast_nullable_to_non_nullable
              as List<Media>?,
      isSelected: freezed == isSelected
          ? _value.isSelected
          : isSelected // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$GameImpl implements _Game {
  const _$GameImpl(
      {@JsonKey(name: 'id') this.id,
      @JsonKey(name: 'label') this.label,
      @JsonKey(name: 'order') this.order,
      @JsonKey(name: 'media') final List<Media>? media,
      this.isSelected})
      : _media = media;

  factory _$GameImpl.fromJson(Map<String, dynamic> json) =>
      _$$GameImplFromJson(json);

  @override
  @JsonKey(name: 'id')
  final String? id;
  @override
  @JsonKey(name: 'label')
  final String? label;
  @override
  @JsonKey(name: 'order')
  final int? order;
  final List<Media>? _media;
  @override
  @JsonKey(name: 'media')
  List<Media>? get media {
    final value = _media;
    if (value == null) return null;
    if (_media is EqualUnmodifiableListView) return _media;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final bool? isSelected;

  @override
  String toString() {
    return 'Game(id: $id, label: $label, order: $order, media: $media, isSelected: $isSelected)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GameImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.label, label) || other.label == label) &&
            (identical(other.order, order) || other.order == order) &&
            const DeepCollectionEquality().equals(other._media, _media) &&
            (identical(other.isSelected, isSelected) ||
                other.isSelected == isSelected));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, label, order,
      const DeepCollectionEquality().hash(_media), isSelected);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$GameImplCopyWith<_$GameImpl> get copyWith =>
      __$$GameImplCopyWithImpl<_$GameImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GameImplToJson(
      this,
    );
  }
}

abstract class _Game implements Game {
  const factory _Game(
      {@JsonKey(name: 'id') final String? id,
      @JsonKey(name: 'label') final String? label,
      @JsonKey(name: 'order') final int? order,
      @JsonKey(name: 'media') final List<Media>? media,
      final bool? isSelected}) = _$GameImpl;

  factory _Game.fromJson(Map<String, dynamic> json) = _$GameImpl.fromJson;

  @override
  @JsonKey(name: 'id')
  String? get id;
  @override
  @JsonKey(name: 'label')
  String? get label;
  @override
  @JsonKey(name: 'order')
  int? get order;
  @override
  @JsonKey(name: 'media')
  List<Media>? get media;
  @override
  bool? get isSelected;
  @override
  @JsonKey(ignore: true)
  _$$GameImplCopyWith<_$GameImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
