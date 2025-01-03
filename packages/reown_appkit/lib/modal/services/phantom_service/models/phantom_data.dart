import 'package:reown_appkit/reown_appkit.dart';

class PhantomData {
  String address;
  String chainName;
  int chainId;
  ConnectionMetadata? self;
  ConnectionMetadata? peer;

  PhantomData({
    required this.address,
    required this.chainName,
    required this.chainId,
    this.self,
    this.peer,
  });

  factory PhantomData.fromJson(Map<String, dynamic> json) {
    return PhantomData(
      address: json['address'].toString(),
      chainName: json['chain'].toString(),
      chainId: int.parse(json['networkId'].toString()),
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
      'address': address,
      'chain': chainName,
      'networkId': chainId,
      'self': self?.toJson(),
      'peer': peer?.toJson(),
    };
  }

  @override
  String toString() => toJson().toString();

  PhantomData copytWith({
    String? address,
    String? chainName,
    int? chainId,
    ConnectionMetadata? self,
    ConnectionMetadata? peer,
  }) {
    return PhantomData(
      address: address ?? this.address,
      chainName: chainName ?? this.chainName,
      chainId: chainId ?? this.chainId,
      self: self ?? this.self,
      peer: peer ?? this.peer,
    );
  }
}
