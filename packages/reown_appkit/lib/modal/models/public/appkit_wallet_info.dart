import 'package:freezed_annotation/freezed_annotation.dart';

part 'appkit_wallet_info.freezed.dart';
part 'appkit_wallet_info.g.dart';

@freezed
sealed class ReownAppKitModalWalletInfo with _$ReownAppKitModalWalletInfo {
  const factory ReownAppKitModalWalletInfo({
    required AppKitModalWalletListing listing,
    @Default(false) bool installed,
    @Default(false) bool recent,
  }) = _ReownAppKitModalWalletInfo;

  factory ReownAppKitModalWalletInfo.fromJson(Map<String, dynamic> json) =>
      _$ReownAppKitModalWalletInfoFromJson(json);
}

@freezed
sealed class AppKitModalWalletListing with _$AppKitModalWalletListing {
  const factory AppKitModalWalletListing({
    required String id,
    required String name,
    required String homepage,
    @JsonKey(name: 'image_id') required String imageId,
    required int order,
    @JsonKey(name: 'mobile_link') String? mobileLink,
    @JsonKey(name: 'desktop_link') String? desktopLink,
    @JsonKey(name: 'link_mode') String? linkMode,
    @JsonKey(name: 'webapp_link') String? webappLink,
    @JsonKey(name: 'app_store') String? appStore,
    @JsonKey(name: 'play_store') String? playStore,
    String? rdns,
    @JsonKey(name: 'chrome_store') String? chromeStore,
    List<Injected>? injected,
    List<String>? chains,
    List<String>? categories,
    String? description,
    @JsonKey(name: 'badge_type') String? badgeType,
    @JsonKey(name: 'supports_wc') bool? supportsWc,
    @JsonKey(name: 'is_top_wallet') bool? isTopWallet,
  }) = _AppKitModalWalletListing;

  factory AppKitModalWalletListing.fromJson(Map<String, dynamic> json) =>
      _$AppKitModalWalletListingFromJson(json);
}

@freezed
sealed class Injected with _$Injected {
  const factory Injected({
    required String namespace,
    @JsonKey(name: 'injected_id') required String injectedId,
  }) = _Injected;

  factory Injected.fromJson(Map<String, dynamic> json) =>
      _$InjectedFromJson(json);
}

extension ReownAppKitWalletInfoExtension on ReownAppKitModalWalletInfo {
  bool get isCoinbase =>
      listing.id ==
      'fd20dc426fb37566d803205b19bbc1d4096b248ac04548e3cfb6b3a38bd033aa';
  bool get isPhantom =>
      listing.id ==
      'a797aa35c0fadbfc1a53e7f675162ed5226968b44a19ee3d24385c64d1d3c393';
  bool get isSolflare =>
      listing.id ==
      '1ca0bdd4747578705b1939af023d120677c64fe6ca76add81fda36e350605e79';
}
