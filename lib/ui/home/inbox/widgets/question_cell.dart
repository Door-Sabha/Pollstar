import 'package:flutter/material.dart';
import 'package:pollstar/ui/widgets/buttons.dart';
import 'package:pollstar/ui/widgets/images.dart';
import 'package:pollstar/utils/strings.dart';
import 'package:pollstar/utils/theme/colors.dart';
import 'package:pollstar/utils/theme/styles.dart';

class QuestionWidget extends StatelessWidget {
  const QuestionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      child: Column(
        children: [
          Row(
            children: [
              _logoWidget(),
              _questionWidget(),
            ],
          ),
          _replyWidget(),
          _yesNoWidget(),
        ],
      ),
    );
  }

  Widget _logoWidget() {
    const double radius = 32;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const CircleAvatar(
          backgroundColor: AppColors.textColorDisabled,
          radius: radius,
          child: MyImage(
            image: "app_logo",
            size: radius * 2,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          "11:21 am",
          style: AppStyle.textStyleMedium.copyWith(
            color: Colors.grey,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _questionWidget() {
    return Flexible(
      child: Container(
        decoration: AppStyle.questionBox,
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.only(left: 16),
        child: ConstrainedBox(
          constraints: const BoxConstraints(minHeight: 56),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "How many votes were cast by 11:00 am?",
              style: AppStyle.textStyleMedium.copyWith(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _replyWidget() {
    return Container(
      alignment: Alignment.centerRight,
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: MyElevatedIconButton(
        icon: Icons.reply_rounded,
        onPressed: () {},
      ),
    );
  }

  Widget _yesNoWidget() {
    return Container(
      alignment: Alignment.centerRight,
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          MyElevatedButton(
            isFullWidth: false,
            text: AppStrings.yes,
            onPressed: () {},
          ),
          const SizedBox(width: 16),
          MyElevatedButton(
            isFullWidth: false,
            text: AppStrings.no,
            backgroundColor: AppColors.redColor,
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
