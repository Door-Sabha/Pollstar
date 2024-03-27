import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pollstar/data/di/service_locator.dart';
import 'package:pollstar/ui/auth/bloc/otp_request_bloc.dart';
import 'package:pollstar/ui/auth/bloc/otp_verification_bloc.dart';
import 'package:pollstar/ui/home/bloc/user_info_bloc.dart';
import 'package:pollstar/ui/home/home_screen.dart';
import 'package:pollstar/ui/widgets/buttons.dart';
import 'package:pollstar/ui/widgets/loading_overlay.dart';
import 'package:pollstar/ui/widgets/otp_field/otp_field.dart';
import 'package:pollstar/ui/widgets/otp_field/otp_field_style.dart';
import 'package:pollstar/ui/widgets/otp_field/style.dart';
import 'package:pollstar/utils/analytics_manager.dart';
import 'package:pollstar/utils/extensions.dart';
import 'package:pollstar/utils/strings.dart';
import 'package:pollstar/utils/theme/colors.dart';
import 'package:pollstar/utils/theme/styles.dart';
import 'package:pollstar/utils/utils.dart';
import 'package:sms_autofill/sms_autofill.dart';
import 'package:sprintf/sprintf.dart';
import 'package:timer_count_down/timer_controller.dart';
import 'package:timer_count_down/timer_count_down.dart';

class OTPVerificationScreen extends StatefulWidget {
  const OTPVerificationScreen({super.key, required this.phone});
  final String phone;

  @override
  State<OTPVerificationScreen> createState() => _OTPVerificationScreenState();
}

