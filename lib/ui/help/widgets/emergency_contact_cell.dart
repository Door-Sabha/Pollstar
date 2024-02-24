import 'package:flutter/material.dart';
import 'package:pollstar/utils/theme/colors.dart';
import 'package:pollstar/utils/theme/styles.dart';
import 'package:pollstar/utils/utils.dart';

class EmergencyContactCellWidget extends StatelessWidget {
  const EmergencyContactCellWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.call_rounded,
            color: AppColors.greenColor,
          ),
          const SizedBox(width: 8),
          Text(
            "9994216702",
            style: AppStyle.textStyleTitle.copyWith(
              color: AppColors.greenColor,
            ),
          ),
        ],
      ),
      dense: true,
      onTap: () => AppUtils().makeCall(""),
    );
  }
}
