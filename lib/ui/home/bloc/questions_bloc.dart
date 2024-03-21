import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pollstar/data/di/service_locator.dart';
import 'package:pollstar/data/models/answer.dart';
import 'package:pollstar/data/models/api_response.dart';
import 'package:pollstar/data/models/question.dart';
import 'package:pollstar/data/models/questions_response.dart';
import 'package:pollstar/data/models/user.dart';
import 'package:pollstar/data/repository/pollstar_repository.dart';
import 'package:pollstar/utils/analytics_manager.dart';
import 'package:pollstar/utils/app_constants.dart';
import 'package:pollstar/utils/connectivity_manager.dart';
import 'package:pollstar/utils/hive_manager.dart';
import 'package:pollstar/utils/secure_storage_manager.dart';
import 'package:pollstar/utils/strings.dart';
import 'package:pollstar/utils/utils.dart';

part 'questions_event.dart';
part 'questions_state.dart';

class QuestionListBloc extends Bloc<QuestionListEvent, QuestionListState> {
  final PollStarRepository _repository;
  final HiveManager _hive;
  QuestionListBloc(this._repository)
      : _hive = getIt<HiveManager>(),
        super(QuestionListInitial()) {
    on<GetQuestionsList>(_getQuestionsList);
    on<OpenAnswerDialog>(_openAnswerDialog);
    on<AnswerQuestion>(_answerInboxQuestions);
    on<UpdateQuestionsQueued>(_updateQuestionsQueued);
    on<UpdateQuestionsTriggered>(_updateQuestionsTriggered);
  }

  Future<void> _getQuestionsList(GetQuestionsList event, emit) async {
    bool isOnline = await getIt<ConnectivityManager>().hasInternet();
    if (!isOnline) {
      emit(QuestionListInitial());
      emit(const NoNetworkState(error: AppStrings.errorNetwork));
      return;
    }

    emit(QuestionListInitial());
    if (!event.isBackground) {
      emit(const QuestionListLoading());
    }

    String session =
        await getIt<SecureStorageManager>().getValue(AppStrings.prefSession) ??
            "";
    String state =
        await getIt<SecureStorageManager>().getValue(AppStrings.prefStateId) ??
            "";
    String last = (getIt<AppConstants>().lastRefreshTime != null)
        ? getIt<AppConstants>().lastRefreshTime.toString()
        : DateTime.now().millisecondsSinceEpoch.toString();

    QuestionsResponse? data = await _repository.getQuestionsList(
        session: session, state: state, last: last);

    if (data != null &&
        data.state == 1 &&
        data.questions != null &&
        data.questions!.isNotEmpty) {
      data.questions!.sort(
        (a, b) {
          if (a.questionTime == null || a.questionTime!.trigger == null) {
            return -1;
          } else if (b.questionTime == null ||
              b.questionTime!.trigger == null) {
            return 1;
          } else {
            return b.questionTime!.trigger!.compareTo(a.questionTime!.trigger!);
          }
        },
      );

      getIt<AppConstants>().queuedTime = null;
      var (inboxList, outboxList, queue) = _filterQuestions(data.questions!);
      if (inboxList.isNotEmpty) {
        emit(QuestionListInitial());
        emit(InboxListSuccessState(list: inboxList));
        getIt<AppConstants>().lastRefreshTime =
            DateTime.now().millisecondsSinceEpoch;
      } else {
        emit(QuestionListInitial());
        emit(InboxListEmpty());
      }
      if (outboxList.isNotEmpty) {
        emit(QuestionListInitial());
        emit(OutboxListSuccessState(list: outboxList));
      } else {
        emit(QuestionListInitial());
        emit(OutboxListEmpty());
      }
      _handleQueuedAndTriggered(queue, inboxList);
    } else if (data != null &&
        data.state == 1 &&
        data.questions != null &&
        data.questions!.isEmpty) {
      emit(InboxListEmpty());
      emit(OutboxListEmpty());
    } else if (data != null && data.state == 0) {
      emit(SessionEndState());
    } else {
      emit(const QuestionListErrorState(error: AppStrings.errorApiUnknown));
    }
  }

  (List<Question>, List<Question>, List<Question>) _filterQuestions(
      List<Question> questions) {
    List<Question> inbox = [];
    List<Question> outbox = [];
    List<Question> queue = [];

    var now = DateTime.now().millisecondsSinceEpoch;

    for (var q in questions) {
      if (q.questionTime == null ||
          q.questionTime!.trigger == null ||
          q.questionTime!.expiry == null) {
        continue;
      }

      if (now >=
              AppUtils()
                  .getMillisecondFromDateString(q.questionTime!.trigger!) &&
          now <=
              AppUtils()
                  .getMillisecondFromDateString(q.questionTime!.expiry!) &&
          !_hive.containsAnswer(q.sId)) {
        inbox.add(q);
      } else if (now <
              AppUtils()
                  .getMillisecondFromDateString(q.questionTime!.trigger!) &&
          now <
              AppUtils()
                  .getMillisecondFromDateString(q.questionTime!.expiry!) &&
          !_hive.containsAnswer(q.sId)) {
        queue.add(q);

        ///Update Queued time
        if (getIt<AppConstants>().queuedTime == null &&
            q.questionTime != null &&
            q.questionTime!.trigger != null) {
          getIt<AppConstants>().queuedTime =
              AppUtils().getMillisecondFromDateString(q.questionTime!.trigger!);
        }
      } else {
        outbox.add(q);
      }
    }

    return (inbox, outbox, queue);
  }

