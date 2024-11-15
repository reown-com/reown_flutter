import 'dart:convert';

class SendData {
  final String? amount;
  final String? address;

  SendData({
    this.amount,
    this.address,
  });

  SendData copyWith({
    String? amount,
    String? address,
  }) =>
      SendData(
        amount: amount ?? this.amount,
        address: address ?? this.address,
      );

  factory SendData.fromRawJson(String str) =>
      SendData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SendData.fromJson(Map<String, dynamic> json) => SendData(
        amount: json['amount'],
        address: json['address'],
      );

  Map<String, dynamic> toJson() => {
        'amount': amount,
        'address': address,
      };
}
