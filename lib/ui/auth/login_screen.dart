import 'package:flutter/material.dart';
import 'package:pollstar/ui/auth/widgets/login_widget.dart';
import 'package:pollstar/ui/widgets/flag_baground_widget.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _content(),
    );
  }

  Widget _content() {
    return const Stack(
      children: [
        FlagBackgroundWidget(),
        LoginWidget(),
      ],
    );
  }
}
