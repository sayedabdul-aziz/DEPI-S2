import 'package:flutter/material.dart';
import 'package:swap/components/widgets/pagination/animated_list_widget.dart';
import 'package:visibility_detector/visibility_detector.dart';

typedef PaginatedGridItemBuilder<T> = Widget Function(
  BuildContext context,
  T item,
  int index,
);

class PaginatedGridView<T> extends StatelessWidget {
  const PaginatedGridView({
    super.key,
    required this.items,
    required this.itemBuilder,
    required this.onLoadMore,
    required this.hasMore,
    required this.isLoadingMore,
    required this.gridDelegate,
    this.padding,
    this.physics,
    this.loadingWidget,
    this.loadMoreVisibilityThreshold = 0.4,
    this.shrinkWrap = true,
    this.emptyWidget,
    this.enableAnimation = true,
    this.animationDelay = 50,
  });

  final List<T> items;
  final PaginatedGridItemBuilder<T> itemBuilder;

  final VoidCallback onLoadMore;
  final bool hasMore;
  final bool isLoadingMore;

  final SliverGridDelegate gridDelegate;
  final EdgeInsets? padding;
  final ScrollPhysics? physics;
  final Widget? loadingWidget;
  final double loadMoreVisibilityThreshold;
  final bool shrinkWrap;
  final Widget? emptyWidget;
  final bool enableAnimation;
  final int animationDelay;

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty && !isLoadingMore) {
      return emptyWidget ??
          const Center(
            child: Text('No data available'),
          );
    }
    return GridView.builder(
      shrinkWrap: shrinkWrap,
      physics: physics ?? const NeverScrollableScrollPhysics(),
      padding: padding,
      itemCount: items.length + (isLoadingMore ? 1 : 0),
      gridDelegate: gridDelegate,
      itemBuilder: (context, index) {
        // Loading item
        if (index >= items.length) {
          return SizedBox.shrink();
        }

        final item = items[index];
        final isLastItem = index == items.length - 1;

        Widget builtItem = itemBuilder(context, item, index);

        // Wrap with animation if enabled
        if (enableAnimation && index < 20) {
          builtItem = AnimatedListWidget(
            index: index,
            delay: animationDelay,
            child: builtItem,
          );
        }

        // Trigger pagination
        if (isLastItem && hasMore && !isLoadingMore && items.isNotEmpty) {
          return VisibilityDetector(
            key: Key('grid-pagination-trigger-$index'),
            onVisibilityChanged: (info) {
              if (info.visibleFraction > loadMoreVisibilityThreshold &&
                  hasMore &&
                  !isLoadingMore) {
                onLoadMore();
              }
            },
            child: builtItem,
          );
        }

        return builtItem;
      },
    );
  }
}
