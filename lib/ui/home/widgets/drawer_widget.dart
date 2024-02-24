import 'package:flutter/material.dart';
import 'package:pollstar/ui/help/help_screen.dart';
import 'package:pollstar/utils/theme/colors.dart';
import 'package:pollstar/utils/theme/styles.dart';
import 'package:pollstar/utils/utils.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              color: AppColors.greenColor,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "9994216702",
                  textAlign: TextAlign.center,
                  style: AppStyle.textStyleTitle.copyWith(color: Colors.white),
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(
              Icons.perm_phone_msg_outlined,
            ),
            title: const Text(
              'Help',
              style: AppStyle.textStyleMedium,
            ),
            onTap: () => _helpClicked(context),
          ),
          ListTile(
            leading: const Icon(
              Icons.perm_phone_msg_outlined,
            ),
            title: const Text(
              'Web',
              style: AppStyle.textStyleMedium,
            ),
            onTap: () => _helpClicked(context),
          ),
        ],
      ),
    );
  }

  _helpClicked(BuildContext context) {
    Navigator.pop(context);
    AppUtils().pageRoute(context, const HelpScreen());
  }
}
