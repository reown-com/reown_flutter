import 'dart:convert';

class ChainKey {
  final List<String> chains;
  final String privateKey;
  final String publicKey;
  final String address;
  final String namespace;

  ChainKey({
    required this.chains,
    required this.privateKey,
    required this.publicKey,
    required this.address,
    required this.namespace,
  });

  Map<String, dynamic> toJson() => {
        'chains': chains,
        'privateKey': privateKey,
        'publicKey': privateKey,
        'address': address,
        'namespace': namespace,
      };

  factory ChainKey.fromJson(Map<String, dynamic> json) {
    return ChainKey(
      chains: (json['chains'] as List).map((e) => '$e').toList(),
      privateKey: json['privateKey'],
      publicKey: json['publicKey'],
      address: json['address'],
      namespace: json['namespace'],
    );
  }

  @override
  String toString() => jsonEncode(toJson());
}
