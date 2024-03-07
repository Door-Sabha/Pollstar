import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pollstar/data/repository/pollstar_repository.dart';
import 'package:pollstar/ui/home/inbox/bloc/inbox_bloc.dart';
import 'package:pollstar/ui/home/inbox/widgets/questions_empty_widget.dart';
import 'package:pollstar/ui/home/inbox/widgets/questions_list_widget.dart';
import 'package:pollstar/ui/widgets/loading_overlay.dart';
import 'package:pollstar/utils/theme/colors.dart';
import 'package:pollstar/utils/utils.dart';

class InboxScreen extends StatefulWidget {
  const InboxScreen({super.key});

  @override
  State<InboxScreen> createState() => _InboxScreenState();
}

class _InboxScreenState extends State<InboxScreen>
    with AutomaticKeepAliveClientMixin {
  final LoadingOverlay loadingOverlay = LoadingOverlay();

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocProvider(
      create: (context) => InboxBloc(
        RepositoryProvider.of<PollStarRepository>(context),
      )..add(const GetInboxQuestions()),
      child: RefreshIndicator(
        displacement: 32,
        backgroundColor: AppColors.greenColor,
        color: Colors.white,
        triggerMode: RefreshIndicatorTriggerMode.onEdge,
        onRefresh: () => _refreshData(context),
        child: BlocConsumer<InboxBloc, InboxState>(
          listener: (BuildContext context, InboxState state) {
            if (state is InboxLoading) {
              loadingOverlay.show(context);
            } else if (state is InboxAnswerDialogState) {
              loadingOverlay.hide();
              AppUtils().showAnswerDialog(context,
                  question: state.question, questionType: state.questionType);
            } else if (state is InboxAnswerSuccessState) {
              loadingOverlay.hide();
              context.read<InboxBloc>().add(const GetInboxQuestions());
            } else if (state is InboxErrorState) {
              loadingOverlay.hide();
            } else {
              loadingOverlay.hide();
            }
          },
          buildWhen: (previous, current) {
            return current is InboxSuccessState || current is InboxEmpty;
          },
          builder: (context, state) {
            if (state is InboxSuccessState) {
              return QuestionsListWidget(list: state.list);
            } else if (state is InboxEmpty) {
              return const QuestionsEmptyWidget();
            } else if (state is InboxErrorState) {
              return Container();
            } else if (state is InboxLoading) {
              return const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(AppColors.orangeColor),
                  backgroundColor: AppColors.greenColor,
                  strokeCap: StrokeCap.round,
                ),
              );
            }
            return Container();
          },
        ),
      ),
    );
  }

  Future _refreshData(BuildContext context) async {
    context.read<InboxBloc>().add(const GetInboxQuestions());
  }

  @override
  bool get wantKeepAlive => true;
}
