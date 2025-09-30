// class ErrorResponse {
//   final String? status;
//   final int? statusCode;
//   final dynamic message;
//
//   ErrorResponse({
//     this.status,
//     this.statusCode,
//     this.message,
//   });
//
//   factory ErrorResponse.fromJson(Map<String, dynamic> json) => ErrorResponse(
//     status: json["status"],
//     statusCode: json["statusCode"],
//     message: json["message"],
//   );
// }



class ErrorResponse {
  final String? status;   // sometimes API gives this
  final String? error;    // sometimes API gives this instead
  final int? statusCode;
  final dynamic message;

  ErrorResponse({
    this.status,
    this.error,
    this.statusCode,
    this.message,
  });

  factory ErrorResponse.fromJson(Map<String, dynamic> json) => ErrorResponse(
    status: json["status"],
    error: json["error"],
    statusCode: json["statusCode"],
    message: json["message"],
  );
}
