import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pollstar/data/di/service_locator.dart';
import 'package:pollstar/data/models/question.dart';
import 'package:pollstar/data/repository/pollstar_repository.dart';
import 'package:pollstar/utils/app_constants.dart';

part 'outbox_event.dart';
part 'outbox_state.dart';

class OutboxBloc extends Bloc<OutboxEvent, OutboxState> {
  final PollStarRepository _repository;
  OutboxBloc(this._repository) : super(OutboxInitial()) {
    on<GetOutboxQuestions>(_getOutboxQuestions);
  }

  Future<void> _getOutboxQuestions(GetOutboxQuestions event, emit) async {
    String session = getIt<AppConstants>().session;
    String state = getIt<AppConstants>().stateId;
    String last = DateTime.now().millisecondsSinceEpoch.toString();

    emit(OutboxLoading());
    List<Question>? data = await _repository.getOutboxQuestions(
        session: session, state: state, last: last);

    if (data != null && data.isNotEmpty) {
      emit(OutboxSuccessState(list: data));
    } else if (data != null && data.isEmpty) {
      emit(OutboxEmpty());
    }
  }
}
