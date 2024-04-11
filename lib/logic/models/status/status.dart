import 'package:freezed_annotation/freezed_annotation.dart';

part 'status.freezed.dart';
part 'status.g.dart';

@freezed
class Status with _$Status {
  const factory Status({
    @JsonKey(name: 'id') String? id,
    @JsonKey(name: 'slug') String? slug,
    @JsonKey(name: 'label') String? label,
    @JsonKey(name: 'color') String? color,
  }) = _Status;

  factory Status.fromJson(Map<String, dynamic> json) => _$StatusFromJson(json);
}

extension OnStatusJson on Map<String, dynamic> {
  Status get toJwt {
    return Status.fromJson(this);
  }
}
