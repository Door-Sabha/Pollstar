class User {
  int? state;
  String? id;
  String? stateId;
  StateInfo? stateInfo;
  UserParams? userParams;
  String? message;

  User(
      {this.state,
      this.id,
      this.stateId,
      this.stateInfo,
      this.userParams,
      this.message});

  User.fromJson(Map<String, dynamic> json) {
    state = json['state'];
    id = json['id'];
    stateId = json['state_id'];
    stateInfo = json['state_info'] != null
        ? StateInfo.fromJson(json['state_info'])
        : null;
    userParams =
        json['params'] != null ? UserParams.fromJson(json['params']) : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['state'] = state;
    data['id'] = id;
    data['state_id'] = stateId;
    if (stateInfo != null) {
      data['state_info'] = stateInfo!.toJson();
    }
    if (userParams != null) {
      data['params'] = userParams!.toJson();
    }
    data['message'] = message;
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
  Db? db;
  T? t;
  Ema? ema;
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
      this.db,
      this.t,
      this.ema,
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
    db = json['db'] != null ? Db.fromJson(json['db']) : null;
    t = json['t'] != null ? T.fromJson(json['t']) : null;
    ema = json['ema'] != null ? Ema.fromJson(json['ema']) : null;
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
    if (db != null) {
      data['db'] = db!.toJson();
    }
    if (t != null) {
      data['t'] = t!.toJson();
    }
    if (ema != null) {
      data['ema'] = ema!.toJson();
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

class Db {
  String? hostname;
  String? database;
  String? questionUpdateTime;
  String? boothUpdateTime;
  String? username;
  String? password;

  Db(
      {this.hostname,
      this.database,
      this.questionUpdateTime,
      this.boothUpdateTime,
      this.username,
      this.password});

  Db.fromJson(Map<String, dynamic> json) {
    hostname = json['hostname'];
    database = json['database'];
    questionUpdateTime = json['question_update_time'];
    boothUpdateTime = json['booth_update_time'];
    username = json['username'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['hostname'] = hostname;
    data['database'] = database;
    data['question_update_time'] = questionUpdateTime;
    data['booth_update_time'] = boothUpdateTime;
    data['username'] = username;
    data['password'] = password;
    return data;
  }
}

class T {
  String? updated;
  String? mysqlPull;

  T({this.updated, this.mysqlPull});

  T.fromJson(Map<String, dynamic> json) {
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

class Ema {
  String? hostname;
  int? port;

  Ema({this.hostname, this.port});

  Ema.fromJson(Map<String, dynamic> json) {
    hostname = json['hostname'];
    port = json['port'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['hostname'] = hostname;
    data['port'] = port;
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
