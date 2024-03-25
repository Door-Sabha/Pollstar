import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pollstar/ui/home/bloc/questions_bloc.dart';
import 'package:pollstar/ui/home/inbox/widgets/inbox_empty_widget.dart';
import 'package:pollstar/ui/home/inbox/widgets/questions_list_widget.dart';
import 'package:pollstar/ui/home/inbox/widgets/session_end_widget.dart';
import 'package:pollstar/ui/widgets/loading_overlay.dart';
import 'package:pollstar/utils/broadcast_manager.dart';
import 'package:pollstar/utils/strings.dart';
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

  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;
  late Stream<BroadcastNotification> _notificationsStream;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    context.read<QuestionListBloc>().add(const GetQuestionsList());

    initConnectivity();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);

    _notificationsStream =
        BroadcastNotificationBloc.instance.notificationsStream;
    _notificationsStream.listen((notification) {
      context.read<QuestionListBloc>().add(const GetQuestionsList());
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _connectivitySubscription.cancel();
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
          if (state is AnswerLoading) {
            loadingOverlay.show(context);
          } else if (state is AnswerScreenState) {
            loadingOverlay.hide();
            AppUtils().showAnswerDialog(context,
                question: state.question, yesnoAnswer: state.yesnoAnswer);
          } else if (state is AnswerSuccessState) {
            loadingOverlay.hide();
            context
                .read<QuestionListBloc>()
                .add(const GetQuestionsList(isBackground: true));
          } else if (state is QuestionListErrorState) {
            loadingOverlay.hide();
            AppUtils().showAlertDialog(context, content: state.error);
          } else if (state is NoNetworkState) {
            loadingOverlay.hide();
            AppUtils().showSnackBar(context, state.error);
          } else {
            loadingOverlay.hide();
          }
        },
        buildWhen: (previous, current) {
          return current is InboxListSuccessState ||
              current is InboxListEmpty ||
              current is SessionEndState ||
              current is QuestionListLoading;
        },
        builder: (context, state) {
          if (state is InboxListSuccessState) {
            return QuestionsListWidget(list: state.list);
          } else if (state is InboxListEmpty) {
            return const InboxEmptyWidget();
          } else if (state is SessionEndState) {
            return const SessionEndWidget();
          } else if (state is QuestionListLoading) {
            return const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(AppColors.orangeColor),
                backgroundColor: AppColors.greenColor,
                strokeCap: StrokeCap.round,
              ),
            );
            //return const InboxLoadingWidget();
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

  Future<void> initConnectivity() async {
    late ConnectivityResult result;
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException {
      return;
    }
    if (!mounted) {
      return Future.value(null);
    }

    return _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    if (result == ConnectivityResult.mobile ||
        result == ConnectivityResult.wifi) {
    } else {
      AppUtils().showSnackBar(context, AppStrings.errorNetwork);
    }
  }
}
