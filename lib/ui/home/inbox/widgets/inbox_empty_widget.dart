import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pollstar/data/di/service_locator.dart';
import 'package:pollstar/utils/app_constants.dart';
import 'package:pollstar/utils/strings.dart';
import 'package:pollstar/utils/theme/colors.dart';
import 'package:pollstar/utils/theme/styles.dart';
import 'package:pollstar/utils/utils.dart';
import 'package:sprintf/sprintf.dart';

class InboxEmptyWidget extends StatelessWidget {
  const InboxEmptyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverFillRemaining(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
                child: Text(
                  AppStrings.inboxEmptyHint,
                  style: AppStyle.textStyleMedium.copyWith(
                    color: AppColors.textColorLightDark,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.only(bottom: 32, left: 16, right: 16),
                child: Text(
                  sprintf(AppStrings.lastUpdatedToday, [
                    AppUtils().getTimeFromMilliseconds(
                        getIt<AppConstants>().lastRefreshTime)
                  ]),
                  style: AppStyle.textStyleMedium.copyWith(
                    color: AppColors.textHintColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
