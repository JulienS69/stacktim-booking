// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

User _$UserFromJson(Map<String, dynamic> json) {
  return _User.fromJson(json);
}

/// @nodoc
mixin _$User {
  @JsonKey(name: 'id')
  String? get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'firstname')
  String? get firstname => throw _privateConstructorUsedError;
  @JsonKey(name: 'lastname')
  String? get lastName => throw _privateConstructorUsedError;
  @JsonKey(name: 'nickname')
  String? get nickName => throw _privateConstructorUsedError;
  @JsonKey(name: 'email')
  String? get email => throw _privateConstructorUsedError;
  @JsonKey(name: 'roles')
  List<Role>? get roles => throw _privateConstructorUsedError;
  @JsonKey(name: 'credit')
  Credit? get credit => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UserCopyWith<User> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserCopyWith<$Res> {
  factory $UserCopyWith(User value, $Res Function(User) then) =
      _$UserCopyWithImpl<$Res, User>;
  @useResult
  $Res call(
      {@JsonKey(name: 'id') String? id,
      @JsonKey(name: 'firstname') String? firstname,
      @JsonKey(name: 'lastname') String? lastName,
      @JsonKey(name: 'nickname') String? nickName,
      @JsonKey(name: 'email') String? email,
      @JsonKey(name: 'roles') List<Role>? roles,
      @JsonKey(name: 'credit') Credit? credit});

  $CreditCopyWith<$Res>? get credit;
}

/// @nodoc
class _$UserCopyWithImpl<$Res, $Val extends User>
    implements $UserCopyWith<$Res> {
  _$UserCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? firstname = freezed,
    Object? lastName = freezed,
    Object? nickName = freezed,
    Object? email = freezed,
    Object? roles = freezed,
    Object? credit = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      firstname: freezed == firstname
          ? _value.firstname
          : firstname // ignore: cast_nullable_to_non_nullable
              as String?,
      lastName: freezed == lastName
          ? _value.lastName
          : lastName // ignore: cast_nullable_to_non_nullable
              as String?,
      nickName: freezed == nickName
          ? _value.nickName
          : nickName // ignore: cast_nullable_to_non_nullable
              as String?,
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      roles: freezed == roles
          ? _value.roles
          : roles // ignore: cast_nullable_to_non_nullable
              as List<Role>?,
      credit: freezed == credit
          ? _value.credit
          : credit // ignore: cast_nullable_to_non_nullable
              as Credit?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $CreditCopyWith<$Res>? get credit {
    if (_value.credit == null) {
      return null;
    }

    return $CreditCopyWith<$Res>(_value.credit!, (value) {
      return _then(_value.copyWith(credit: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$UserImplCopyWith<$Res> implements $UserCopyWith<$Res> {
  factory _$$UserImplCopyWith(
          _$UserImpl value, $Res Function(_$UserImpl) then) =
      __$$UserImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'id') String? id,
      @JsonKey(name: 'firstname') String? firstname,
      @JsonKey(name: 'lastname') String? lastName,
      @JsonKey(name: 'nickname') String? nickName,
      @JsonKey(name: 'email') String? email,
      @JsonKey(name: 'roles') List<Role>? roles,
      @JsonKey(name: 'credit') Credit? credit});

  @override
  $CreditCopyWith<$Res>? get credit;
}

/// @nodoc
class __$$UserImplCopyWithImpl<$Res>
    extends _$UserCopyWithImpl<$Res, _$UserImpl>
    implements _$$UserImplCopyWith<$Res> {
  __$$UserImplCopyWithImpl(_$UserImpl _value, $Res Function(_$UserImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? firstname = freezed,
    Object? lastName = freezed,
    Object? nickName = freezed,
    Object? email = freezed,
    Object? roles = freezed,
    Object? credit = freezed,
  }) {
    return _then(_$UserImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      firstname: freezed == firstname
          ? _value.firstname
          : firstname // ignore: cast_nullable_to_non_nullable
              as String?,
      lastName: freezed == lastName
          ? _value.lastName
          : lastName // ignore: cast_nullable_to_non_nullable
              as String?,
      nickName: freezed == nickName
          ? _value.nickName
          : nickName // ignore: cast_nullable_to_non_nullable
              as String?,
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      roles: freezed == roles
          ? _value._roles
          : roles // ignore: cast_nullable_to_non_nullable
              as List<Role>?,
      credit: freezed == credit
          ? _value.credit
          : credit // ignore: cast_nullable_to_non_nullable
              as Credit?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UserImpl implements _User {
  const _$UserImpl(
      {@JsonKey(name: 'id') this.id,
      @JsonKey(name: 'firstname') this.firstname,
      @JsonKey(name: 'lastname') this.lastName,
      @JsonKey(name: 'nickname') this.nickName,
      @JsonKey(name: 'email') this.email,
      @JsonKey(name: 'roles') final List<Role>? roles,
      @JsonKey(name: 'credit') this.credit})
      : _roles = roles;

  factory _$UserImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserImplFromJson(json);

  @override
  @JsonKey(name: 'id')
  final String? id;
  @override
  @JsonKey(name: 'firstname')
  final String? firstname;
  @override
  @JsonKey(name: 'lastname')
  final String? lastName;
  @override
  @JsonKey(name: 'nickname')
  final String? nickName;
  @override
  @JsonKey(name: 'email')
  final String? email;
  final List<Role>? _roles;
  @override
  @JsonKey(name: 'roles')
  List<Role>? get roles {
    final value = _roles;
    if (value == null) return null;
    if (_roles is EqualUnmodifiableListView) return _roles;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  @JsonKey(name: 'credit')
  final Credit? credit;

  @override
  String toString() {
    return 'User(id: $id, firstname: $firstname, lastName: $lastName, nickName: $nickName, email: $email, roles: $roles, credit: $credit)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.firstname, firstname) ||
                other.firstname == firstname) &&
            (identical(other.lastName, lastName) ||
                other.lastName == lastName) &&
            (identical(other.nickName, nickName) ||
                other.nickName == nickName) &&
            (identical(other.email, email) || other.email == email) &&
            const DeepCollectionEquality().equals(other._roles, _roles) &&
            (identical(other.credit, credit) || other.credit == credit));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, firstname, lastName,
      nickName, email, const DeepCollectionEquality().hash(_roles), credit);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$UserImplCopyWith<_$UserImpl> get copyWith =>
      __$$UserImplCopyWithImpl<_$UserImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserImplToJson(
      this,
    );
  }
}

abstract class _User implements User {
  const factory _User(
      {@JsonKey(name: 'id') final String? id,
      @JsonKey(name: 'firstname') final String? firstname,
      @JsonKey(name: 'lastname') final String? lastName,
      @JsonKey(name: 'nickname') final String? nickName,
      @JsonKey(name: 'email') final String? email,
      @JsonKey(name: 'roles') final List<Role>? roles,
      @JsonKey(name: 'credit') final Credit? credit}) = _$UserImpl;

  factory _User.fromJson(Map<String, dynamic> json) = _$UserImpl.fromJson;

  @override
  @JsonKey(name: 'id')
  String? get id;
  @override
  @JsonKey(name: 'firstname')
  String? get firstname;
  @override
  @JsonKey(name: 'lastname')
  String? get lastName;
  @override
  @JsonKey(name: 'nickname')
  String? get nickName;
  @override
  @JsonKey(name: 'email')
  String? get email;
  @override
  @JsonKey(name: 'roles')
  List<Role>? get roles;
  @override
  @JsonKey(name: 'credit')
  Credit? get credit;
  @override
  @JsonKey(ignore: true)
  _$$UserImplCopyWith<_$UserImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
