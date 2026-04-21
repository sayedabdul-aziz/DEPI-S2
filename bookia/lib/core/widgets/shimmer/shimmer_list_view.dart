import 'package:bookia/core/widgets/shimmer/shimmer_text.dart';
import 'package:flutter/material.dart';

class ShimmerListView extends StatelessWidget {
  const ShimmerListView({
    super.key,
    this.itemCount = 5,
    this.scrollDirection = Axis.vertical,
    this.padding,
    this.separatorHeight = 10,
    this.itemWidth = double.infinity,
    this.itemHeight = 100,
    this.borderRadius = 10,
    this.shrinkWrap = true,
    this.physics = true,
  });

  final int itemCount;
  final Axis scrollDirection;
  final EdgeInsetsGeometry? padding;
  final double separatorHeight;
  final double itemWidth;
  final double itemHeight;
  final double borderRadius;
  final bool shrinkWrap;
  final bool physics;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      scrollDirection: scrollDirection,
      padding: padding,
      shrinkWrap: shrinkWrap,
      physics: physics ? const NeverScrollableScrollPhysics() : null,
      itemCount: itemCount,
      separatorBuilder: (context, index) => SizedBox(
        height: scrollDirection == Axis.vertical ? separatorHeight : 0,
        width: scrollDirection == Axis.horizontal ? separatorHeight : 0,
      ),
      itemBuilder: (context, index) => ShimmerCard(
        width: itemWidth,
        height: itemHeight,
        borderRadius: borderRadius,
      ),
    );
  }
}
