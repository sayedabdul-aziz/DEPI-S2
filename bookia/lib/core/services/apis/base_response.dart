class BaseResponse {
  final String? message;
  final bool? status;
  final dynamic data;
  final dynamic error;
  BaseResponse({this.message, this.status, this.data, this.error});

  factory BaseResponse.fromJson(Map<String, dynamic> json) {
    return BaseResponse(
      message: json['message'],
      status: json['status'],
      data: json['data'],
      error: json['error'],
    );
  }

  Map<String, dynamic> toJson() => {
    'message': message,
    'status': status,
    'data': data,
    'error': error,
  };
}
