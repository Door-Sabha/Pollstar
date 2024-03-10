import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pollstar/data/di/service_locator.dart';
import 'package:pollstar/data/models/api_response.dart';
import 'package:pollstar/data/models/question.dart';
import 'package:pollstar/data/models/questions_response.dart';
import 'package:pollstar/data/repository/pollstar_repository.dart';
import 'package:pollstar/utils/app_constants.dart';
import 'package:pollstar/utils/strings.dart';

part 'inbox_event.dart';
part 'inbox_state.dart';

class InboxBloc extends Bloc<InboxEvent, InboxState> {
  final PollStarRepository _repository;
  InboxBloc(this._repository) : super(InboxInitial()) {
    on<GetInboxQuestions>(_getInboxQuestions);
    on<OpenAnswerScreen>(_openAnswerDialog);
    on<AnswerInboxQuestion>(_answerInboxQuestions);
    on<UpdateQuestionsQueued>(_updateQuestionsQueued);
  }

  Future<void> _getInboxQuestions(GetInboxQuestions event, emit) async {
    String session = getIt<AppConstants>().session;
    String state = getIt<AppConstants>().stateId;
    //String last = DateTime.now().millisecondsSinceEpoch.toString();
    String last = "1709317800000";

    emit(const InboxLoading());
    QuestionsResponse? data = await _repository.getInboxQuestions(
        session: session, state: state, last: last);

    if (data != null &&
        data.state == 1 &&
        data.questions != null &&
        data.questions!.isNotEmpty) {
      emit(InboxSuccessState(list: data.questions!));
    } else if (data != null &&
        data.state == 1 &&
        data.questions != null &&
        data.questions!.isEmpty) {
      emit(InboxEmpty());
    } else if (data != null && data.state == 0) {
      emit(SessionEndState());
    } else {
      emit(const InboxErrorState(error: AppStrings.errorApiUnknown));
    }
  }

  Future<void> _openAnswerDialog(OpenAnswerScreen event, emit) async {
    emit(InboxInitial());
    emit(AnswerScreenState(
        question: event.question, yesnoAnswer: event.yesnoAnswer));
  }

  Future<void> _answerInboxQuestions(AnswerInboxQuestion event, emit) async {
    String user = getIt<AppConstants>().userId;

    emit(InboxInitial());
    emit(const InboxLoading());
    ApiResponse? data = await _repository.updateAnswer(
        user: user, id: event.id, answer: event.answer);

    if (data != null && data.state == 1) {
      emit(const InboxAnswerSuccessState());
    } else if (data != null && data.state == 0) {
      emit(InboxErrorState(error: data.message ?? AppStrings.errorSession));
    } else {
      emit(const InboxErrorState(error: AppStrings.errorSession));
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
}
