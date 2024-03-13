import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerWidget extends StatelessWidget {
  final double height;
  final double width;
  final double size;
  final double roundCorner;
  final bool isRectangle;

  const ShimmerWidget.rectangle({
    super.key,
    this.height = double.infinity,
    this.width = double.infinity,
    this.roundCorner = 0,
  })  : isRectangle = true,
        size = 0;

  const ShimmerWidget.circle({
    super.key,
    required this.size,
  })  : roundCorner = 0,
        height = 0,
        width = 0,
        isRectangle = false;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[400]!,
      highlightColor: Colors.grey[300]!,
      period: const Duration(seconds: 3),
      child: Container(
        width: (isRectangle) ? width : size,
        height: (isRectangle) ? height : size,
        decoration: BoxDecoration(
          color: Colors.grey,
          border: Border.all(),
          borderRadius: BorderRadius.all(
            (isRectangle)
                ? Radius.circular((roundCorner))
                : Radius.circular((size / 2)),
          ),
        ),
      ),
    );
  }
}
