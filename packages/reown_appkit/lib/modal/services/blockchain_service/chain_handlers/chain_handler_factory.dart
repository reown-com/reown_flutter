import 'chain_handler.dart';
import 'eip155_handler.dart';
import 'solana_handler.dart';
import 'tron_handler.dart';
import 'sui_handler.dart';
import 'stacks_handler.dart';
import 'ton_handler.dart';

/// Factory for creating chain-specific handlers
class ChainHandlerFactory {
  static final _handlers = <String, ChainHandler>{
    'eip155': Eip155Handler(),
    'solana': SolanaHandler(),
    'tron': TronHandler(),
    'sui': SuiHandler(),
    'stacks': StacksHandler(),
    'ton': TonHandler(),
  };

  /// Gets the appropriate handler for a given namespace
  static ChainHandler? getHandler(String namespace) {
    return _handlers[namespace];
  }

  /// Gets the handler or throws an exception if not found
  static ChainHandler getHandlerOrThrow(String namespace) {
    final handler = getHandler(namespace);
    if (handler == null) {
      throw UnsupportedError('Unsupported namespace: $namespace');
    }
    return handler;
  }
}
