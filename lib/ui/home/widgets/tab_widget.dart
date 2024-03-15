import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pollstar/data/di/service_locator.dart';
import 'package:pollstar/ui/home/bloc/questions_bloc.dart';
import 'package:pollstar/ui/home/inbox/inbox_screen.dart';
import 'package:pollstar/ui/home/outbox/outbox_screen.dart';
import 'package:pollstar/utils/app_constants.dart';
import 'package:pollstar/utils/strings.dart';
import 'package:pollstar/utils/theme/colors.dart';
import 'package:pollstar/utils/theme/styles.dart';

class TabWidget extends StatefulWidget {
  const TabWidget({super.key});

  @override
  State<TabWidget> createState() => _TabWidgetState();
}

class _TabWidgetState extends State<TabWidget>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      _refreshQuestionsList();
    });
  }

  _refreshQuestionsList() {
    if (_tabController.index == 0) {
      final diff = DateTime.now()
          .difference(DateTime.fromMillisecondsSinceEpoch(
              getIt<AppConstants>().lastRefreshOnTabSwitch))
          .inSeconds;
      if (diff >= 10) {
        context.read<QuestionListBloc>().add(const GetQuestionsList());
        getIt<AppConstants>().lastRefreshOnTabSwitch =
            DateTime.now().millisecondsSinceEpoch;
      }
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: AppStyle().bgLogo,
      child: SafeArea(
        child: Column(
          children: [
            TabBar(
              tabs: const [
                Tab(
                  text: AppStrings.inbox,
                ),
                Tab(
                  text: AppStrings.outbox,
                ),
              ],
              controller: _tabController,
              indicatorSize: TabBarIndicatorSize.tab,
              indicatorColor: AppColors.orangeColor,
              indicatorWeight: 3,
              dividerColor: Colors.transparent,
              labelStyle: AppStyle.textStyleTitle.copyWith(fontSize: 16),
              unselectedLabelStyle: AppStyle.textStyleTitle.copyWith(
                fontSize: 16,
                color: AppColors.textHintColor,
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: const [
                  InboxScreen(),
                  OutboxScreen(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
