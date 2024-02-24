import 'package:flutter/material.dart';
import 'package:pollstar/data/models/emergency_reason.dart';
import 'package:pollstar/ui/home/widgets/dropdowns.dart';
import 'package:pollstar/ui/widgets/buttons.dart';
import 'package:pollstar/utils/strings.dart';
import 'package:pollstar/utils/theme/colors.dart';

class ContactUsWidget extends StatelessWidget {
  const ContactUsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var list = [
      EmergencyReason(reason: "Booth not setup"),
      EmergencyReason(reason: "Power failuare"),
      EmergencyReason(reason: "Law and Order"),
      EmergencyReason(reason: "Violation"),
      EmergencyReason(reason: "Others"),
    ];
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Column(
        children: [
          MyDropDownButton(
            hint: AppStrings.natureOfProblem,
            list: list,
          ),
          const SizedBox(height: 16),
          const TextField(
            keyboardType: TextInputType.multiline,
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: AppColors.greenColor,
                  width: 2,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: AppColors.greenColor,
                  width: 2,
                ),
              ),
              labelText: AppStrings.additionalInformation,
              labelStyle: TextStyle(color: AppColors.textColorDark),
              alignLabelWithHint: true,
            ),
            minLines: 5,
            maxLines: 5,
          ),
          const SizedBox(height: 32),
          MyElevatedButton(
            text: AppStrings.submit,
            onPressed: () {},
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }
}
