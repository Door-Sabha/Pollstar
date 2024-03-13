import 'package:hive_flutter/hive_flutter.dart';
import 'package:pollstar/data/models/answer.dart';
import 'package:pollstar/data/models/user.dart';
import 'package:pollstar/utils/extensions.dart';
import 'package:pollstar/utils/strings.dart';

class HiveManager {
  late Box<Answer> _answerBox;
  late Box<User> _userBox;

  HiveManager() {
    _init();
  }

  _init() async {
    await Hive.initFlutter();
    Hive.registerAdapter<User>(UserAdapter());
    Hive.registerAdapter<StateInfo>(StateInfoAdapter());
    Hive.registerAdapter<UserParams>(UserParamsAdapter());
    Hive.registerAdapter<Answer>(AnswerAdapter());
    _userBox = await Hive.openBox(AppStrings.hiveBoxUser);
    _answerBox = await Hive.openBox(AppStrings.hiveBoxAnswers);
  }

  updateUser(User user) async {
    await _userBox.put(AppStrings.hivePrefUser, user);
  }

  User? getUser() {
    return _userBox.get(AppStrings.hivePrefUser);
  }

  addAnswer(Answer answer) async {
    await _answerBox.put(answer.questionId, answer);
  }

  bool containsAnswer(String? id) {
    if (id.isNullOrEmpty()) return false;

    return _answerBox.containsKey(id);
  }

  Answer? getAnswers(String? id) {
    if (id.isNullOrEmpty()) return null;

    return _answerBox.get(id);
  }

  List<Answer> getAnswersList() {
    return _answerBox.values.toList();
  }

  deleteAnswer(Answer answer) async {
    await _answerBox.delete(answer.questionId);
  }

  deleteAll() async {
    await _answerBox.clear();
    await _userBox.clear();
  }
}
