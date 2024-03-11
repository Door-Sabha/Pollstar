import 'package:hive_flutter/hive_flutter.dart';
import 'package:pollstar/data/models/answer.dart';
import 'package:pollstar/utils/extensions.dart';
import 'package:pollstar/utils/strings.dart';

class HiveManager {
  late Box<Answer> _box;

  HiveManager() {
    _init();
  }

  _init() async {
    await Hive.initFlutter();
    Hive.registerAdapter<Answer>(AnswerAdapter());
    _box = await Hive.openBox(AppStrings.hiveBox);
  }

  addAnswer(Answer answer) async {
    await _box.put(answer.questionId, answer);
  }

  bool containsAnswer(String? id) {
    if (id.isNullOrEmpty()) return false;

    return _box.containsKey(id);
  }

  Answer? getAnswers(String? id) {
    if (id.isNullOrEmpty()) return null;

    return _box.get(id);
  }

  List<Answer> getAnswersList() {
    return _box.values.toList();
  }

  deleteAnswer(Answer answer) async {
    await _box.delete(answer.questionId);
  }

  deleteAll() async {
    await _box.clear();
  }
}
