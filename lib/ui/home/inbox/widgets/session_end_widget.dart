import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pollstar/ui/auth/login_screen.dart';
import 'package:pollstar/ui/widgets/buttons.dart';
import 'package:pollstar/utils/strings.dart';
import 'package:pollstar/utils/theme/colors.dart';
import 'package:pollstar/utils/theme/styles.dart';
import 'package:pollstar/utils/utils.dart';

class SessionEndWidget extends StatelessWidget {
  const SessionEndWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 64),
      child: Column(
        //mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            AppStrings.errorSession,
            textAlign: TextAlign.center,
            style: AppStyle.textStyleMedium.copyWith(
              color: AppColors.textColorLightDark,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          MyTextButton(
            text: AppStrings.goToLogin,
            onPressed: () {
              AppUtils().clearData();
              AppUtils().pageRouteUntilClearStack(context, const LoginScreen());
            },
          )
        ],
      ),
    );
  }
}
