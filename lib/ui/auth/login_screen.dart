import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pollstar/ui/auth/bloc/otp_request_bloc.dart';
import 'package:pollstar/ui/auth/otp_verification_screen.dart';
import 'package:pollstar/ui/auth/widgets/login_widget.dart';
import 'package:pollstar/ui/widgets/loading_overlay.dart';
import 'package:pollstar/utils/strings.dart';
import 'package:pollstar/utils/utils.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final LoadingOverlay loadingOverlay = LoadingOverlay();
    return Scaffold(
      body: BlocListener<OtpRequestBloc, OtpRequestState>(
        listener: (context, state) {
          if (state is OtpRequestLoadingState) {
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
            AppUtils().pageRoute(
                context,
                OTPVerificationScreen(
                  user: state.user,
                ));
          }
        },
        child: LoginWidget(),
      ),
    );
  }
}