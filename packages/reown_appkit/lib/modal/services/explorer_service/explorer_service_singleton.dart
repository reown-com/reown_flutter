import 'package:reown_appkit/modal/services/explorer_service/i_explorer_service.dart';

class ExplorerServiceSingleton {
  late IExplorerService instance;
}

final explorerService = ExplorerServiceSingleton();
