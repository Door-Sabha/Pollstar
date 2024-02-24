import 'package:flutter/material.dart';
import 'package:pollstar/ui/help/widgets/contact_us_widget.dart';
import 'package:pollstar/ui/help/widgets/emergency_contact_list_widget.dart';
import 'package:pollstar/ui/widgets/texts.dart';
import 'package:pollstar/utils/strings.dart';
import 'package:pollstar/utils/theme/colors.dart';
import 'package:pollstar/utils/theme/styles.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
    );
  }

  Widget _contentWidget() {
    return const SingleChildScrollView(
      child: SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16),
              child: Icon(
                Icons.perm_phone_msg_rounded,
                color: AppColors.greenColor,
                size: 56,
              ),
            ),
            MyUnderlineText(
              text: AppStrings.emergencyMsg,
              style: AppStyle.textStyleTitle,
              underlineColor: AppColors.orangeColor,
            ),
            EmergencyContactListWidget(),
            SizedBox(height: 16),
            MyUnderlineText(
              text: AppStrings.orWriteToUs,
              style: AppStyle.textStyleTitle,
              underlineColor: AppColors.orangeColor,
            ),
            SizedBox(height: 16),
            ContactUsWidget(),
          ],
        ),
      ),
    );
  }
}
