import 'dart:convert';

// import 'package:reown_appkit/reown_appkit.dart';

class TokenBalance {
  final String? name;
  final String? symbol;
  final String? chainId;
  final String? address;
  final double? value;
  final double? price;
  final Quantity? quantity;
  final String? iconUrl;

  TokenBalance({
    this.name,
    this.symbol,
    this.chainId,
    this.address,
    this.value,
    this.price,
    this.quantity,
    this.iconUrl,
  });

  // bool get isNative {
  //   final ns = NamespaceUtils.getNamespaceFromChain(chainId!);
  //   if (ns == 'eip155') {
  //     return address == null;
  //   }
  //   if (ns == 'solana') {
  //     return address == 'So11111111111111111111111111111111111111111';
  //   }
  //   return true;
  // }

  factory TokenBalance.fromRawJson(String str) =>
      TokenBalance.fromJson(json.decode(str));

  factory TokenBalance.fromJson(Map<String, dynamic> json) => TokenBalance(
    name: json['name'],
    symbol: json['symbol'],
    chainId: json['chainId'],
    address: json['address'],
    value: json['value']?.toDouble(),
    price: json['price']?.toDouble(),
    quantity: json['quantity'] == null
        ? null
        : Quantity.fromJson(json['quantity']),
    iconUrl: json['iconUrl'],
  );

  Map<String, dynamic> toJson() => {
    'name': name,
    'symbol': symbol,
    'chainId': chainId,
    'address': address,
    'value': value,
    'price': price,
    'quantity': quantity?.toJson(),
    'iconUrl': iconUrl,
  };

  TokenBalance copyWith({
    String? name,
    String? symbol,
    String? chainId,
    String? address,
    double? value,
    double? price,
    Quantity? quantity,
    String? iconUrl,
  }) {
    return TokenBalance(
      name: name ?? this.name,
      symbol: symbol ?? this.symbol,
      chainId: chainId ?? this.chainId,
      address: address ?? this.address,
      value: value ?? this.value,
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
      iconUrl: iconUrl ?? this.iconUrl,
    );
  }

  @override
  String toString() => json.encode(toJson());
}

class Quantity {
  final String? decimals;
  final String? numeric;

  Quantity({this.decimals, this.numeric});

  factory Quantity.fromRawJson(String str) =>
      Quantity.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Quantity.fromJson(Map<String, dynamic> json) =>
      Quantity(decimals: json['decimals'], numeric: json['numeric']);

  Map<String, dynamic> toJson() => {'decimals': decimals, 'numeric': numeric};
}
