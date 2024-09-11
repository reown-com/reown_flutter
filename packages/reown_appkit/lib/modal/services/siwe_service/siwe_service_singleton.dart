import 'package:reown_appkit/modal/services/siwe_service/i_siwe_service.dart';

class SiweServiceSingleton {
  ISiweService? instance;
}

final siweService = SiweServiceSingleton();
