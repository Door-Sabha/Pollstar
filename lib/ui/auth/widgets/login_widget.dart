import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pollstar/ui/auth/bloc/otp_request_bloc.dart';
import 'package:pollstar/ui/widgets/buttons.dart';
import 'package:pollstar/ui/widgets/images.dart';
import 'package:pollstar/utils/strings.dart';
import 'package:pollstar/utils/theme/colors.dart';
import 'package:pollstar/utils/theme/styles.dart';
import 'package:pollstar/utils/utils.dart';

class LoginWidget extends StatelessWidget {
  LoginWidget({super.key});

  final TextEditingController phoneNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => AppUtils().hideKeyboard(),
      child: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/bg.png"),
            fit: BoxFit.cover,
          ),
        ),
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
        TextField(
          controller: phoneNumberController,
          maxLines: 1,
          maxLength: 10,
          buildCounter: (context,
                  {required currentLength,
                  required isFocused,
                  required maxLength}) =>
              Container(),
          keyboardType: TextInputType.phone,
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

  Widget _privacyPolicyWidget() {
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: RichText(
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
                  ..onTap = () => AppUtils().openUrl(""),
              )
            ]),
      ),
    );
  }
}
