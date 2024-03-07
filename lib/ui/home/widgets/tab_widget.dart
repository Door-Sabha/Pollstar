import 'package:flutter/material.dart';
import 'package:pollstar/ui/home/inbox/inbox_screen.dart';
import 'package:pollstar/ui/home/outbox/outbox_screen.dart';
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
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print("tab widget called");
    return Container(
      decoration: AppStyle().bgLogo,
      child: SafeArea(
        child: Column(
          children: [
            TabBar(
              tabs: const [
                SizedBox(
                  height: 56,
                  child: Tab(
                    text: AppStrings.inbox,
                  ),
                ),
                SizedBox(
                  height: 56,
                  child: Tab(
                    text: AppStrings.outbox,
                  ),
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
                children: [
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
