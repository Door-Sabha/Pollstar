import 'package:flutter/material.dart';
import 'package:pollstar/ui/help/help_screen.dart';
import 'package:pollstar/ui/widgets/images.dart';
import 'package:pollstar/utils/theme/styles.dart';
import 'package:pollstar/utils/utils.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  const AppBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: const MySvgImage(
        image: "ec_logo",
      ),
      actions: [
        IconButton(
          icon: const Icon(
            Icons.perm_phone_msg_rounded,
          ),
          onPressed: () {
            AppUtils().pageRoute(context, const HelpScreen());
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
