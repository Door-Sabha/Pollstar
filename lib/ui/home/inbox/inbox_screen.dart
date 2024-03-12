import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pollstar/ui/home/bloc/questions_bloc.dart';
import 'package:pollstar/ui/home/inbox/widgets/inbox_empty_widget.dart';
import 'package:pollstar/ui/home/inbox/widgets/questions_list_widget.dart';
import 'package:pollstar/ui/home/inbox/widgets/session_end_widget.dart';
import 'package:pollstar/ui/widgets/loading_overlay.dart';
import 'package:pollstar/utils/theme/colors.dart';
import 'package:pollstar/utils/utils.dart';

class InboxScreen extends StatefulWidget {
  const InboxScreen({super.key});

  @override
  State<InboxScreen> createState() => _InboxScreenState();
}

class _InboxScreenState extends State<InboxScreen>
    with AutomaticKeepAliveClientMixin, WidgetsBindingObserver {
  final LoadingOverlay loadingOverlay = LoadingOverlay();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    context.read<QuestionListBloc>().add(const GetQuestionsList());
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return RefreshIndicator(
      displacement: 32,
      backgroundColor: AppColors.greenColor,
      color: Colors.white,
      triggerMode: RefreshIndicatorTriggerMode.onEdge,
      onRefresh: () => _refreshData(context),
      child: BlocConsumer<QuestionListBloc, QuestionListState>(
        listener: (BuildContext context, QuestionListState state) {
          if (state is QuestionListLoading) {
            loadingOverlay.show(context);
          } else if (state is AnswerScreenState) {
            loadingOverlay.hide();
            AppUtils().showAnswerDialog(context,
                question: state.question, yesnoAnswer: state.yesnoAnswer);
          } else if (state is AnswerSuccessState) {
            loadingOverlay.hide();
            context.read<QuestionListBloc>().add(const GetQuestionsList());
          } else if (state is QuestionListErrorState) {
            loadingOverlay.hide();
            AppUtils().showAlertDialog(context, content: state.error);
          } else {
            loadingOverlay.hide();
          }
        },
        buildWhen: (previous, current) {
          return current is InboxListSuccessState ||
              current is QuestionListEmpty ||
              current is SessionEndState;
        },
        builder: (context, state) {
          print(state);
          if (state is InboxListSuccessState) {
            return QuestionsListWidget(list: state.list);
          } else if (state is QuestionListEmpty) {
            return const InboxEmptyWidget();
          } else if (state is SessionEndState) {
            return const SessionEndWidget();
          }
          return const InboxEmptyWidget();
        },
      ),
    );
  }

  Future _refreshData(BuildContext context) async {
    context.read<QuestionListBloc>().add(const GetQuestionsList());
  }

  @override
  bool get wantKeepAlive => true;

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed &&
        ModalRoute.of(context) != null &&
        ModalRoute.of(context)!.isCurrent) {
      context.read<QuestionListBloc>().add(const GetQuestionsList());
    }
  }
}
