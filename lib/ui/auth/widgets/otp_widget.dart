import 'package:flutter/material.dart';
import 'package:pollstar/ui/widgets/textfields.dart';

class OTPWidget extends StatelessWidget {
  const OTPWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        MyOtpTextField(),
        MyOtpTextField(),
        MyOtpTextField(),
        MyOtpTextField(),
      ],
    );
  }
}
