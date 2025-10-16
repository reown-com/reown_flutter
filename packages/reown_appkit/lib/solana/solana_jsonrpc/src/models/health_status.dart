/// Health Statuses
/// ------------------------------------------------------------------------------------------------
library;

/// The result of a GET /health endpoint call that provides a health-check mechanism for use by load
/// balancers or other network infrastructure. This request will always return a HTTP 200 OK
/// response with a body of "ok", "behind" or "unknown" based on the following conditions:
///
/// 1. If one or more --known-validator arguments are provided to solana-validator - "ok" is
/// returned when the node has within HEALTH_CHECK_SLOT_DISTANCE slots of the highest known
/// validator, otherwise "behind". "unknown" is returned when no slot information from known
/// validators is not yet available.
/// 2. "ok" is always returned if no known validators are provided.
enum HealthStatus {
  /// The node has within HEALTH_CHECK_SLOT_DISTANCE slots of the highest known validator.
  ok,

  /// The node does not has within HEALTH_CHECK_SLOT_DISTANCE slots of the highest known validator.
  behind,

  /// No slot information from known validators is currently available.
  unknown;

  /// {@macro solana_common.Serializable.fromJson}
  factory HealthStatus.fromJson(final String json) => values.byName(json);

  /// {@macro solana_common.Serializable.tryFromJson}
  static HealthStatus? tryFromJson(final String? json) =>
      json != null ? HealthStatus.fromJson(json) : null;
}
