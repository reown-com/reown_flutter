import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:reown_appkit/modal/constants/string_constants.dart';
import 'package:reown_appkit/modal/services/transfers/i_transfers_service.dart';
import 'package:reown_appkit/modal/services/transfers/models/quote_params.dart';
import 'package:reown_appkit/modal/services/transfers/models/quote_models.dart';
import 'package:reown_appkit/modal/services/transfers/models/quote_results.dart';
import 'package:reown_appkit/modal/services/transfers/utils/transfers_utils.dart';
import 'package:reown_appkit/reown_appkit.dart';

class TransfersService implements ITransfersService {
  late final IReownCore core;
  late final String _baseUrl;

  TransfersService({required this.core})
    : _baseUrl = '${UrlConstants.apiService}/appkit/v1/transfers';

  Map<String, String?> get _requiredParams => {'projectId': core.projectId};

  Map<String, String> get _requiredHeaders => {
    'x-sdk-type': CoreConstants.X_SDK_TYPE,
    'x-sdk-version': CoreConstants.X_SDK_VERSION,
    'Content-Type': 'application/json',
  };

  @override
  Future<GetQuoteResult> getQuote({required GetQuoteParams params}) async {
    core.logger.d(
      '[$runtimeType] getQuote request params: ${jsonEncode(params.toJson())}',
    );
    try {
      final isSameChain =
          params.sourceToken.network.toLowerCase() ==
          params.toToken.network.toLowerCase();

      final isSameAsset =
          params.sourceToken.address.toLowerCase() ==
          params.toToken.address.toLowerCase();

      if (isSameChain && isSameAsset) {
        return await _getDirectTransferQuote(params);
      }

      // Could be same chain but different asset
      // Or different chain and different asset
      return await _getTransfersQuote(params);
    } catch (e) {
      rethrow;
    }
  }

  static String? getIdFromCaip2Chain(String value) {
    if (NamespaceUtils.isValidChainId(value)) {
      return value.split(':').last;
    }
    return null;
  }

  Future<Quote> _getDirectTransferQuote(GetQuoteParams params) async {
    final chainId = params.toToken.network;
    final toChainId = getIdFromCaip2Chain(chainId);
    if (toChainId == null) {
      throw Exception('Invalid chainId ${params.toToken.network}');
    }

    final originalAmount = parseUnits(
      params.amount,
      params.sourceToken.metadata.decimals,
    );
    final destinationAmount = parseUnits(
      params.amount,
      params.toToken.metadata.decimals,
    );

    final quoteResult = Quote(
      type: QuoteType.directTransfer,
      origin: QuoteAmount(
        amount: originalAmount.toString(),
        currency: params.sourceToken,
      ),
      destination: QuoteAmount(
        amount: destinationAmount.toString(),
        currency: params.toToken,
      ),
      fees: [
        QuoteFee(
          id: 'service',
          label: 'Service Fee',
          amount: '0',
          currency: params.toToken,
        ),
      ],
      steps: [
        QuoteStep.deposit(
          requestId: 'direct-transfer',
          deposit: QuoteDeposit(
            amount: originalAmount.toString(),
            currency: params.sourceToken.address,
            receiver: params.recipient,
          ),
        ),
      ],
      timeInSeconds: 6,
    );
    core.logger.d(
      '[$runtimeType] -- quote response: ${jsonEncode(quoteResult.toJson())}',
    );
    return Future.value(quoteResult);
  }

  Future<GetQuoteResult> _getTransfersQuote(GetQuoteParams params) async {
    final amount = scaleAmountToBaseUnits(
      params.amount,
      params.toToken.metadata.decimals,
    );

    final fromChainId = params.sourceToken.network;
    final originId = getIdFromCaip2Chain(fromChainId);
    if (originId == null) {
      throw ArgumentError('Invalid source chainId $fromChainId');
    }

    final toChainId = params.toToken.network;
    final destinationId = getIdFromCaip2Chain(toChainId);
    if (destinationId == null) {
      throw ArgumentError('Invalid destination chainId $toChainId');
    }

    try {
      final address = params.address;
      final originCurrency = (params.sourceToken.isNative())
          ? params.sourceToken.getNativeAddress()
          : params.sourceToken.address;

      final destinationCurrency = (params.toToken.isNative())
          ? params.toToken.getNativeAddress()
          : params.toToken.address;

      final url = Uri.parse('$_baseUrl/quote');
      final body = jsonEncode(
        GetTransfersQuoteParams(
          // null for exchange deposit, wallet address when top up from own wallet
          user: address,
          // token selected chain
          originChainId: originId,
          // token selected address
          originCurrency: originCurrency,
          // kast's configured chainId to receive funds
          destinationChainId: destinationId,
          // kast's configured token to receive funds
          destinationCurrency: destinationCurrency,
          // kast's configured recipient
          recipient: params.recipient,
          amount: amount,
        ).toJson(),
      );
      core.logger.d('[$runtimeType] -- quote body: $body');
      final response = await http
          .post(
            url.replace(queryParameters: _requiredParams),
            headers: _requiredHeaders,
            body: body,
          )
          .timeout(Duration(seconds: 30));
      final responseBody = response.body;
      core.logger.d('[$runtimeType] -- quote response: $responseBody');

      final responseData = jsonDecode(responseBody) as Map<String, dynamic>;
      if (responseData.containsKey('error')) {
        throw StateError(responseData['error']);
      }

      return GetQuoteResult.fromJson(responseData);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<GetQuoteStatusResult> getQuoteStatus({
    required GetQuoteStatusParams params,
  }) async {
    final qParams = params.toJson();
    core.logger.d('[$runtimeType] getQuoteStatus bodyParams: $qParams');

    final url = Uri.parse(
      '$_baseUrl/status',
    ).replace(queryParameters: {...qParams, ..._requiredParams});
    final response = await http.get(url, headers: _requiredHeaders);
    final responseBody = response.body;
    core.logger.d('[$runtimeType] -- status response: $responseBody');

    final responseData = jsonDecode(responseBody) as Map<String, dynamic>;
    if (responseData.containsKey('error')) {
      throw StateError(responseData['error']);
    }

    return GetQuoteStatusResult.fromJson(responseData);
  }

  @override
  Future<GetExchangeAssetsResult> getExchangeAssets({
    required String exchange,
  }) async {
    final url = Uri.parse(
      '$_baseUrl/assets/exchanges/$exchange',
    ).replace(queryParameters: _requiredParams);
    core.logger.d('[$runtimeType] getExchangeAssets request: $url');
    final response = await http.get(url, headers: _requiredHeaders);
    final responseBody = response.body;
    core.logger.d('[$runtimeType] -- assets response: $responseBody');

    final responseData = jsonDecode(responseBody) as Map<String, dynamic>;
    return GetExchangeAssetsResult.fromJson(responseData);
  }
}
