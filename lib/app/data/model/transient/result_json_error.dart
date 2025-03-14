class ResultJsonError {
  String? status;
  String? error;
  String? message;
  String? trace;
  String? type;

  ResultJsonError({this.status, this.error, this.message, this.trace, this.type});

  ResultJsonError.fromJson(Map<String, dynamic> jsonData) {
    status = jsonData['status'];
    error = jsonData['error'];
    message = jsonData['message'];
    trace = jsonData['trace'];
  }

  Map<String, dynamic> get toJson {
    Map<String, dynamic> jsonData = <String, dynamic>{};
    jsonData['status'] = status;
    jsonData['error'] = error;
    jsonData['message'] = message;
    jsonData['trace'] = trace;
    return jsonData;
  }
}