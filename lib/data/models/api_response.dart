class ApiResponse {
  int? state;
  String? message;
  String? code;
  String? session;

  ApiResponse({this.state, this.message, this.code, this.session});

  ApiResponse.fromJson(Map<String, dynamic> json) {
    state = json['state'];
    message = json['message'];
    code = json['code'];
    session = json['session'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['state'] = state;
    data['message'] = message;
    data['code'] = code;
    data['session'] = session;
    return data;
  }
}
