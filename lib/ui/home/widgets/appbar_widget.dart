import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pollstar/ui/widgets/images.dart';
import 'package:pollstar/utils/theme/styles.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  const AppBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: const MyImage(
        image: "ec_logo",
      ),
      iconTheme: const IconThemeData(color: Colors.white),
      actions: [
        IconButton(
          icon: const Icon(
            Icons.perm_phone_msg_outlined,
            color: Colors.white,
          ),
          onPressed: () {},
        ),
      ],
      flexibleSpace: Container(
        decoration: AppStyle.bgGradient,
      ),
      systemOverlayStyle: SystemUiOverlayStyle.light,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
