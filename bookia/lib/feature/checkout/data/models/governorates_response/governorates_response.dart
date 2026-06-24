import 'governorate.dart';

class GovernoratesResponse {
  List<Governorate>? data;
  String? message;
  List<dynamic>? error;
  int? status;

  GovernoratesResponse({this.data, this.message, this.error, this.status});

  factory GovernoratesResponse.fromJson(Map<String, dynamic> json) {
    return GovernoratesResponse(
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => Governorate.fromJson(e as Map<String, dynamic>))
          .toList(),
      message: json['message'] as String?,
      error: json['error'] as List<dynamic>?,
      status: json['status'] as int?,
    );
  }

  Map<String, dynamic> toJson() => {
    'data': data?.map((e) => e.toJson()).toList(),
    'message': message,
    'error': error,
    'status': status,
  };
}
