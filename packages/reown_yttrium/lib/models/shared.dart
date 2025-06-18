import 'package:freezed_annotation/freezed_annotation.dart';

part 'shared.freezed.dart';
part 'shared.g.dart';

@freezed
class PulseMetadataCompat with _$PulseMetadataCompat {
  const factory PulseMetadataCompat({
    String? url,
    String? bundleId,
    String? packageName,
    required String sdkVersion,
    required String sdkPlatform,
  }) = _PulseMetadataCompat;

  factory PulseMetadataCompat.fromJson(Map<String, dynamic> json) =>
      _$PulseMetadataCompatFromJson(json);
}
