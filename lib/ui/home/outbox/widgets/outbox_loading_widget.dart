import 'package:flutter/material.dart';
import 'package:pollstar/ui/home/widgets/shimmer_widget.dart';

class OutboxLoadingWidget extends StatelessWidget {
  const OutboxLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return _shimmerListWidget(context);
  }
}

Widget _shimmerListWidget(BuildContext context) {
  return ListView.builder(
    itemCount: 5,
    padding: const EdgeInsets.symmetric(horizontal: 16),
    physics: const NeverScrollableScrollPhysics(),
    itemBuilder: (context, index) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              _logoWidget(),
              _questionWidget(),
            ],
          ),
          Row(
            children: [
              _answerWidget(),
              _logoWidget(),
            ],
          ),
        ],
      );
    },
  );
}

Widget _logoWidget() {
  return const Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      ShimmerWidget.circle(
        size: 48,
      ),
      SizedBox(height: 4),
      ShimmerWidget.rectangle(
        height: 16,
        width: 56,
        roundCorner: 4,
      ),
    ],
  );
}

Widget _questionWidget() {
  return Flexible(
    child: Container(
      padding: const EdgeInsets.only(left: 16, top: 16, bottom: 8),
      child: const ShimmerWidget.rectangle(
        height: 72,
        roundCorner: 16,
      ),
    ),
  );
}

Widget _answerWidget() {
  return Flexible(
    child: Container(
      alignment: Alignment.centerRight,
      padding: const EdgeInsets.only(right: 16),
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: const ShimmerWidget.rectangle(
        height: 36,
        width: 120,
        roundCorner: 8,
      ),
    ),
  );
}
