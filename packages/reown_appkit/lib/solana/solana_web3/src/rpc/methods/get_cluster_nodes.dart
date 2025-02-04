/// Imports
/// ------------------------------------------------------------------------------------------------
library;

import '../interfaces/json_rpc_list_method.dart';
import '../models/cluster_node.dart';

/// Get Cluster Nodes
/// ------------------------------------------------------------------------------------------------

/// A codec for `getClusterNodes` JSON RPC methods.
class GetClusterNodes
    extends JsonRpcListMethod<Map<String, dynamic>, ClusterNode> {
  /// Creates a codec for `getClusterNodes` JSON RPC methods.
  GetClusterNodes() : super('getClusterNodes');

  @override
  ClusterNode itemDecoder(final Map<String, dynamic> item) =>
      ClusterNode.fromJson(item);
}
