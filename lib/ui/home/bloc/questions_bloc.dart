import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pollstar/data/di/service_locator.dart';
import 'package:pollstar/data/models/answer.dart';
import 'package:pollstar/data/models/api_response.dart';
import 'package:pollstar/data/models/question.dart';
import 'package:pollstar/data/models/questions_response.dart';
import 'package:pollstar/data/repository/pollstar_repository.dart';
import 'package:pollstar/utils/app_constants.dart';
import 'package:pollstar/utils/hive_manager.dart';
import 'package:pollstar/utils/strings.dart';
import 'package:pollstar/utils/utils.dart';

part 'questions_state.dart';
part 'questions_event.dart';

class QuestionListBloc extends Bloc<QuestionListEvent, QuestionListState> {
  final PollStarRepository _repository;
  final HiveManager _hive;
  QuestionListBloc(this._repository)
      : _hive = getIt<HiveManager>(),
        super(QuestionListInitial()) {
    on<GetQuestionsList>(_getQuestions);
    on<OpenAnswerDialog>(_openAnswerDialog);
    on<AnswerQuestion>(_answerInboxQuestions);
    on<UpdateQuestionsQueued>(_updateQuestionsQueued);
    on<UpdateQuestionsTriggered>(_updateQuestionsTriggered);
  }

  Future<void> _getQuestions(GetQuestionsList event, emit) async {
    String session = getIt<AppConstants>().session;
    String state = getIt<AppConstants>().stateId;
    String last = getIt<AppConstants>().lastRefreshTime.toString();

    emit(const QuestionListLoading());
    QuestionsResponse? data = await _repository.getInboxQuestions(
        session: session, state: state, last: last);

    if (data != null &&
        data.state == 1 &&
        data.questions != null &&
        data.questions!.isNotEmpty) {
      var (inboxList, outboxList) = _filterQuestions(data.questions!);
      getIt<AppConstants>().lastRefreshTime =
          DateTime.now().millisecondsSinceEpoch;
      if (inboxList.isNotEmpty) {
        emit(InboxListSuccessState(list: inboxList));
      } else {
        emit(QuestionListEmpty());
      }
      if (outboxList.isNotEmpty) {
        emit(OutboxListSuccessState(list: outboxList));
      } else {
        emit(QuestionListEmpty());
      }
    } else if (data != null &&
        data.state == 1 &&
        data.questions != null &&
        data.questions!.isEmpty) {
      emit(QuestionListEmpty());
    } else if (data != null && data.state == 0) {
      emit(SessionEndState());
    } else {
      emit(const QuestionListErrorState(error: AppStrings.errorApiUnknown));
    }
  }

  (List<Question>, List<Question>) _filterQuestions(List<Question> questions) {
    List<Question> inbox = [];
    List<Question> outbox = [];

    var now = DateTime.now().millisecondsSinceEpoch;

    for (var q in questions) {
      if (q.questionTime == null ||
          q.questionTime!.trigger == null ||
          q.questionTime!.expiry == null) {
        continue;
      }
      // print(now);
      // print(AppUtils().getMillisecondFromDateString(q.questionTime!.trigger!));
      // print(AppUtils().getMillisecondFromDateString(q.questionTime!.expiry!));
      if (now >=
              AppUtils()
                  .getMillisecondFromDateString(q.questionTime!.trigger!) &&
          now <=
              AppUtils()
                  .getMillisecondFromDateString(q.questionTime!.expiry!)) {
        inbox.add(q);
      } else if (now <
              AppUtils()
                  .getMillisecondFromDateString(q.questionTime!.trigger!) &&
          now <
              AppUtils()
                  .getMillisecondFromDateString(q.questionTime!.expiry!)) {
      } else {
        outbox.add(q);
      }
    }

    return (inbox, outbox);
  }

  Future<void> _openAnswerDialog(OpenAnswerDialog event, emit) async {
    emit(QuestionListInitial());
    emit(AnswerScreenState(
        question: event.question, yesnoAnswer: event.yesnoAnswer));
  }

  Future<void> _answerInboxQuestions(AnswerQuestion event, emit) async {
    String user = getIt<AppConstants>().userId;

    emit(QuestionListInitial());
    emit(const QuestionListLoading());
    ApiResponse? data = await _repository.updateAnswer(
        user: user, id: event.id, answer: event.answer);

    if (data != null && data.state == 1) {
      _hive.addAnswer(Answer(
          questionId: event.id,
          updated: DateTime.now().millisecondsSinceEpoch,
          answer: event.answer));
      emit(const AnswerSuccessState());
    } else if (data != null && data.state == 0) {
      emit(QuestionListErrorState(
          error: data.message ?? AppStrings.errorSession));
    } else {
      emit(const QuestionListErrorState(error: AppStrings.errorSession));
    }
  }

  Future<void> _updateQuestionsQueued(UpdateQuestionsQueued event, emit) async {
    String user = getIt<AppConstants>().userId;

    ApiResponse? data =
        await _repository.questionsQueued(user: user, id: event.id);

    if (data != null && data.state == 1) {
      emit(const UpdatedQuestionsQueued());
    }
  }

  Future<void> _updateQuestionsTriggered(
      UpdateQuestionsTriggered event, emit) async {
    String user = getIt<AppConstants>().userId;

    ApiResponse? data =
        await _repository.questionsTriggered(user: user, id: event.id);

    if (data != null && data.state == 1) {
      emit(const UpdatedQuestionsQueued());
    }
  }
}
