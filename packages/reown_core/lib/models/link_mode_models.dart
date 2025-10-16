import 'package:freezed_annotation/freezed_annotation.dart';

part 'link_mode_models.freezed.dart';

@freezed
sealed class LinkModeOptions with _$LinkModeOptions {
  const factory LinkModeOptions({required int tag}) = _LinkModeOptions;
}
