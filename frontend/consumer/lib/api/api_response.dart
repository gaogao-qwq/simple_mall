class ApiResponse {
  bool success = false;
  int code = 0;
  String message = "";
  int timestamp = 0;
  dynamic data;

  ApiResponse(this.success, this.code, this.message, this.timestamp, this.data);

  factory ApiResponse.fromJson(Map<String, dynamic> json) => ApiResponse(
    json["success"] as bool,
    json["code"] as int,
    json["message"] as String,
    json["timestamp"] as int,
    json["data"] as dynamic,
  );
}