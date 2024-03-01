import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pollstar/data/di/service_locator.dart';
import 'package:pollstar/data/models/api_response.dart';
import 'package:pollstar/data/repository/pollstar_repository.dart';
import 'package:pollstar/utils/app_constants.dart';
import 'package:pollstar/utils/strings.dart';

part 'help_event.dart';
part 'help_state.dart';

class HelpBloc extends Bloc<HelpEvent, HelpState> {
  final PollStarRepository _repository;

  HelpBloc(this._repository) : super(HelpInitial()) {
    on<ReportProblem>(_reportProblem);
  }

  Future<void> _reportProblem(ReportProblem event, emit) async {
    if (event.type.trim().isEmpty) {
      emit(HelpInitial());
      emit(const HelpErrorState(error: AppStrings.errProplemReportingNoTitle));
    } else if (event.message.trim().isEmpty) {
      emit(HelpInitial());
      emit(const HelpErrorState(error: AppStrings.errProplemReportingNoMsg));
    } else {
      emit(ProblemReportingLoading());
      String userId = getIt<AppConstants>().userId;
      String stateId = getIt<AppConstants>().stateId;

      ApiResponse? data = await _repository.reportProblem(
          userId: userId,
          stateId: stateId,
          type: event.type,
          message: event.message);
      if (data != null && data.state == 1) {
        emit(ProblemReportingSuccess(data: data));
      } else if (data != null && data.state == 0) {
        emit(HelpInitial());
        emit(HelpErrorState(error: data.message ?? AppStrings.errorApiUnknown));
      } else {
        emit(const HelpErrorState(error: AppStrings.errorApiUnknown));
      }
    }
  }
}
