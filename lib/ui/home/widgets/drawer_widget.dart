import 'package:flutter/material.dart';
import 'package:pollstar/data/di/service_locator.dart';
import 'package:pollstar/data/models/user.dart';
import 'package:pollstar/ui/help/help_screen.dart';
import 'package:pollstar/ui/widgets/buttons.dart';
import 'package:pollstar/utils/app_constants.dart';
import 'package:pollstar/utils/strings.dart';
import 'package:pollstar/utils/theme/colors.dart';
import 'package:pollstar/utils/theme/styles.dart';
import 'package:pollstar/utils/utils.dart';

class DrawerWidget extends StatelessWidget {
  final User user;
  const DrawerWidget({super.key, required this.user});

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
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    user.userParams != null ? user.userParams!.boothName! : "",
                    textAlign: TextAlign.center,
                    style:
                        AppStyle.textStyleTitle.copyWith(color: Colors.white),
                  ),
                  Text(
                    user.userParams != null
                        ? user.userParams!.phoneNumber!
                        : "",
                    textAlign: TextAlign.center,
                    style:
                        AppStyle.textStyleMedium.copyWith(color: Colors.white),
                  ),
                  Text(
                    user.userParams != null ? user.stateInfo!.name! : "",
                    textAlign: TextAlign.center,
                    style:
                        AppStyle.textStyleMedium.copyWith(color: Colors.white),
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
            onTap: () => _helpClicked(context),
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
          Text(
            getIt<AppConstants>().versionInfo,
            style: AppStyle.textStyleSmall,
          ),
          MyElevatedButton(
            text: AppStrings.logout,
            isFullWidth: false,
            backgroundColor: AppColors.redColor,
            onPressed: () => _logout(context),
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }

  _helpClicked(BuildContext context) {
    Navigator.pop(context);
    if (user.stateInfo != null && user.stateInfo!.helpUrl != null) {
      AppUtils().openUrl(user.stateInfo!.helpUrl!);
    }
  }

  _reportProblemClicked(BuildContext context) {
    Navigator.pop(context);
    AppUtils().pageRoute(context, HelpScreen(user: user));
  }

  _logout(BuildContext context) {
    AppUtils().showLogoutDialog(context);
  }
}
