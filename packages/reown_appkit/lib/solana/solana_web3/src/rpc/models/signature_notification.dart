/// Imports
/// ------------------------------------------------------------------------------------------------
library;

import 'package:reown_appkit/solana/solana_common/models.dart';

/// Signature Notification
/// ------------------------------------------------------------------------------------------------

class SignatureNotification extends Serializable {
  /// Signature notification.
  const SignatureNotification({required this.err});

  /// The error if transaction failed, null if transaction succeeded.
  ///
  /// TODO: check error definitions.
  final dynamic err;

  /// {@macro solana_common.Serializable.fromJson}
  static SignatureNotification fromJson(final Map<String, dynamic> json) =>
      SignatureNotification(err: json['err']);

  /// {@macro solana_common.Serializable.tryFromJson}
  static SignatureNotification? tryFromJson(final Map<String, dynamic>? json) {
    return json != null ? SignatureNotification.fromJson(json) : null;
  }

  @override
  Map<String, dynamic> toJson() => {'err': err};
}
