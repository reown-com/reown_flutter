/// Imports
/// ------------------------------------------------------------------------------------------------
library;

import 'package:json_annotation/json_annotation.dart' show JsonSerializable;
import 'package:reown_appkit/solana/solana_common/models.dart'
    show Serializable;

part 'cluster.g.dart';

/// Cluster
/// ------------------------------------------------------------------------------------------------

@JsonSerializable()
class Cluster extends Serializable {
  /// The RPC URL of a cluster.
  ///
  /// ```
  /// const String devhost = 'api.devnet.solana.com';
  /// final Cluster devCluster = Cluster.https(devhost);
  /// print(devCluster); // 'https://api.devnet.solana.com'
  ///
  /// const String localhost = '127.0.0.1';
  /// final Cluster localCluster = Cluster.http(localhost, port: 8899);
  /// print(localCluster); // 'http://127.0.0.1:8899'
  /// final Cluster wsLocalCluster = Cluster.ws(localhost, port: 8900);
  /// print(wsLocalCluster); // 'ws://127.0.0.1:8900'
  /// ```
  const Cluster(this.uri);

  /// The endpoint.
  final Uri uri;

  /// {@macro solana_common.Serializable.fromJson}
  factory Cluster.fromJson(final Map<String, dynamic> json) =>
      _$ClusterFromJson(json);

  /// The cluster's name parsed from the [Uri.host].
  ///
  /// ```
  /// final Cluster cluster1 = Cluster.mainnet;
  /// print(clutser1.name); // 'mainnet-beta'
  ///
  /// final Cluster cluster2 = Cluster.https('example.com');
  /// print(clutser2.name); // null
  /// ```
  String? get name =>
      RegExp(r'api.([^.]+).solana.com').firstMatch(uri.host)?.group(1);

  /// The cluster's chain id parsed from the [Uri.host].
  ///
  /// ```
  /// final Cluster cluster1 = Cluster.mainnet;
  /// print(clutser1.id); // 'mainnet'
  ///
  /// final Cluster cluster2 = Cluster.https('example.com');
  /// print(clutser2.id); // null
  /// ```
  String? get id =>
      RegExp(r'api.([a-zA-Z]+)[^.]*.solana.com').firstMatch(uri.host)?.group(1);

  /// The default `localhost` HTTP endpoint (`http://127.0.0.1:8899`).
  static Cluster get localhost => Cluster.http('127.0.0.1', port: 8899);

  /// The `devnet` cluster's HTTP endpoint.
  static Cluster get devnet => Cluster.https('api.devnet.solana.com');

  /// The `testnet` cluster's HTTP endpoint.
  static Cluster get testnet => Cluster.https('api.testnet.solana.com');

  /// The `mainnet` cluster's HTTP endpoint.
  static Cluster get mainnet => Cluster.https('api.mainnet-beta.solana.com');

  /// Creates a `HTTP` RPC URL for [host].
  factory Cluster.http(
    final String host, {
    final int? port,
  }) =>
      Cluster(Uri(scheme: 'http', host: host, port: port));

  /// Creates a `HTTPS` RPC URL for [host].
  factory Cluster.https(
    final String host, {
    final int? port,
  }) =>
      Cluster(Uri(scheme: 'https', host: host, port: port));

  /// Creates a `WS` RPC URL for [host].
  factory Cluster.ws(
    final String host, {
    final int? port,
  }) =>
      Cluster(Uri(scheme: 'ws', host: host, port: port));

  /// Creates a `WSS` RPC URL for [host].
  factory Cluster.wss(
    final String host, {
    final int? port,
  }) =>
      Cluster(Uri(scheme: 'wss', host: host, port: port));

  /// Creates a new [Cluster] from `this` for a websocket server.
  ///
  /// ```
  /// final Cluster devCluster = Cluster.devnet;              // 'https://api.devnet.solana.com'
  /// print(devCluster.toWebsocket());                        // 'wss://api.devnet.solana.com'
  ///
  /// final Cluster localCluster = Cluster.localhost;         // 'http://127.0.0.1:8899'
  /// final Cluster wsCluster = localCluster.toWebsocket();
  /// print(wsCluster);                                       // 'ws://127.0.0.1:8899'
  /// print(wsCluster.toWebsocket(8900));                     // 'ws://127.0.0.1:8900'
  /// ```
  Cluster toWebsocket([int? port]) {
    switch (uri.scheme) {
      case 'http':
        return Cluster(uri.replace(scheme: 'ws', port: port));
      case 'https':
        return Cluster(uri.replace(scheme: 'wss', port: port));
      default:
        assert(uri.scheme == 'ws' || uri.scheme == 'wss');
        return Cluster(uri.replace(port: port));
    }
  }

  @override
  String toString() => uri.toString();

  @override
  Map<String, dynamic> toJson() => _$ClusterToJson(this);
}
