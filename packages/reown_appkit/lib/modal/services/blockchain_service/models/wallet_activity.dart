import 'dart:convert';

class ActivityData {
  final List<Activity>? data;
  final String? next;

  ActivityData({
    this.data,
    this.next,
  });

  factory ActivityData.fromRawJson(String str) =>
      ActivityData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ActivityData.fromJson(Map<String, dynamic> json) => ActivityData(
        data: json['data'] == null
            ? []
            : List<Activity>.from(
                json['data']!.map((x) => Activity.fromJson(x))),
        next: json['next'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'data': data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
        'next': next,
      };
}

class Activity {
  final String? id;
  final Metadata? metadata;
  final List<Transfer>? transfers;

  Activity({
    this.id,
    this.metadata,
    this.transfers,
  });

  factory Activity.fromRawJson(String str) =>
      Activity.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Activity.fromJson(Map<String, dynamic> json) => Activity(
        id: json['id'],
        metadata: json['metadata'] == null
            ? null
            : Metadata.fromJson(json['metadata']),
        transfers: json['transfers'] == null
            ? []
            : List<Transfer>.from(
                json['transfers']!.map((x) => Transfer.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'metadata': metadata?.toJson(),
        'transfers': transfers == null
            ? []
            : List<dynamic>.from(transfers!.map((x) => x.toJson())),
      };
}

class Metadata {
  final String? operationType;
  final String? hash;
  final DateTime? minedAt;
  final String? sentFrom;
  final String? sentTo;
  final String? status;
  final int? nonce;
  final Application? application;
  final String? chain;

  Metadata({
    this.operationType,
    this.hash,
    this.minedAt,
    this.sentFrom,
    this.sentTo,
    this.status,
    this.nonce,
    this.application,
    this.chain,
  });

  factory Metadata.fromRawJson(String str) =>
      Metadata.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Metadata.fromJson(Map<String, dynamic> json) => Metadata(
        operationType: json['operationType'],
        hash: json['hash'],
        minedAt:
            json['minedAt'] == null ? null : DateTime.parse(json['minedAt']),
        sentFrom: json['sentFrom'],
        sentTo: json['sentTo'],
        status: json['status'],
        nonce: json['nonce'],
        application: json['application'] == null
            ? null
            : Application.fromJson(json['application']),
        chain: json['chain'],
      );

  Map<String, dynamic> toJson() => {
        'operationType': operationType,
        'hash': hash,
        'minedAt': minedAt?.toIso8601String(),
        'sentFrom': sentFrom,
        'sentTo': sentTo,
        'status': status,
        'nonce': nonce,
        'application': application?.toJson(),
        'chain': chain,
      };
}

class Application {
  final String? name;
  final String? iconUrl;

  Application({
    this.name,
    this.iconUrl,
  });

  factory Application.fromRawJson(String str) =>
      Application.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Application.fromJson(Map<String, dynamic> json) => Application(
        name: json['name'],
        iconUrl: json['iconUrl'],
      );

  Map<String, dynamic> toJson() => {
        'name': name,
        'iconUrl': iconUrl,
      };
}

class Transfer {
  final FungibleInfo? fungibleInfo;
  final NftInfo? nftInfo;
  final String? direction;
  final Quantity? quantity;
  final double? value;
  final double? price;

  Transfer({
    this.fungibleInfo,
    this.nftInfo,
    this.direction,
    this.quantity,
    this.value,
    this.price,
  });

  factory Transfer.fromRawJson(String str) =>
      Transfer.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Transfer.fromJson(Map<String, dynamic> json) => Transfer(
        fungibleInfo: json['fungible_info'] == null
            ? null
            : FungibleInfo.fromJson(json['fungible_info']),
        nftInfo: json['nft_info'] == null
            ? null
            : NftInfo.fromJson(json['nft_info']),
        direction: json['direction'],
        quantity: json['quantity'] == null
            ? null
            : Quantity.fromJson(json['quantity']),
        value: json['value']?.toDouble(),
        price: json['price']?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        'fungible_info': fungibleInfo?.toJson(),
        'nft_info': nftInfo?.toJson(),
        'direction': direction,
        'quantity': quantity?.toJson(),
        'value': value,
        'price': price,
      };
}

class FungibleInfo {
  final String? name;
  final String? symbol;
  final Icon? icon;

  FungibleInfo({
    this.name,
    this.symbol,
    this.icon,
  });

  factory FungibleInfo.fromRawJson(String str) =>
      FungibleInfo.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory FungibleInfo.fromJson(Map<String, dynamic> json) => FungibleInfo(
        name: json['name'],
        symbol: json['symbol'],
        icon: json['icon'] == null ? null : Icon.fromJson(json['icon']),
      );

  Map<String, dynamic> toJson() => {
        'name': name,
        'symbol': symbol,
        'icon': icon?.toJson(),
      };
}

class Icon {
  final String? url;

  Icon({
    this.url,
  });

  factory Icon.fromRawJson(String str) => Icon.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Icon.fromJson(Map<String, dynamic> json) => Icon(
        url: json['url'],
      );

  Map<String, dynamic> toJson() => {
        'url': url,
      };
}

class NftInfo {
  final String? name;
  final Content? content;
  final Flags? flags;

  NftInfo({
    this.name,
    this.content,
    this.flags,
  });

  factory NftInfo.fromRawJson(String str) => NftInfo.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory NftInfo.fromJson(Map<String, dynamic> json) => NftInfo(
        name: json['name'],
        content:
            json['content'] == null ? null : Content.fromJson(json['content']),
        flags: json['flags'] == null ? null : Flags.fromJson(json['flags']),
      );

  Map<String, dynamic> toJson() => {
        'name': name,
        'content': content?.toJson(),
        'flags': flags?.toJson(),
      };
}

class Content {
  final Detail? preview;
  final Detail? detail;

  Content({
    this.preview,
    this.detail,
  });

  factory Content.fromRawJson(String str) => Content.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Content.fromJson(Map<String, dynamic> json) => Content(
        preview:
            json['preview'] == null ? null : Detail.fromJson(json['preview']),
        detail: json['detail'] == null ? null : Detail.fromJson(json['detail']),
      );

  Map<String, dynamic> toJson() => {
        'preview': preview?.toJson(),
        'detail': detail?.toJson(),
      };
}

class Detail {
  final String? url;
  final dynamic contentType;

  Detail({
    this.url,
    this.contentType,
  });

  factory Detail.fromRawJson(String str) => Detail.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Detail.fromJson(Map<String, dynamic> json) => Detail(
        url: json['url'],
        contentType: json['content_type'],
      );

  Map<String, dynamic> toJson() => {
        'url': url,
        'content_type': contentType,
      };
}

class Flags {
  final bool? isSpam;

  Flags({
    this.isSpam,
  });

  factory Flags.fromRawJson(String str) => Flags.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Flags.fromJson(Map<String, dynamic> json) => Flags(
        isSpam: json['is_spam'],
      );

  Map<String, dynamic> toJson() => {
        'is_spam': isSpam,
      };
}

class Quantity {
  final String? numeric;

  Quantity({
    this.numeric,
  });

  factory Quantity.fromRawJson(String str) =>
      Quantity.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Quantity.fromJson(Map<String, dynamic> json) => Quantity(
        numeric: json['numeric'],
      );

  Map<String, dynamic> toJson() => {
        'numeric': numeric,
      };
}
