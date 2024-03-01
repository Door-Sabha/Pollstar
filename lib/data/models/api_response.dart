class ApiResponse {
  int? state;
  String? message;
  String? code;
  String? session;
  String? id;
  String? stateId;
  String? phone;
  String? description;

  ApiResponse(
      {this.state,
      this.message,
      this.code,
      this.session,
      this.id,
      this.stateId,
      this.phone,
      this.description});

  ApiResponse.fromJson(Map<String, dynamic> json) {
    state = json['state'];
    message = json['message'];
    code = json['code'];
    session = json['session'];
    id = json['id'];
    stateId = json['state_id'];
    phone = json['phone'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['state'] = state;
    data['message'] = message;
    data['code'] = code;
    data['session'] = session;
    data['id'] = id;
    data['state_id'] = stateId;
    data['phone'] = phone;
    data['description'] = description;
    return data;
  }
}
