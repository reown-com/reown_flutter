import 'package:reown_appkit/modal/services/network_service/i_network_service.dart';

class NetworkServiceSingleton {
  late INetworkService instance;
}

final networkService = NetworkServiceSingleton();
