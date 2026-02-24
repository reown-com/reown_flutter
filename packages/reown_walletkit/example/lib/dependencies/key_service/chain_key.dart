import 'dart:convert';

class ChainKey {
  final List<String> chains;
  final String privateKey;
  final String publicKey;
  final String address;
  final String?
      addressRaw; // Canonical raw format for comparison (e.g., TON raw address)
  final String namespace;

  ChainKey({
    required this.chains,
    required this.privateKey,
    required this.publicKey,
    required this.address,
    this.addressRaw,
    required this.namespace,
  });

  Map<String, dynamic> toJson() => {
        'chains': chains,
        'privateKey': privateKey,
        'publicKey': publicKey,
        'address': address,
        if (addressRaw != null) 'addressRaw': addressRaw,
        'namespace': namespace,
      };

  factory ChainKey.fromJson(Map<String, dynamic> json) {
    return ChainKey(
      chains: (json['chains'] as List).map((e) => '$e').toList(),
      privateKey: json['privateKey'],
      publicKey: json['publicKey'],
      address: json['address'],
      addressRaw: json['addressRaw'] as String?,
      namespace: json['namespace'],
    );
  }

  @override
  String toString() => jsonEncode(toJson());
}
