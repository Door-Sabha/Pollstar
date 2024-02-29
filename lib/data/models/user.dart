class User {
  int? state;
  String? id;
  String? stateId;
  StateInfo? stateInfo;
  UserParams? params;
  String? code;
  String? message;
  String? phone;

  User(
      {this.state,
      this.id,
      this.stateId,
      this.stateInfo,
      this.params,
      this.code,
      this.message,
      this.phone});

  User.fromJson(Map<String, dynamic> json) {
    state = json['state'];
    id = json['id'];
    stateId = json['state_id'];
    stateInfo = json['state_info'] != null
        ? StateInfo.fromJson(json['state_info'])
        : null;
    params =
        json['params'] != null ? UserParams.fromJson(json['params']) : null;
    code = json['code'];
    message = json['message'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['state'] = state;
    data['id'] = id;
    data['state_id'] = stateId;
    if (stateInfo != null) {
      data['state_info'] = stateInfo!.toJson();
    }
    if (params != null) {
      data['params'] = params!.toJson();
    }
    data['code'] = code;
    data['message'] = message;
    data['phone'] = phone;
    return data;
  }
}

class StateInfo {
  String? sId;
  String? name;
  String? code;
  String? emaId;
  int? active;
  String? tCreated;
  UpdatedTime? t;
  String? aGENT;
  String? iP;
  String? emergencyNumbers;
  String? headerImage;
  String? helpUrl;
  List<String>? problemReasons;

  StateInfo(
      {this.sId,
      this.name,
      this.code,
      this.emaId,
      this.active,
      this.tCreated,
      this.t,
      this.aGENT,
      this.iP,
      this.emergencyNumbers,
      this.headerImage,
      this.helpUrl,
      this.problemReasons});

  StateInfo.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    code = json['code'];
    emaId = json['ema_id'];
    active = json['active'];
    tCreated = json['t_created'];
    t = json['t'] != null ? UpdatedTime.fromJson(json['t']) : null;
    aGENT = json['AGENT'];
    iP = json['IP'];
    emergencyNumbers = json['emergency_numbers'];
    headerImage = json['header_image'];
    helpUrl = json['help_url'];
    problemReasons = json['problem_reasons'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['name'] = name;
    data['code'] = code;
    data['ema_id'] = emaId;
    data['active'] = active;
    data['t_created'] = tCreated;
    if (t != null) {
      data['t'] = t!.toJson();
    }
    data['AGENT'] = aGENT;
    data['IP'] = iP;
    data['emergency_numbers'] = emergencyNumbers;
    data['header_image'] = headerImage;
    data['help_url'] = helpUrl;
    data['problem_reasons'] = problemReasons;
    return data;
  }
}

class UpdatedTime {
  String? updated;
  String? mysqlPull;

  UpdatedTime({this.updated, this.mysqlPull});

  UpdatedTime.fromJson(Map<String, dynamic> json) {
    updated = json['updated'];
    mysqlPull = json['mysql_pull'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['updated'] = updated;
    data['mysql_pull'] = mysqlPull;
    return data;
  }
}

class UserParams {
  String? sId;
  int? boothid;
  String? boothRefno;
  String? boothName;
  String? phoneNumber;
  int? boothStatus;
  int? totalVotersCount;
  String? latitude;
  String? longitude;
  int? maleVotersCount;
  int? femaleVotersCount;
  int? updateId;
  String? updateTime;
  int? fetched;

  UserParams(
      {this.sId,
      this.boothid,
      this.boothRefno,
      this.boothName,
      this.phoneNumber,
      this.boothStatus,
      this.totalVotersCount,
      this.latitude,
      this.longitude,
      this.maleVotersCount,
      this.femaleVotersCount,
      this.updateId,
      this.updateTime,
      this.fetched});

  UserParams.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    boothid = json['boothid'];
    boothRefno = json['booth_refno'];
    boothName = json['booth_name'];
    phoneNumber = json['phone_number'];
    boothStatus = json['booth_status'];
    totalVotersCount = json['total_voters_count'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    maleVotersCount = json['male_voters_count'];
    femaleVotersCount = json['female_voters_count'];
    updateId = json['update_id'];
    updateTime = json['update_time'];
    fetched = json['fetched'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['boothid'] = boothid;
    data['booth_refno'] = boothRefno;
    data['booth_name'] = boothName;
    data['phone_number'] = phoneNumber;
    data['booth_status'] = boothStatus;
    data['total_voters_count'] = totalVotersCount;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['male_voters_count'] = maleVotersCount;
    data['female_voters_count'] = femaleVotersCount;
    data['update_id'] = updateId;
    data['update_time'] = updateTime;
    data['fetched'] = fetched;
    return data;
  }
}
