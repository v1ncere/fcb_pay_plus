import 'package:flutter/material.dart';

class SegmentedProgressIndicator extends StatelessWidget {
  final int totalSteps;
  final int completedSteps;
  final double height;
  final double gap; // gap between segments
  final Color backgroundColor;
  final Color activeColor;
  final BorderRadius borderRadius;

  const SegmentedProgressIndicator({
    super.key,
    required this.totalSteps,
    required this.completedSteps,
    this.height = 8.0,
    this.gap = 4.0,
    this.backgroundColor = Colors.grey,
    this.activeColor = Colors.blue,
    this.borderRadius = const BorderRadius.all(Radius.circular(4.0)),
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(totalSteps, (index) {
        final isActive = index < completedSteps;
        return Expanded(
          child: Container(
            margin: EdgeInsets.only(
              left: index == 0 ? 0 : gap / 2,
              right: index == totalSteps - 1 ? 0 : gap / 2,
            ),
            height: height,
            decoration: BoxDecoration(
              color: isActive ? activeColor : backgroundColor,
              borderRadius: borderRadius,
            ),
          ),
        );
      }),
    );
  }
}
