import 'package:reown_appkit/reown_appkit.dart';

class PhantomData {
  String sessionToken; // TODO this shouldn't be here, it should be secured
  String address;
  String chainId;
  ConnectionMetadata? self;
  ConnectionMetadata? peer;

  PhantomData({
    required this.sessionToken,
    required this.address,
    required this.chainId,
    this.self,
    this.peer,
  });

  factory PhantomData.fromJson(Map<String, dynamic> json) {
    return PhantomData(
      sessionToken: json['session'].toString(),
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
      'session': sessionToken,
      'public_key': address,
      'chain_id': chainId,
      'self': self?.toJson(),
      'peer': peer?.toJson(),
    };
  }

  @override
  String toString() => toJson().toString();

  PhantomData copytWith({
    String? sessionToken,
    String? address,
    String? chainId,
    ConnectionMetadata? self,
    ConnectionMetadata? peer,
  }) {
    return PhantomData(
      sessionToken: sessionToken ?? this.sessionToken,
      address: address ?? this.address,
      chainId: chainId ?? this.chainId,
      self: self ?? this.self,
      peer: peer ?? this.peer,
    );
  }
}
