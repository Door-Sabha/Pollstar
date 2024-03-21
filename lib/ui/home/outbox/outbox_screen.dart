import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pollstar/ui/home/bloc/questions_bloc.dart';
import 'package:pollstar/ui/home/inbox/widgets/questions_list_widget.dart';
import 'package:pollstar/ui/home/outbox/widgets/outbox_empty_widget.dart';
import 'package:pollstar/utils/theme/colors.dart';

class OutboxScreen extends StatefulWidget {
  const OutboxScreen({super.key});

  @override
  State<OutboxScreen> createState() => _OutboxScreenState();
}

class _OutboxScreenState extends State<OutboxScreen>
    with AutomaticKeepAliveClientMixin {
  //final LoadingOverlay loadingOverlay = LoadingOverlay();
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return RefreshIndicator(
      displacement: 32,
      backgroundColor: AppColors.greenColor,
      color: Colors.white,
      triggerMode: RefreshIndicatorTriggerMode.onEdge,
      onRefresh: () => _refreshData(context),
      child: BlocBuilder<QuestionListBloc, QuestionListState>(
        buildWhen: (previous, current) {
          return current is OutboxListSuccessState ||
              current is OutboxListEmpty ||
              current is QuestionListErrorState ||
              current is QuestionListLoading;
        },
        builder: (context, state) {
          if (state is OutboxListSuccessState) {
            return QuestionsListWidget(list: state.list, isInbox: false);
          } else if (state is OutboxListEmpty) {
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
            //return const OutboxLoadingWidget();
          }
          return const OutboxEmptyWidget();
        },
      ),
    );
  }

  Future _refreshData(BuildContext context) async {
    context.read<QuestionListBloc>().add(const GetQuestionsList());
  }

  @override
  bool get wantKeepAlive => true;
}
