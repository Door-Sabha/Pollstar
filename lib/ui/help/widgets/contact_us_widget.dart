// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pollstar/data/models/emergency_reason.dart';
import 'package:pollstar/ui/help/bloc/help_bloc.dart';
import 'package:pollstar/ui/widgets/dropdowns.dart';
import 'package:pollstar/ui/widgets/buttons.dart';
import 'package:pollstar/utils/extensions.dart';
import 'package:pollstar/utils/strings.dart';

class ContactUsWidget extends StatelessWidget {
  final List<String>? reasons;
  List<EmergencyReason> list = [];
  MyDropDownButtonItem reasonItem = MyDropDownButtonItem();
  final TextEditingController textEditingController = TextEditingController();
  ContactUsWidget({super.key, required this.reasons});

  @override
  Widget build(BuildContext context) {
    if (reasons != null && reasons!.isNotEmpty) {
      for (int i = 0; i < reasons!.length; i++) {
        var e = reasons![i];
        if (!e.isNullOrEmpty()) {
          list.add(
              EmergencyReason(reason: e, type: (list.length + 1).toString()));
        }
      }
    }

    return BlocListener<HelpBloc, HelpState>(
      listener: (context, state) {
        if (state is ProblemReportingSuccess) {
          textEditingController.clear();
          reasonItem = MyDropDownButtonItem();
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          children: [
            BlocBuilder<HelpBloc, HelpState>(
              buildWhen: (previous, current) =>
                  current is ProblemReportingSuccess,
              builder: (context, state) {
                return MyDropDownButton(
                  hint: AppStrings.natureOfProblem,
                  list: list,
                  selectedItem: reasonItem,
                  onChanged: (value) {
                    reasonItem = value;
                  },
                );
              },
            ),
            const SizedBox(height: 16),
            TextField(
              controller: textEditingController,
              keyboardType: TextInputType.multiline,
              textCapitalization: TextCapitalization.sentences,
              decoration: const InputDecoration(
                labelText: AppStrings.additionalInformation,
                alignLabelWithHint: true,
              ),
              minLines: 5,
              maxLines: 5,
            ),
            const SizedBox(height: 32),
            MyElevatedButton(
              text: AppStrings.submit,
              onPressed: () => _submitEmergencyReason(context),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  _submitEmergencyReason(BuildContext context) {
    context.read<HelpBloc>().add(
          ReportProblem(
              type: reasonItem.getType(),
              message: textEditingController.text.trim()),
        );
  }
}
