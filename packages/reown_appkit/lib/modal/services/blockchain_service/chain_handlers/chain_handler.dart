/// Base interface for chain-specific handlers
abstract class ChainHandler {
  /// The RPC method name for getting balance
  String get balanceMethod;

  /// Builds the parameters for a balance request
  /// Can return either a List (for array params) or Map (for object params)
  dynamic buildBalanceParams(String address);

  /// Parses the balance result from RPC response
  double parseBalance(String balanceResult, T Function<T>(String) parseRpc);
}
