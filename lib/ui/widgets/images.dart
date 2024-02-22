import 'package:flutter/material.dart';

class MyImage extends StatelessWidget {
  const MyImage({
    super.key,
    required this.image,
    this.size = 48,
  });

  final String image;
  final double size;

  @override
  Widget build(BuildContext context) {
    // ignore: avoid_unnecessary_containers
    return Container(
      child: Image.asset(
        'assets/images/$image.png',
        height: size,
        width: size,
      ),
    );
  }
}
