import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pollstar/data/di/service_locator.dart';
import 'package:pollstar/data/models/question.dart';
import 'package:pollstar/data/repository/pollstar_repository.dart';
import 'package:pollstar/utils/app_constants.dart';
import 'package:pollstar/utils/strings.dart';

part 'inbox_event.dart';
part 'inbox_state.dart';

class InboxBloc extends Bloc<InboxEvent, InboxState> {
  final PollStarRepository _repository;
  InboxBloc(this._repository) : super(InboxInitial()) {
    on<GetInboxQuestions>(_getInboxQuestions);
    on<OpenAnswerDialog>(_openAnswerDialog);
    on<AnswerInboxQuestion>(_answerInboxQuestions);
  }

  Future<void> _getInboxQuestions(GetInboxQuestions event, emit) async {
    String session = getIt<AppConstants>().session;
    String state = getIt<AppConstants>().stateId;
    String last = DateTime.now().millisecondsSinceEpoch.toString();

    emit(const InboxLoading());
    List<Question>? data = await _repository.getInboxQuestions(
        session: session, state: state, last: last);

    if (data != null && data.isNotEmpty) {
      emit(InboxSuccessState(list: data));
    } else if (data != null && data.isEmpty) {
      emit(InboxEmpty());
    } else {
      emit(const InboxErrorState(error: AppStrings.errorSession));
    }
  }

  Future<void> _openAnswerDialog(OpenAnswerDialog event, emit) async {
    emit(InboxInitial());
    emit(InboxAnswerDialogState(
        question: event.question, questionType: event.questionType));
  }

  Future<void> _answerInboxQuestions(AnswerInboxQuestion event, emit) async {
    emit(const InboxAnswerSuccessState());
  }
}
