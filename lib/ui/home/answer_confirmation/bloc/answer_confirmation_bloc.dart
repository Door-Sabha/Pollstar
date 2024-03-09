import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pollstar/data/models/question.dart';

part 'answer_confirmation_event.dart';
part 'answer_confirmation_state.dart';

class AnswerConfirmationBloc
    extends Bloc<AnswerConfirmationEvent, AnswerConfirmationState> {
  AnswerConfirmationBloc() : super(AnswerConfirmationInitial()) {
    on<LoadInitialQuestion>(_loadInitalQuestion);
    on<SwitchForNumberConfirmation>(_switchNumberConfirmation);
  }

  Future<void> _loadInitalQuestion(LoadInitialQuestion event, emit) async {
    emit(AnswerConfirmationInitial());
    if (event.question.questionType == QuestionType.yesno) {
      emit(YesNoQuestionState(answer: event.yesnoAnswer));
    } else if (event.question.questionType == QuestionType.number) {
      emit(NumberQuestionState());
    }
  }

  Future<void> _switchNumberConfirmation(
      SwitchForNumberConfirmation event, emit) async {
    emit(AnswerConfirmationInitial());
    emit(NumberQuestionConfirmationState(answer: event.answer));
  }
}
