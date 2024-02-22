import 'package:flutter/material.dart';
import 'package:pollstar/ui/auth/otp_verification_screen.dart';
import 'package:pollstar/ui/widgets/buttons.dart';
import 'package:pollstar/ui/widgets/textfields.dart';
import 'package:pollstar/utils/strings.dart';
import 'package:pollstar/utils/theme/styles.dart';
import 'package:pollstar/utils/utils.dart';

class LoginWidget extends StatelessWidget {
  const LoginWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            AppStrings.loginTitle,
            style: AppStyle.textStyleTitle,
          ),
          const SizedBox(height: 16),
          const MyTextField(
            hintText: AppStrings.loginHint,
            maxLength: 10,
            keyboardType: TextInputType.phone,
          ),
          const SizedBox(height: 16),
          MyElevatedButton(
            text: AppStrings.loginBtnTxt,
            isFullWidth: false,
            onPressed: () {
              AppUtils()
                  .pageRouteReplacement(context, const OTPVerificationScreen());
            },
          )
        ],
      ),
    );
  }
}
