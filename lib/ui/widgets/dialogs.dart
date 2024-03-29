import 'package:flutter/material.dart';

import '../../utils/theme/styles.dart';
import 'buttons.dart';

class MyAlertDialog extends StatelessWidget {
  final String? title;
  final String? content;
  final String? okayBtn;
  final String? cancelBtn;
  final Function? onOkayPressed;
  final Function? onCancelPressed;
  final bool isCancellable;

  const MyAlertDialog({
    super.key,
    this.title,
    this.content,
    this.okayBtn,
    this.cancelBtn,
    this.onOkayPressed,
    this.onCancelPressed,
    this.isCancellable = true,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (title != null)
              Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: Text(title!,
                    style: AppStyle.textStyleTitle.copyWith(fontSize: 16)),
              ),
            if (content != null)
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Text(
                  content!,
                  style: AppStyle.textStyleMedium,
                  textAlign: TextAlign.center,
                ),
              ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                if (cancelBtn != null)
                  MyTextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      onCancelPressed?.call();
                    },
                    isFullWidth: false,
                    text: cancelBtn!.toUpperCase(),
                  ),
                MyTextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    onOkayPressed?.call();
                  },
                  isFullWidth: false,
                  text: okayBtn ?? "Okay".toUpperCase(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
