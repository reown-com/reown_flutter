import 'package:reown_appkit/modal/services/transfers/models/quote_params.dart';
import 'package:reown_appkit/modal/services/transfers/models/quote_results.dart';

abstract class ITransfersService {
  Future<GetQuoteStatusResult> getQuoteStatus({
    required GetQuoteStatusParams params,
  });
  Future<GetQuoteResult> getQuote({required GetQuoteParams params});
  Future<GetExchangeAssetsResult> getExchangeAssets({required String exchange});
}
