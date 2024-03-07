import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pollstar/utils/strings.dart';
import 'package:pollstar/utils/theme/colors.dart';
import 'package:pollstar/utils/theme/styles.dart';

class OutboxEmptyWidget extends StatelessWidget {
  const OutboxEmptyWidget({super.key});

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
                  AppStrings.outboxEmptyHint,
                  style: AppStyle.textStyleMedium.copyWith(
                    color: AppColors.textColorLightDark,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
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
