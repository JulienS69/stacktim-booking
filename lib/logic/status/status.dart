import 'package:freezed_annotation/freezed_annotation.dart';

part 'status.freezed.dart';
part 'status.g.dart';

@freezed
class Status with _$Status {
  const factory Status({
    @JsonKey(name: 'id') int? id,
    @JsonKey(name: 'status_name') String? statusName,
  }) = _Status;

  factory Status.fromJson(Map<String, dynamic> json) => _$StatusFromJson(json);
}

extension OnStatusJson on Map<String, dynamic> {
  Status get toJwt {
    return Status.fromJson(this);
  }
}
