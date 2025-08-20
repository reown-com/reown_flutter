import 'package:reown_appkit/reown_appkit.dart';

class SolflareData {
  String address;
  String chainId;
  ConnectionMetadata? self;
  ConnectionMetadata? peer;

  SolflareData({
    required this.address,
    required this.chainId,
    this.self,
    this.peer,
  });

  factory SolflareData.fromJson(Map<String, dynamic> json) {
    return SolflareData(
      address: json['public_key'].toString(),
      chainId: json['chain_id'].toString(),
      self: (json['self'] != null)
          ? ConnectionMetadata.fromJson(json['self'])
          : null,
      peer: (json['peer'] != null)
          ? ConnectionMetadata.fromJson(json['peer'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'public_key': address,
      'chain_id': chainId,
      'self': self?.toJson(),
      'peer': peer?.toJson(),
    };
  }

  @override
  String toString() => toJson().toString();

  SolflareData copyWith({
    String? address,
    String? chainId,
    ConnectionMetadata? self,
    ConnectionMetadata? peer,
  }) {
    return SolflareData(
      address: address ?? this.address,
      chainId: chainId ?? this.chainId,
      self: self ?? this.self,
      peer: peer ?? this.peer,
    );
  }
}
