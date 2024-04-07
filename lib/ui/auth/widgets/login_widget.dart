import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pollstar/data/di/service_locator.dart';
import 'package:pollstar/ui/auth/bloc/otp_request_bloc.dart';
import 'package:pollstar/ui/widgets/buttons.dart';
import 'package:pollstar/ui/widgets/images.dart';
import 'package:pollstar/utils/app_constants.dart';
import 'package:pollstar/utils/strings.dart';
import 'package:pollstar/utils/theme/colors.dart';
import 'package:pollstar/utils/theme/styles.dart';
import 'package:pollstar/utils/utils.dart';
import 'package:sms_autofill/sms_autofill.dart';

class LoginWidget extends StatelessWidget {
  LoginWidget({super.key});

  final TextEditingController phoneNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => AppUtils().hideKeyboard(),
      child: Container(
        decoration: AppStyle.bgFlag,
        child: SafeArea(
          child: Column(
            children: [
              _logoWidget(),
              _phoneNumberWidget(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _logoWidget() {
    return const Flexible(
      flex: 3,
      child: MyImage(
        image: "app_logo",
        size: double.infinity,
      ),
    );
  }

  Widget _phoneNumberWidget(BuildContext context) {
    return Flexible(
      flex: 7,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _titleWidget(),
            _textFieldWidget(),
            _buttonWidget(context),
            _privacyPolicyWidget(),
            const Spacer(),
            _versionWidget(),
          ],
        ),
      ),
    );
  }

  Widget _titleWidget() {
    return const Column(
      children: [
        // Text(
        //   AppStrings.loginTitle,
        //   style: AppStyle.textStyleTitle.copyWith(fontSize: 28),
        // ),
        SizedBox(height: 16),
        Text(
          AppStrings.loginMsg,
          style: AppStyle.textStyleMedium,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _textFieldWidget() {
    return Column(
      children: [
        const SizedBox(height: 16),
        // if (Platform.isAndroid)
        //   PhoneFieldHint(
        //     controller: phoneNumberController,
        //     decoration: const InputDecoration(
        //       labelText: AppStrings.loginHint,
        //     ),
        //   )
        // else
        TextField(
          controller: phoneNumberController,
          maxLines: 1,
          maxLength: 10,
          buildCounter: (context,
                  {required currentLength,
                  required isFocused,
                  required maxLength}) =>
              Container(),
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
            labelText: AppStrings.loginHint,
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buttonWidget(BuildContext context) {
    return MyElevatedButton(
      text: AppStrings.loginBtnTxt,
      isFullWidth: false,
      onPressed: () {
        context.read<OtpRequestBloc>().add(
              RequestOtp(phone: phoneNumberController.text),
            );
      },
    );
  }

  Widget _versionWidget() {
    return GestureDetector(
      onLongPress: () {
        SmsAutoFill().getAppSignature.then(
              (value) => AppUtils().copyToClipboard(value),
            );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Text(
          getIt<AppConstants>().versionInfo,
          style: AppStyle.textStyleSmall,
        ),
      ),
    );
  }

  Widget _supportWidget() {
    return Align(
      alignment: Alignment.centerRight,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 0),
        child: MyTextButton(
          text: AppStrings.support,
          isFullWidth: false,
          onPressed: () {},
        ),
      ),
    );
  }

  Widget _privacyPolicyWidget() {
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
            text: AppStrings.loginPrivacyPolicyHeading,
            style: AppStyle.textStyleSmall,
            children: [
              TextSpan(
                text: AppStrings.privacyPolicy,
                style: AppStyle.textStyleSmall.copyWith(
                  color: AppColors.greenColor,
                  decoration: TextDecoration.underline,
                  fontWeight: FontWeight.bold,
                ),
                recognizer: TapGestureRecognizer()
                  ..onTap =
                      () => AppUtils().openUrl(AppStrings.urlPrivacyPolicy),
              )
            ]),
      ),
    );
  }
}
