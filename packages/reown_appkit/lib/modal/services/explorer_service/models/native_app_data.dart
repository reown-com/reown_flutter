import 'dart:convert';

class NativeAppData {
  final String id;
  final String? schema;

  NativeAppData({required this.id, this.schema});

  NativeAppData copyWith({String? id, String? schema}) => NativeAppData(
        id: id ?? this.id,
        schema: schema ?? this.schema,
      );

  factory NativeAppData.fromRawJson(String str) =>
      NativeAppData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory NativeAppData.fromJson(Object? json) {
    final j = json as Map<String, dynamic>? ?? {};
    return NativeAppData(
      id: j['id'],
      schema: (j['ios_schema'] ?? j['android_app_id'])?.toString().trim() ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'schema': schema,
      };
}
