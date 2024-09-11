import 'package:reown_appkit/reown_appkit.dart';

class MagicData {
  String email;
  String address;
  int chainId;
  ConnectionMetadata? self;
  ConnectionMetadata? peer;

  MagicData({
    required this.email,
    required this.chainId,
    required this.address,
    this.self,
    this.peer,
  });

  factory MagicData.fromJson(Map<String, dynamic> json) {
    return MagicData(
      email: json['email'].toString(),
      address: json['address'].toString(),
      chainId: int.parse(json['chainId'].toString()),
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
      'email': email,
      'address': address,
      'chainId': chainId,
      'self': self?.toJson(),
      'peer': peer?.toJson(),
    };
  }

  @override
  String toString() => toJson().toString();

  MagicData copytWith({
    String? email,
    String? address,
    int? chainId,
    ConnectionMetadata? self,
    ConnectionMetadata? peer,
  }) {
    return MagicData(
      email: email ?? this.email,
      address: address ?? this.address,
      chainId: chainId ?? this.chainId,
      self: self ?? this.self,
      peer: peer ?? this.peer,
    );
  }
}
