import 'package:reown_appkit/modal/services/coinbase_service/i_coinbase_service.dart';

class CoinbaseServiceSingleton {
  late ICoinbaseService instance;
}

final coinbaseService = CoinbaseServiceSingleton();
