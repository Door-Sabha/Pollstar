import 'package:flutter/material.dart';
import 'package:pollstar/ui/home/widgets/shimmer_widget.dart';

class InboxLoadingWidget extends StatelessWidget {
  const InboxLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return _shimmerListWidget(context);
  }
}

Widget _shimmerListWidget(BuildContext context) {
  return ListView.builder(
    itemCount: 3,
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
          _replyWidget(),
          Row(
            children: [
              _logoWidget(),
              _questionWidget(),
            ],
          ),
          _yesNoWidget(),
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
        height: 96,
        roundCorner: 16,
      ),
    ),
  );
}

Widget _replyWidget() {
  return Container(
    alignment: Alignment.centerRight,
    margin: const EdgeInsets.symmetric(vertical: 4),
    child: const ShimmerWidget.rectangle(
      height: 48,
      width: 120,
      roundCorner: 8,
    ),
  );
}

Widget _yesNoWidget() {
  return Container(
    alignment: Alignment.centerRight,
    margin: const EdgeInsets.symmetric(vertical: 4),
    child: const Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        ShimmerWidget.rectangle(
          height: 48,
          width: 72,
          roundCorner: 8,
        ),
        SizedBox(width: 16),
        ShimmerWidget.rectangle(
          height: 48,
          width: 72,
          roundCorner: 8,
        ),
      ],
    ),
  );
}
