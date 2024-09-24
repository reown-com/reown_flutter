import 'package:collection/collection.dart';
import 'package:reown_appkit/reown_appkit.dart';

class MagicData {
  String email;
  String address;
  int chainId;
  ConnectionMetadata? self;
  ConnectionMetadata? peer;
  AppKitSocialOption? provider;

  MagicData({
    required this.email,
    required this.chainId,
    required this.address,
    this.self,
    this.peer,
    this.provider,
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
      provider: (json['provider'] != null)
          ? AppKitSocialOption.values.firstWhereOrNull((e) =>
              e.name.toLowerCase() == json['provider'].toString().toLowerCase())
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
      'provider': provider?.name.toLowerCase(),
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
    AppKitSocialOption? provider,
  }) {
    return MagicData(
      email: email ?? this.email,
      address: address ?? this.address,
      chainId: chainId ?? this.chainId,
      self: self ?? this.self,
      peer: peer ?? this.peer,
      provider: provider ?? this.provider,
    );
  }
}
