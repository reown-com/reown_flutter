/// Transaction Serializable
/// ------------------------------------------------------------------------------------------------
library;

/// A serializable transaction interface.
abstract class TransactionSerializable with TransactionSerializableMixin {
  /// Creates a serializable transaction object.
  const TransactionSerializable();
}

/// Transaction Serializable Mixin
/// ------------------------------------------------------------------------------------------------

/// A serializable transaction interface mixin.
mixin TransactionSerializableMixin {
  /// Serialises a transaction into a buffer.
  Iterable<int> serialize([final TransactionSerializableConfig? config]);

  /// Serialises a transaction message into a buffer.
  Iterable<int> serializeMessage();
}

/// Transaction Serializable Config
/// ------------------------------------------------------------------------------------------------

class TransactionSerializableConfig {
  /// Creates a configuration object for [TransactionSerializableMixin.serialize].
  const TransactionSerializableConfig({
    this.requireAllSignatures = true,
    this.verifySignatures = true,
  });

  /// Require all transaction signatures be present (default: true).
  final bool requireAllSignatures;

  /// Verify provided signatures (default: true).
  final bool verifySignatures;
}