class _OTPVerificationScreenState extends State<OTPVerificationScreen>
    with CodeAutoFill {
  final OtpFieldController otpController = OtpFieldController();

  final CountdownController countdownController =
      CountdownController(autoStart: true);

  @override
  void initState() {
    _initSmsAutoFill();

    super.initState();
  }

  @override
  void dispose() {
    _disposeSmsAutoFill();
    super.dispose();
  }

  _initSmsAutoFill() async {
    listenForCode();
    //SmsAutoFill().getAppSignature.then((value) => print("Signature $value"));
  }

  _disposeSmsAutoFill() async {
    cancel();
    unregisterListener();
  }

  @override
  void codeUpdated() {
    if (code != null) {
      var pin = code!.iterable();
      otpController.set(pin.toList());
    }
  }

  @override
  Widget build(BuildContext context) {
    final LoadingOverlay loadingOverlay = LoadingOverlay();
    getIt<AnalyticsManager>()
        .logScreenView(name: AppStrings().faScreenOtpVerification);
    return MultiBlocListener(
      listeners: [
        BlocListener<OtpRequestBloc, OtpRequestState>(
          listener: (context, state) {
            if (state is OtpRequestLoadingState) {
              AppUtils().hideKeyboard();
              loadingOverlay.show(context);
            } else if (state is OtpRequestErrorState) {
              loadingOverlay.hide();
              AppUtils().showAlertDialog(
                context,
                title: AppStrings.error,
                content: state.error,
              );
            } else if (state is OtpRequestSuccessState) {
              loadingOverlay.hide();
              AppUtils().showSnackBar(
                  context, state.data.message ?? AppStrings.errorApiUnknown);
              countdownController.restart();
              context.read<OtpVerificationBloc>().add(const UpdateCountdown());
            }
          },
        ),
        BlocListener<OtpVerificationBloc, OtpVerificationState>(
          listener: (context, state) {
            if (state is OtpVerificationLoadingState) {
              AppUtils().hideKeyboard();
              loadingOverlay.show(context);
            } else if (state is OtpVerificationErrorState) {
              loadingOverlay.hide();
              AppUtils().showAlertDialog(
                context,
                title: AppStrings.error,
                content: state.error,
              );
              otpController.clear();
            } else if (state is OtpVerificationSuccessState) {
              loadingOverlay.hide();
              // AppUtils().showSnackBar(
              //     context, state.data.message ?? AppStrings.errorApiUnknown);
              context.read<UserInfoBloc>().add(const GetUserInfo());
            }
          },
        ),
        BlocListener<UserInfoBloc, UserInfoState>(
          listener: (context, state) {
            if (state is UserInfoLoading) {
              loadingOverlay.show(context);
            } else if (state is UserInfoError) {
              loadingOverlay.hide();
              AppUtils().showAlertDialog(
                context,
                title: AppStrings.error,
                content: state.error,
              );
            } else if (state is UserInfoSuccess) {
              loadingOverlay.hide();
              AppUtils().pageRouteUntilClearStack(
                  context, HomeScreen(user: state.user));
            }
          },
        ),
      ],
      child: Scaffold(
        body: GestureDetector(
          onTap: () => AppUtils().hideKeyboard(),
          child: Container(
            decoration: AppStyle.bgGradient,
            child: SafeArea(
              child: _content(context),
            ),
          ),
        ),
      ),
    );
  }

  Widget _content(BuildContext context) {
    return Column(
      children: [
        _appbar(),
        _titleMessageWidget(),
        _otpWidget(context),
        _resendCodeWidget(context),
        _continueWidget(context),
      ],
    );
  }

  Widget _appbar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      title: const Text(AppStrings.otpVerificationTitle),
      centerTitle: true,
    );
  }

  Widget _titleMessageWidget() {
    return Padding(
      padding: const EdgeInsets.only(top: 32, left: 32, right: 32),
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
            text: AppStrings.otpVerificationMsg,
            style: AppStyle.textStyleMedium.copyWith(
              color: Colors.white,
              height: 1.5,
            ),
            children: [
              TextSpan(
                text: "\n${widget.phone}\n",
                style: AppStyle.textStyleMedium.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  height: 1.5,
                ),
              ),
              TextSpan(
                text: AppStrings.otpVerificationMsg2,
                style: AppStyle.textStyleMedium.copyWith(
                  color: Colors.white,
                  height: 1.5,
                ),
              ),
            ]),
      ),
    );
  }

  Widget _otpWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 32, bottom: 8, left: 32, right: 32),
      child: OTPTextField(
        controller: otpController,
        length: 4,
        width: double.infinity,
        fieldWidth: 40,
        style: AppStyle.textStyleTitle,
        textFieldAlignment: MainAxisAlignment.spaceEvenly,
        fieldStyle: FieldStyle.box,
        outlineBorderRadius: 4,
        keyboardType: TextInputType.number,
        otpFieldStyle: OtpFieldStyle(
            borderColor: AppColors.greenColor,
            enabledBorderColor: AppColors.greenColor,
            focusBorderColor: AppColors.greenColor,
            backgroundColor: Colors.white),
        onChanged: (value) {},
        onCompleted: (pin) {
          // countdownController.pause();
          // context.read<OtpVerificationBloc>().add(const UpdateCountdown());
        },
      ),
    );
  }

  Widget _resendCodeWidget(BuildContext context) {
    return BlocBuilder<OtpVerificationBloc, OtpVerificationState>(
      buildWhen: (previous, current) => current is CountdownState,
      builder: (context, state) {
        if (countdownController.isCompleted ?? false) {
          return MyTextButton(
            text: AppStrings.otpResendBtn,
            textColor: Colors.white,
            isFullWidth: false,
            onPressed: () => context.read<OtpRequestBloc>().add(
                  RequestOtp(phone: widget.phone),
                ),
          );
        } else {
          return Countdown(
            seconds: AppStrings.resendOtpTime,
            interval: const Duration(seconds: 1),
            controller: countdownController,
            build: (BuildContext context, double time) => MyTextButton(
              textColor: Colors.white,
              isFullWidth: false,
              text: sprintf(
                  (time == 0)
                      ? AppStrings.otpResendMessage1
                      : AppStrings.otpResendMessage2,
                  [time.toInt() + 1]).toString(),
              onPressed: () {},
            ),
            onFinished: () {
              context.read<OtpVerificationBloc>().add(const UpdateCountdown());
            },
          );
        }
      },
    );
  }

  Widget _continueWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: MyElevatedButton(
        text: AppStrings.otpConfirmBtn,
        isFullWidth: false,
        backgroundColor: Colors.white,
        textColor: AppColors.greenColor,
        onPressed: () => context.read<OtpVerificationBloc>().add(
              VerifyOtp(phone: widget.phone, otp: otpController.pin),
            ),
      ),
    );
  }
}
