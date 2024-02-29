import 'package:flutter/material.dart';
import 'package:pollstar/ui/help/help_screen.dart';
import 'package:pollstar/ui/widgets/buttons.dart';
import 'package:pollstar/utils/strings.dart';
import 'package:pollstar/utils/theme/colors.dart';
import 'package:pollstar/utils/theme/styles.dart';
import 'package:pollstar/utils/utils.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              color: AppColors.greenColor,
            ),
            margin: EdgeInsets.zero,
            child: SizedBox(
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "9994216702",
                    textAlign: TextAlign.center,
                    style:
                        AppStyle.textStyleTitle.copyWith(color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
          ListTile(
            leading: const Icon(
              Icons.help_center,
            ),
            title: Text(
              AppStrings.help,
              style: AppStyle.textStyleMedium.copyWith(
                fontSize: 16,
              ),
            ),
            onTap: () => _helpClicked(),
          ),
          ListTile(
            leading: const Icon(
              Icons.perm_phone_msg_rounded,
            ),
            title: Text(
              AppStrings.reportProblem,
              style: AppStyle.textStyleMedium.copyWith(
                fontSize: 16,
              ),
            ),
            onTap: () => _reportProblemClicked(context),
          ),
          const Spacer(),
          const Text(
            'v1.00',
            style: AppStyle.textStyleMedium,
          ),
          MyElevatedButton(
            text: AppStrings.logout,
            isFullWidth: false,
            backgroundColor: AppColors.redColor,
            onPressed: () => _logout(),
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }

  _helpClicked() {}

  _reportProblemClicked(BuildContext context) {
    Navigator.pop(context);
    AppUtils().pageRoute(context, const HelpScreen());
  }

  _logout() {}
}
