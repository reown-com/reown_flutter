import 'package:freezed_annotation/freezed_annotation.dart';

part 'appkit_modal_radiuses.freezed.dart';

@freezed
class ReownAppKitModalRadiuses with _$ReownAppKitModalRadiuses {
  const factory ReownAppKitModalRadiuses({
    @Default(6.0) double radius4XS,
    @Default(8.0) double radius3XS,
    @Default(12.0) double radius2XS,
    @Default(16.0) double radiusXS,
    @Default(20.0) double radiusS,
    @Default(28.0) double radiusM,
    @Default(36.0) double radiusL,
    @Default(80.0) double radius3XL,
  }) = _ReownAppKitModalRadiuses;

  static const square = ReownAppKitModalRadiuses(
    radius4XS: 0.0,
    radius3XS: 0.0,
    radius2XS: 0.0,
    radiusXS: 0.0,
    radiusS: 0.0,
    radiusM: 0.0,
    radiusL: 0.0,
    radius3XL: 0.0,
  );

  static const circular = ReownAppKitModalRadiuses(
    radius4XS: 100.0,
    radius3XS: 100.0,
    radius2XS: 100.0,
    radiusXS: 100.0,
    radiusS: 100.0,
    radiusM: 100.0,
    radiusL: 100.0,
    radius3XL: 100.0,
  );
}

extension ReownAppKitModalRadiusesExtension on ReownAppKitModalRadiuses {
  bool isSquare() {
    return radius4XS == 0.0 &&
        radius3XS == 0.0 &&
        radius2XS == 0.0 &&
        radiusXS == 0.0 &&
        radiusS == 0.0 &&
        radiusM == 0.0 &&
        radiusL == 0.0 &&
        radius3XL == 0.0;
  }

  bool isCircular() {
    return radius4XS == 100.0 &&
        radius3XS == 100.0 &&
        radius2XS == 100.0 &&
        radiusXS == 100.0 &&
        radiusS == 100.0 &&
        radiusM == 100.0 &&
        radiusL == 100.0 &&
        radius3XL == 100.0;
  }
}
