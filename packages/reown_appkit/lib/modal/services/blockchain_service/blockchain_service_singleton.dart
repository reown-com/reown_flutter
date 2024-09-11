import 'package:reown_appkit/modal/services/blockchain_service/i_blockchain_service.dart';

class BlockChainServiceSingleton {
  late IBlockChainService instance;
}

final blockchainService = BlockChainServiceSingleton();
