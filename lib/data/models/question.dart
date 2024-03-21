class Question {
  String? sId;
  int? id;
  String? state;
  String? max;
  String? min;
  QuestionTime? questionTime;
  String? text;
  String? type;
  late QuestionType questionType;

  Question({
    this.sId,
    this.id,
    this.state,
    this.max,
    this.min,
    this.questionTime,
    this.text,
    this.type,
    this.questionType = QuestionType.unknown,
  });

  Question.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    id = json['id'];
    state = json['state'];
    max = json['max'].toString();
    min = json['min'].toString();
    questionTime = json['t'] != null ? QuestionTime.fromJson(json['t']) : null;
    text = json['text'];
    type = json['type'];
    questionType = (type == "yesno")
        ? QuestionType.yesno
        : (type == "number")
            ? QuestionType.number
            : QuestionType.unknown;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['id'] = id;
    data['state'] = state;
    data['max'] = max;
    data['min'] = min;
    if (questionTime != null) {
      data['t'] = questionTime!.toJson();
    }
    data['text'] = text;
    data['type'] = type;
    return data;
  }
}

class QuestionTime {
  String? updated;
  String? trigger;
  String? expiry;
  String? emaUpdated;

  QuestionTime({this.updated, this.trigger, this.expiry, this.emaUpdated});

  QuestionTime.fromJson(Map<String, dynamic> json) {
    updated = json['updated'];
    trigger = json['trigger'];
    expiry = json['expiry'];
    emaUpdated = json['ema_updated'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['updated'] = updated;
    data['trigger'] = trigger;
    data['expiry'] = expiry;
    data['ema_updated'] = emaUpdated;
    return data;
  }
}

enum QuestionType {
  yesno,
  number,
  unknown,
}
