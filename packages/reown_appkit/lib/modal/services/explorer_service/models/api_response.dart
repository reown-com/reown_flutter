import 'package:reown_appkit/modal/models/public/appkit_wallet_info.dart';
import 'package:reown_appkit/modal/services/explorer_service/models/native_app_data.dart';

class ApiResponse<T> {
  final int count;
  final List<T> data;

  ApiResponse({required this.count, required this.data});

  ApiResponse<T> copyWith({int? count, List<T>? data}) => ApiResponse<T>(
        count: count ?? this.count,
        data: data ?? this.data,
      );

  factory ApiResponse.fromJson(
    final Map<String, dynamic> json,
    T Function(Object? json) fromJsonT,
  ) {
    return ApiResponse<T>(
      count: json['count'],
      data: (json['data'] as List<dynamic>).map(fromJsonT).toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'count': count,
        'data': List<T>.from(data.map(
          (x) {
            if (T is Listing) {
              return (x as Listing).toJson();
            } else if (T is NativeAppData) {
              return (x as NativeAppData).toJson();
            } else {
              throw Exception('Invalid Type');
            }
          },
        )),
      };
}
