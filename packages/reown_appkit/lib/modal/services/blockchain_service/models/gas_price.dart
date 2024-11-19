import 'dart:convert';

class GasPrice {
  final BigInt? standard;
  final BigInt? fast;
  final BigInt? instant;

  GasPrice({
    this.standard,
    this.fast,
    this.instant,
  });

  factory GasPrice.fromRawJson(String str) =>
      GasPrice.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GasPrice.fromJson(Map<String, dynamic> json) => GasPrice(
        standard: json['standard']?.toString().bigInt(),
        fast: json['fast']?.toString().bigInt(),
        instant: json['instant']?.toString().bigInt(),
      );

  Map<String, dynamic> toJson() => {
        'standard': standard,
        'fast': fast,
        'instant': instant,
      };
}

extension on String? {
  BigInt bigInt() {
    return BigInt.from(num.parse(this ?? '0'));
  }
}
