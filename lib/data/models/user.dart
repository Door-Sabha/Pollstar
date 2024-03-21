import 'package:hive_flutter/hive_flutter.dart';

part 'user.g.dart';

@HiveType(typeId: 1, adapterName: "UserAdapter")
class User extends HiveObject {
  @HiveField(0)
  int? state;

  @HiveField(1)
  String? id;

  @HiveField(2)
  String? stateId;

  @HiveField(3)
  StateInfo? stateInfo;

  @HiveField(4)
  UserParams? userParams;

  @HiveField(5)
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

@HiveType(typeId: 2, adapterName: "StateInfoAdapter")
class StateInfo extends HiveObject {
  @HiveField(0)
  String? sId;

  @HiveField(1)
  String? name;

  @HiveField(2)
  String? code;

  @HiveField(3)
  String? emaId;

  @HiveField(4)
  int? active;

  @HiveField(5)
  String? tCreated;

  @HiveField(6)
  String? aGENT;

  @HiveField(7)
  String? iP;

  @HiveField(8)
  String? emergencyNumbers;

  @HiveField(9)
  String? headerImage;

  @HiveField(10)
  String? helpUrl;

  @HiveField(11)
  List<String>? problemReasons;

  StateInfo(
      {this.sId,
      this.name,
      this.code,
      this.emaId,
      this.active,
      this.tCreated,
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
    data['AGENT'] = aGENT;
    data['IP'] = iP;
    data['emergency_numbers'] = emergencyNumbers;
    data['header_image'] = headerImage;
    data['help_url'] = helpUrl;
    data['problem_reasons'] = problemReasons;
    return data;
  }
}

@HiveType(typeId: 3, adapterName: "UserParamsAdapter")
class UserParams {
  @HiveField(0)
  String? sId;

  @HiveField(1)
  int? boothid;

  @HiveField(2)
  String? boothRefno;

  @HiveField(3)
  String? boothName;

  @HiveField(4)
  String? phoneNumber;

  @HiveField(5)
  int? boothStatus;

  @HiveField(6)
  int? totalVotersCount;

  @HiveField(7)
  String? latitude;

  @HiveField(8)
  String? longitude;

  @HiveField(9)
  int? maleVotersCount;

  @HiveField(10)
  int? femaleVotersCount;

  @HiveField(11)
  int? updateId;

  @HiveField(12)
  String? updateTime;

  @HiveField(13)
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

enum QuestionResponseType {
  boothId("boothid"),
  boothRefNo("booth_refno"),
  boothName("booth_name"),
  totalVotersCount("total_voters_count"),
  maleVotersCount("male_voters_count"),
  femaleVotersCount("female_voters_count");

  const QuestionResponseType(this.value);
  final String value;
}
