import 'package:flutter/material.dart';
import 'package:pollstar/utils/theme/styles.dart';

class SplashWidget extends StatelessWidget {
  const SplashWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: AppStyle.bgFlag,
    );
  }
}
