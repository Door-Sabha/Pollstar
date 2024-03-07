import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pollstar/data/repository/pollstar_repository.dart';
import 'package:pollstar/ui/home/inbox/bloc/inbox_bloc.dart';
import 'package:pollstar/ui/home/inbox/widgets/questions_empty_widget.dart';
import 'package:pollstar/ui/home/inbox/widgets/questions_list_widget.dart';
import 'package:pollstar/ui/home/outbox/bloc/outbox_bloc.dart';
import 'package:pollstar/utils/theme/colors.dart';

class OutboxScreen extends StatefulWidget {
  const OutboxScreen({super.key});

  @override
  State<OutboxScreen> createState() => _OutboxScreenState();
}

class _OutboxScreenState extends State<OutboxScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocProvider(
      create: (context) => OutboxBloc(
        RepositoryProvider.of<PollStarRepository>(context),
      )..add(const GetOutboxQuestions()),
      child: RefreshIndicator(
        displacement: 32,
        backgroundColor: AppColors.greenColor,
        color: Colors.white,
        triggerMode: RefreshIndicatorTriggerMode.onEdge,
        onRefresh: () => _refreshData(context),
        child: BlocBuilder<OutboxBloc, OutboxState>(
          builder: (context, state) {
            if (state is OutboxSuccessState) {
              return QuestionsListWidget(list: state.list, isInbox: false);
            } else if (state is OutboxEmpty) {
              return const QuestionsEmptyWidget();
            } else if (state is OutboxErrorState) {
              return Container();
            } else if (state is OutboxLoading) {
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
    context.read<OutboxBloc>().add(const GetOutboxQuestions());
  }

  @override
  bool get wantKeepAlive => true;
}
