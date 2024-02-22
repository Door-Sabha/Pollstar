import 'package:flutter/material.dart';
import 'package:pollstar/ui/auth/widgets/otp_widget.dart';
import 'package:pollstar/ui/home/home_screen.dart';
import 'package:pollstar/ui/widgets/buttons.dart';
import 'package:pollstar/utils/strings.dart';
import 'package:pollstar/utils/theme/colors.dart';
import 'package:pollstar/utils/theme/styles.dart';
import 'package:pollstar/utils/utils.dart';
import 'package:sprintf/sprintf.dart';

class OTPVerificationScreen extends StatelessWidget {
  const OTPVerificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: AppStyle.bgGradient,
        child: SafeArea(
          child: _content(context),
        ),
      ),
    );
  }

  Widget _content(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Column(
        children: [
          Text(
            AppStrings.otpVerificationTitle,
            style: AppStyle.textStyleTitle.copyWith(
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 32),
          Text(
            sprintf(AppStrings.otpVerificationMsg, ["9994216702"]),
            style: AppStyle.textStyleMedium.copyWith(
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          const OTPWidget(),
          const SizedBox(height: 16),
          MyTextButton(
            text: AppStrings.otpResendBtn,
            textColor: Colors.white,
            isFullWidth: false,
            onPressed: () {},
          ),
          const SizedBox(height: 16),
          MyElevatedButton(
            text: AppStrings.otpConfirmBtn,
            isFullWidth: false,
            backgroundColor: Colors.white,
            textColor: AppColors.greenColor,
            onPressed: () {
              AppUtils().pageRouteReplacement(context, HomeScreen());
            },
          )
        ],
      ),
    );
  }
}
