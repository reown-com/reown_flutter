import 'package:reown_appkit/modal/models/public/appkit_wallet_info.dart';
import 'package:reown_appkit/modal/services/explorer_service/models/native_app_data.dart';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'api_response.freezed.dart';
part 'api_response.g.dart';

@freezed
sealed class GetWalletsResponse with _$GetWalletsResponse {
  const factory GetWalletsResponse({
    required int count,
    required int? nextPage,
    required int? previousPage,
    required List<AppKitModalWalletListing> data,
  }) = _GetWalletsResponse;

  factory GetWalletsResponse.fromJson(Map<String, dynamic> json) =>
      _$GetWalletsResponseFromJson(json);
}

@freezed
sealed class NativeDataResponse with _$NativeDataResponse {
  const factory NativeDataResponse({
    required int count,
    required List<NativeAppData> data,
  }) = _NativeDataResponse;

  factory NativeDataResponse.fromJson(Map<String, dynamic> json) =>
      _$NativeDataResponseFromJson(json);
}
