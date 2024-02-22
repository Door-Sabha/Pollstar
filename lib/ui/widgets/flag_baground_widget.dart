import 'package:flutter/material.dart';

class FlagBackgroundWidget extends StatelessWidget {
  const FlagBackgroundWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Flexible(
          flex: 3,
          child: Container(
            color: Colors.amber.withOpacity(.5),
          ),
        ),
        Flexible(
          flex: 4,
          child: Container(),
        ),
        Flexible(
          flex: 3,
          child: Container(
            color: Colors.green.withOpacity(.5),
          ),
        ),
      ],
    );
  }
}
