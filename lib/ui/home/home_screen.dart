import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pollstar/data/di/service_locator.dart';
import 'package:pollstar/data/models/user.dart';
import 'package:pollstar/data/repository/pollstar_repository.dart';
import 'package:pollstar/ui/auth/login_screen.dart';
import 'package:pollstar/ui/home/bloc/questions_bloc.dart';
import 'package:pollstar/ui/home/bloc/user_info_bloc.dart';
import 'package:pollstar/ui/home/widgets/appbar_widget.dart';
import 'package:pollstar/ui/home/widgets/drawer_widget.dart';
import 'package:pollstar/ui/home/widgets/tab_widget.dart';
import 'package:pollstar/ui/widgets/loading_overlay.dart';
import 'package:pollstar/utils/analytics_manager.dart';
import 'package:pollstar/utils/strings.dart';
import 'package:pollstar/utils/utils.dart';

class HomeScreen extends StatelessWidget {
  final User user;
  const HomeScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    final LoadingOverlay loadingOverlay = LoadingOverlay();
    getIt<AnalyticsManager>().logScreenView(name: AppStrings().faScreenInbox);
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => UserInfoBloc(
            RepositoryProvider.of<PollStarRepository>(context),
          )
            ..add(const UpdateLocalAnswers())
            ..add(const UpdateFcmToken()),
        ),
        BlocProvider(
          create: (context) => QuestionListBloc(
            RepositoryProvider.of<PollStarRepository>(context),
          ),
        ),
      ],
      child: BlocListener<UserInfoBloc, UserInfoState>(
        listener: (context, state) {
          if (state is UserInfoSuccess) {
          } else if (state is UserInfoError) {
            AppUtils().showAlertDialog(
              context,
              title: AppStrings.error,
              content: state.error,
            );
          } else if (state is UserLogoutLoading) {
            loadingOverlay.show(context);
          } else if (state is UserLogoutSuccess) {
            loadingOverlay.hide();
            Navigator.pop(context);
            AppUtils().clearData();
            AppUtils().pageRouteUntilClearStack(context, const LoginScreen());
          }
        },
        child: Scaffold(
          appBar: AppBarWidget(user: user),
          drawer: DrawerWidget(user: user),
          body: const TabWidget(),
        ),
      ),
    );
  }
}
