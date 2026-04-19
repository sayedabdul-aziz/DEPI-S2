import 'package:flutter/material.dart';

class ShimmerListView extends StatelessWidget {
  const ShimmerListView({
    super.key,
    required this.itemBuilder,
    this.itemCount = 5,
    this.scrollDirection = Axis.vertical,
    this.padding,
    this.separatorHeight = 10,
  });

  final Widget Function(BuildContext context, int index) itemBuilder;
  final int itemCount;
  final Axis scrollDirection;
  final EdgeInsetsGeometry? padding;
  final double separatorHeight;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      scrollDirection: scrollDirection,
      padding: padding,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: itemCount,
      separatorBuilder: (context, index) => SizedBox(
        height: scrollDirection == Axis.vertical ? separatorHeight : 0,
        width: scrollDirection == Axis.horizontal ? separatorHeight : 0,
      ),
      itemBuilder: itemBuilder,
    );
  }
}
