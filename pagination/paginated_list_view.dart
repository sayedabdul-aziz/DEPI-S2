import 'package:flutter/material.dart';
import 'package:swap/components/widgets/pagination/animated_list_widget.dart';
import 'package:visibility_detector/visibility_detector.dart';

typedef PaginatedItemBuilder<T> = Widget Function(
  BuildContext context,
  T item,
  int index,
);

class PaginatedListView<T> extends StatelessWidget {
  const PaginatedListView({
    super.key,
    required this.items,
    required this.itemBuilder,
    required this.onLoadMore,
    required this.hasMore,
    required this.isLoadingMore,
    this.padding,
    this.physics,
    this.loadingWidget,
    this.loadMoreVisibilityThreshold = 0.4,
    this.shrinkWrap = true,
    this.emptyWidget,
    this.scrollDirection = Axis.vertical,
    this.separatorWidget,
    this.enableAnimation = true,
    this.animationDelay = 50,
  });

  final List<T> items;
  final PaginatedItemBuilder<T> itemBuilder;

  final VoidCallback onLoadMore;
  final bool hasMore;
  final bool isLoadingMore;

  final EdgeInsets? padding;
  final ScrollPhysics? physics;
  final Widget? loadingWidget;
  final double loadMoreVisibilityThreshold;
  final bool shrinkWrap;
  final Widget? emptyWidget;
  final Widget? separatorWidget;
  final Axis scrollDirection;
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
    return ListView.separated(
      shrinkWrap: shrinkWrap,
      physics: physics ?? const NeverScrollableScrollPhysics(),
      padding: padding,
      separatorBuilder: (context, index) =>
          separatorWidget ?? const SizedBox.shrink(),
      scrollDirection: scrollDirection,
      itemCount: items.length + (isLoadingMore ? 1 : 0),
      itemBuilder: (context, index) {
        // Loading item
        if (index >= items.length) {
          return SizedBox.shrink();
        }

        final item = items[index];
        final isLastItem = index == items.length - 1;

        Widget builtItem = itemBuilder(context, item, index);

        // Wrap with animation if enabled
        if (enableAnimation) {
          builtItem = AnimatedListWidget(
            index: index,
            delay: animationDelay,
            child: builtItem,
          );
        }

        // Trigger pagination
        if (isLastItem && hasMore && !isLoadingMore && items.isNotEmpty) {
          return VisibilityDetector(
            key: Key('list-pagination-trigger-$index'),
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
