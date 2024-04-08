import 'package:flutter/material.dart';
import 'package:pollstar/data/models/user.dart';
import 'package:pollstar/ui/help/help_screen.dart';
import 'package:pollstar/utils/theme/styles.dart';
import 'package:pollstar/utils/utils.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final User user;
  const AppBarWidget({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: Image.asset(
        'assets/images/dsnl_logo1.png',
        height: 36,
      ),
      actions: [
        IconButton(
          icon: const Icon(
            Icons.perm_phone_msg_rounded,
          ),
          onPressed: () {
            AppUtils().pageRoute(context, HelpScreen(user: user));
          },
        ),
      ],
      flexibleSpace: Container(
        decoration: AppStyle.bgGradient,
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
