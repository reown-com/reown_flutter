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
  // String? _bundleId;
  // String? _clientId;

  TransfersService({required this.core})
    : _baseUrl = '${UrlConstants.apiService}/v1/transfers';

  // Map<String, String?> get _requiredParams => {
  //   'projectId': core.projectId,
  //   'clientId': _clientId,
  // };

  // Map<String, String> get _requiredHeaders => {
  //   'x-sdk-type': CoreConstants.X_SDK_TYPE,
  //   'x-sdk-version': CoreConstants.X_SDK_VERSION,
  //   'origin': _bundleId ?? CoreConstants.X_SDK_VERSION,
  // };

  @override
  Future<GetQuoteResult> getQuote({required GetQuoteParams params}) async {
    final isSameChain =
        params.sourceToken.network.toLowerCase() ==
        params.toToken.network.toLowerCase();

    if (isSameChain) {
      final isSameAsset =
          params.sourceToken.address.toLowerCase() ==
          params.toToken.address.toLowerCase();

      if (!isSameAsset) {
        throw Exception('Source and destination assets must be the same');
      }

      if (params.address == null) {
        throw Exception('Address is required');
      }

      // final sameParams = GetQuoteParams(
      //   address: params.address!,
      //   sourceToken: params.sourceToken,
      //   toToken: params.toToken,
      //   recipient: params.recipient,
      //   amount: params.amount,
      // );

      return await getSameChainQuote(params);
    }

    // final crossParams = GetQuoteParams(
    //   address: params.address,
    //   sourceToken: params.sourceToken,
    //   toToken: params.toToken,
    //   recipient: params.recipient,
    //   amount: params.amount,
    // );

    return await getCrossChainQuote(params);
  }

  Future<GetQuoteResult> getCrossChainQuote(GetQuoteParams params) async {
    final amount = scaleAmountToBaseUnits(
      params.amount,
      params.toToken.metadata.decimals,
    );

    final fromChainId = params.sourceToken.network;
    final originId = NamespaceUtils.getIdFromCaip2Chain(fromChainId);
    final originNamespace = NamespaceUtils.getNamespaceFromChain(fromChainId);
    if (originId == null) {
      throw Exception('Invalid source chainId $fromChainId');
    }

    final toChainId = params.toToken.network;
    final destinationId = NamespaceUtils.getIdFromCaip2Chain(toChainId);
    if (destinationId == null) {
      throw Exception('Invalid destination chainId $toChainId');
    }

    final address =
        params.address ?? DEAD_ADDRESSES_BY_NAMESPACE[originNamespace];

    final originCurrency = (params.sourceToken.isNative())
        ? params.sourceToken.getNativeAddress()
        : params.sourceToken.address;

    final destinationCurrency = (params.toToken.isNative())
        ? params.toToken.getNativeAddress()
        : params.toToken.address;

    final bodyParams = GetCrossChainQuoteParams(
      user: address!,
      originChainId: originId,
      originCurrency: originCurrency,
      destinationChainId: destinationId,
      destinationCurrency: destinationCurrency,
      recipient: params.recipient,
      amount: amount,
    );
    final url = Uri.parse('$_baseUrl/quote');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(bodyParams),
    );
    core.logger.d('[$runtimeType] getQuote response: ${response.body}');

    final responseData = jsonDecode(response.body) as Map<String, dynamic>;
    return GetQuoteResult.fromJson(responseData);
  }

  Future<Quote> getSameChainQuote(GetQuoteParams params) async {
    final chainId = params.toToken.network;
    final toChainId = NamespaceUtils.getIdFromCaip2Chain(chainId);
    if (toChainId == null) {
      throw Exception('Invalid chainId ${params.toToken.network}');
    }

    return Quote(
      type: QuoteType.sameChain,
      origin: QuoteCurrency(
        amount: params.amount,
        amountFormatted: params.amount,
        chainId: params.sourceToken.network,
        symbol: params.sourceToken.metadata.symbol,
      ),
      destination: QuoteCurrency(
        amount: params.amount,
        amountFormatted: params.amount,
        chainId: params.toToken.network,
        symbol: params.toToken.metadata.symbol,
      ),
      fees: [
        QuoteFee(
          id: 'service',
          label: 'Service Fee',
          amount: '0',
          amountFormatted: '0',
          chainId: toChainId.toString(),
          amountUsd: '0',
          currency: params.toToken,
        ),
      ],
      requestId: 'same-chain',
      depositAddress: params.recipient,
      timeEstimate: 1000,
    );
  }

  @override
  Future<GetQuoteStatusResult> getQuoteStatus({
    required GetQuoteStatusParams params,
  }) async {
    final qParams = params.toJson();
    core.logger.d('[$runtimeType] getQuoteStatus bodyParams: $qParams');

    final url = Uri.parse('$_baseUrl/status').replace(queryParameters: qParams);
    final response = await http.get(url);
    core.logger.d('[$runtimeType] getQuoteStatus response: ${response.body}');

    final responseData = jsonDecode(response.body) as Map<String, dynamic>;
    return GetQuoteStatusResult.fromJson(responseData);
  }
}