  _handleQueuedAndTriggered(List<Question> q, List<Question> t) async {
    String user =
        await getIt<SecureStorageManager>().getValue(AppStrings.prefUserId) ??
            "";
    for (var e in q) {
      ApiResponse? data =
          await _repository.questionsQueued(user: user, id: e.sId ?? "");
      if (data != null && data.state == 1) {}
    }

    for (var e in t) {
      ApiResponse? data =
          await _repository.questionsTriggered(user: user, id: e.sId ?? "");
      if (data != null && data.state == 1) {}
    }
  }

  Future<void> _openAnswerDialog(OpenAnswerDialog event, emit) async {
    emit(QuestionListInitial());
    emit(AnswerScreenState(
        question: event.question, yesnoAnswer: event.yesnoAnswer));
  }

  Future<void> _answerInboxQuestions(AnswerQuestion event, emit) async {
    bool isOnline = await getIt<ConnectivityManager>().hasInternet();
    if (!isOnline) {
      emit(QuestionListInitial());
      emit(const QuestionListErrorState(error: AppStrings.errorNetwork));
      return;
    }

    if (event.question.questionType == QuestionType.number &&
        !validateAnswer(event.question, event.answer)) {
      emit(QuestionListInitial());
      emit(const QuestionListErrorState(error: AppStrings.errorInvalidAnswer));
      return;
    }

    emit(QuestionListInitial());
    emit(const AnswerLoading());
    String userId =
        await getIt<SecureStorageManager>().getValue(AppStrings.prefUserId) ??
            "";

    ApiResponse? data = await _repository.updateAnswer(
        user: userId, id: event.question.sId ?? "", answer: event.answer);

    if (data != null && data.state == 1) {
      _hive.addAnswer(Answer(
          questionId: event.question.sId ?? "",
          updated: DateTime.now().millisecondsSinceEpoch,
          answer: event.answer));
      emit(const AnswerSuccessState());
      getIt<AnalyticsManager>().logEvent(name: AppStrings().faEventAnswer);
    } else if (data != null && data.state == 0) {
      emit(QuestionListErrorState(
          error: data.message ?? AppStrings.errorSession));
    } else {
      emit(const QuestionListErrorState(error: AppStrings.errorSession));
    }
  }

  bool validateAnswer(Question question, String a) {
    int answer;

    try {
      answer = int.parse(a);
    } catch (e) {
      answer = -1;
    }

    if (answer == -1) return false;

    User? user = getIt<HiveManager>().getUser();
    if (user == null || user.userParams == null) return false;

    bool status = false;
    String? max = question.max;

    if (max == QuestionResponseType.boothId.value) {
      if (answer == user.userParams?.boothid) status = true;
    } else if (max == QuestionResponseType.boothRefNo.value) {
      if (a == user.userParams?.boothRefno) status = true;
    } else if (max == QuestionResponseType.boothName.value) {
      if (a == user.userParams?.boothName) status = true;
    } else if (max == QuestionResponseType.totalVotersCount.value) {
      int count = user.userParams?.totalVotersCount ?? -1;
      if (answer <= count) status = true;
    } else if (max == QuestionResponseType.maleVotersCount.value) {
      int count = user.userParams?.maleVotersCount ?? -1;
      if (answer <= count) status = true;
    } else if (max == QuestionResponseType.femaleVotersCount.value) {
      int count = user.userParams?.femaleVotersCount ?? -1;
      if (answer <= count) status = true;
    } else {
      return true;
    }
    return status;
  }

  Future<void> _updateQuestionsQueued(UpdateQuestionsQueued event, emit) async {
    String user =
        await getIt<SecureStorageManager>().getValue(AppStrings.prefUserId) ??
            "";

    ApiResponse? data =
        await _repository.questionsQueued(user: user, id: event.id);

    if (data != null && data.state == 1) {
      emit(const UpdatedQuestionsQueued());
    }
  }

  Future<void> _updateQuestionsTriggered(
      UpdateQuestionsTriggered event, emit) async {
    String user =
        await getIt<SecureStorageManager>().getValue(AppStrings.prefUserId) ??
            "";

    ApiResponse? data =
        await _repository.questionsTriggered(user: user, id: event.id);

    if (data != null && data.state == 1) {
      emit(const UpdatedQuestionsTriggered());
    }
  }
}
