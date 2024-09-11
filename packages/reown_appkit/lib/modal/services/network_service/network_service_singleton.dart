import 'package:reown_appkit/modal/services/network_service/i_network_service.dart';
import 'package:reown_appkit/modal/services/network_service/network_service.dart';

class NetworkServiceSingleton {
  INetworkService instance;

  NetworkServiceSingleton() : instance = NetworkService();
}

final networkService = NetworkServiceSingleton();
