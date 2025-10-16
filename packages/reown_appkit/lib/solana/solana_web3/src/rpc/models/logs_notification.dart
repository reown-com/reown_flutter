/// Imports
/// ------------------------------------------------------------------------------------------------
library;

import 'package:reown_appkit/solana/solana_common/models.dart';

/// Logs Notification
/// ------------------------------------------------------------------------------------------------

class LogsNotification extends Serializable {
  /// Logs notification.
  const LogsNotification({
    required this.signature,
    required this.err,
    required this.logs,
  });

  /// The transaction signature base-58 encoded.
  final String signature;

  /// The error if transaction failed, null if transaction succeeded.
  ///
  /// TODO: check error definitions.
  final dynamic err;

  /// An array of log messages the transaction instructions output during execution, null if
  /// simulation failed before the transaction was able to execute (for example due to an invalid
  /// blockhash or signature verification failure).
  final List? logs;

  /// {@macro solana_common.Serializable.fromJson}
  factory LogsNotification.fromJson(final Map<String, dynamic> json) =>
      LogsNotification(
        signature: json['signature'],
        err: json['err'],
        logs: json['logs'],
      );

  /// {@macro solana_common.Serializable.tryFromJson}
  static LogsNotification? tryFromJson(final Map<String, dynamic>? json) {
    return json != null ? LogsNotification.fromJson(json) : null;
  }

  @override
  Map<String, dynamic> toJson() => {
    'signature': signature,
    'err': err,
    'logs': logs,
  };
}
