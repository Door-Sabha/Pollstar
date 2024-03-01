import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pollstar/data/models/user.dart';
import 'package:pollstar/ui/help/bloc/help_bloc.dart';
import 'package:pollstar/ui/help/widgets/contact_us_widget.dart';
import 'package:pollstar/ui/help/widgets/emergency_contact_list_widget.dart';
import 'package:pollstar/ui/widgets/loading_overlay.dart';
import 'package:pollstar/ui/widgets/texts.dart';
import 'package:pollstar/utils/strings.dart';
import 'package:pollstar/utils/theme/colors.dart';
import 'package:pollstar/utils/theme/styles.dart';
import 'package:pollstar/utils/utils.dart';

class HelpScreen extends StatelessWidget {
  final User user;
  const HelpScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    final LoadingOverlay loadingOverlay = LoadingOverlay();
    return BlocListener<HelpBloc, HelpState>(
      listener: (context, state) {
        if (state is HelpErrorState) {
          loadingOverlay.hide();
          AppUtils().showAlertDialog(
            context,
            title: AppStrings.error,
            content: state.error,
          );
        } else if (state is ProblemReportingLoading) {
          loadingOverlay.show(context);
        } else if (state is ProblemReportingSuccess) {
          loadingOverlay.hide();
          AppUtils().showAlertDialog(
            context,
            title: state.data.message,
            content: state.data.description,
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            AppStrings.reportProblem,
          ),
          flexibleSpace: Container(
            decoration: AppStyle.bgGradient,
          ),
        ),
        body: _contentWidget(),
      ),
    );
  }

  Widget _contentWidget() {
    return GestureDetector(
      onTap: () => AppUtils().hideKeyboard(),
      child: SingleChildScrollView(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 16),
                child: Icon(
                  Icons.perm_phone_msg_rounded,
                  color: AppColors.greenColor,
                  size: 56,
                ),
              ),
              const MyUnderlineText(
                text: AppStrings.emergencyMsg,
                style: AppStyle.textStyleTitle,
                underlineColor: AppColors.orangeColor,
              ),
              EmergencyContactListWidget(
                  emergencyNumbers: user.stateInfo?.emergencyNumbers),
              const SizedBox(height: 16),
              const MyUnderlineText(
                text: AppStrings.orWriteToUs,
                style: AppStyle.textStyleTitle,
                underlineColor: AppColors.orangeColor,
              ),
              const SizedBox(height: 16),
              ContactUsWidget(reasons: user.stateInfo?.problemReasons),
            ],
          ),
        ),
      ),
    );
  }
}
