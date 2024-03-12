import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pollstar/data/repository/pollstar_repository.dart';
import 'package:pollstar/ui/home/bloc/questions_bloc.dart';
import 'package:pollstar/ui/home/inbox/widgets/questions_list_widget.dart';
import 'package:pollstar/ui/home/outbox/widgets/outbox_empty_widget.dart';
import 'package:pollstar/ui/widgets/loading_overlay.dart';
import 'package:pollstar/utils/theme/colors.dart';

class OutboxScreen extends StatefulWidget {
  const OutboxScreen({super.key});

  @override
  State<OutboxScreen> createState() => _OutboxScreenState();
}

class _OutboxScreenState extends State<OutboxScreen>
    with AutomaticKeepAliveClientMixin {
  final LoadingOverlay loadingOverlay = LoadingOverlay();
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocProvider(
      create: (context) => QuestionListBloc(
        RepositoryProvider.of<PollStarRepository>(context),
      )..add(const GetQuestionsList()),
      child: RefreshIndicator(
        displacement: 32,
        backgroundColor: AppColors.greenColor,
        color: Colors.white,
        triggerMode: RefreshIndicatorTriggerMode.onEdge,
        onRefresh: () => _refreshData(context),
        child: BlocConsumer<QuestionListBloc, QuestionListState>(
          listener: (context, state) {
            print("Outbox listener state: $state");
            if (state is QuestionListLoading) {
              loadingOverlay.show(context);
            } else {
              loadingOverlay.hide();
            }
          },
          builder: (context, state) {
            print("Outbox builder state: $state");

            if (state is OutboxListSuccessState) {
              return QuestionsListWidget(list: state.list, isInbox: false);
            } else if (state is QuestionListEmpty) {
              return const OutboxEmptyWidget();
            } else if (state is QuestionListErrorState) {
              return Container();
            } else if (state is QuestionListLoading) {
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
    context.read<QuestionListBloc>().add(const GetQuestionsList());
  }

  @override
  bool get wantKeepAlive => true;
}
