import 'package:reown_appkit/reown_appkit.dart';

class MagicData {
  String? email;
  String address;
  String chainId;
  String? farcasterUserName;
  bool? smartAccountDeployed;
  String? preferredAccountType;
  ConnectionMetadata? self;
  ConnectionMetadata? peer;
  AppKitSocialOption? provider;

  MagicData({
    required this.email,
    required this.chainId,
    required this.address,
    this.farcasterUserName,
    this.smartAccountDeployed,
    this.preferredAccountType,
    this.self,
    this.peer,
    this.provider,
  });

  factory MagicData.fromJson(Map<String, dynamic> json) {
    return MagicData(
      email: json['email']?.toString(),
      address: json['address'].toString(),
      chainId: _parseChainId(json['chainId'].toString()),
      farcasterUserName: json['userName']?.toString(),
      smartAccountDeployed: json['smartAccountDeployed'] as bool?,
      preferredAccountType: json['preferredAccountType']?.toString(),
      self: (json['self'] != null)
          ? ConnectionMetadata.fromJson(json['self'])
          : null,
      peer: (json['peer'] != null)
          ? ConnectionMetadata.fromJson(json['peer'])
          : null,
      provider: (json['provider'] != null)
          ? AppKitSocialOption.fromString(json['provider'].toString())
          : null,
    );
  }

  static String _parseChainId(String value) {
    if (!NamespaceUtils.isValidChainId(value)) {
      // we know that the secure-site can respond with invalid chain ids only for EVM
      return 'eip155:$value';
    }
    return value;
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'address': address,
      'chainId': chainId,
      'userName': farcasterUserName,
      'smartAccountDeployed': smartAccountDeployed,
      'preferredAccountType': preferredAccountType,
      'self': self?.toJson(),
      'peer': peer?.toJson(),
      'provider': provider?.name,
    };
  }

  @override
  String toString() => toJson().toString();

  MagicData copytWith({
    String? email,
    String? address,
    String? chainId,
    String? farcasterUserName,
    bool? smartAccountDeployed,
    String? preferredAccountType,
    ConnectionMetadata? self,
    ConnectionMetadata? peer,
    AppKitSocialOption? provider,
  }) {
    if (chainId != null) {
      chainId = _parseChainId(chainId);
    }
    return MagicData(
      email: email ?? this.email,
      address: address ?? this.address,
      chainId: chainId ?? this.chainId,
      farcasterUserName: farcasterUserName ?? this.farcasterUserName,
      smartAccountDeployed: smartAccountDeployed ?? this.smartAccountDeployed,
      preferredAccountType: preferredAccountType ?? this.preferredAccountType,
      self: self ?? this.self,
      peer: peer ?? this.peer,
      provider: provider ?? this.provider,
    );
  }
}
