import 'package:hive_flutter/hive_flutter.dart';
import 'package:pollstar/data/models/answer.dart';
import 'package:pollstar/data/models/user.dart';
import 'package:pollstar/utils/extensions.dart';
import 'package:pollstar/utils/strings.dart';

class HiveManager {
  late Box<Answer> answerBox;
  late Box<User> userBox;

  HiveManager() {
    //_init();
  }

  updateUser(User user) async {
    await userBox.put(AppStrings.hivePrefUser, user);
  }

  User? getUser() {
    return userBox.get(AppStrings.hivePrefUser);
  }

  addAnswer(Answer answer) async {
    await answerBox.put(answer.questionId, answer);
  }

  bool containsAnswer(String? id) {
    if (id.isNullOrEmpty()) return false;

    return answerBox.containsKey(id);
  }

  Answer? getAnswers(String? id) {
    if (id.isNullOrEmpty()) return null;

    return answerBox.get(id);
  }

  List<Answer> getAnswersList() {
    return answerBox.values.toList();
  }

  deleteAnswer(Answer answer) async {
    await answerBox.delete(answer.questionId);
  }

  deleteAll() async {
    await answerBox.clear();
    await userBox.clear();
  }
}
