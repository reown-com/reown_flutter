import 'dart:convert';

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

  @override
  String toString() => json.encode(toJson());
}

class Quantity {
  final String? decimals;
  final String? numeric;

  Quantity({
    this.decimals,
    this.numeric,
  });

  factory Quantity.fromRawJson(String str) =>
      Quantity.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Quantity.fromJson(Map<String, dynamic> json) => Quantity(
        decimals: json['decimals'],
        numeric: json['numeric'],
      );

  Map<String, dynamic> toJson() => {
        'decimals': decimals,
        'numeric': numeric,
      };
}
