import 'package:freezed_annotation/freezed_annotation.dart';

part 'computer.freezed.dart';
part 'computer.g.dart';

@freezed
class Computer with _$Computer {
  const factory Computer({
    @JsonKey(name: 'id') String? id,
    @JsonKey(name: 'number') int? number,
    @JsonKey(name: 'slug') String? slug,
  }) = _Computer;

  factory Computer.fromJson(Map<String, dynamic> json) =>
      _$ComputerFromJson(json);
}

extension OnStatusJson on Map<String, dynamic> {
  Computer get toJwt {
    return Computer.fromJson(this);
  }
}
