import 'package:freezed_annotation/freezed_annotation.dart';

part 'shared.freezed.dart';
part 'shared.g.dart';

@freezed
sealed class PulseMetadataCompat with _$PulseMetadataCompat {
  const factory PulseMetadataCompat({
    required String sdkVersion,
    required String sdkPlatform,
    String? bundleId,
    String? url,
  }) = _PulseMetadataCompat;

  factory PulseMetadataCompat.fromJson(Map<String, dynamic> json) =>
      _$PulseMetadataCompatFromJson(json);
}
