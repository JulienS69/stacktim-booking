import 'package:freezed_annotation/freezed_annotation.dart';

part 'media.freezed.dart';
part 'media.g.dart';

@freezed
class Media with _$Media {
  const factory Media({
    @JsonKey(name: 'id') int? id,
    @JsonKey(name: 'original_url') String? originalUrl,
  }) = _Media;

  factory Media.fromJson(Map<String, dynamic> json) => _$MediaFromJson(json);
}

extension OnMediaJson on Map<String, dynamic> {
  Media get toMedia {
    return Media.fromJson(this);
  }
}
