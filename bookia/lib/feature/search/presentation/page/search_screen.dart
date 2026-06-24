import 'package:bookia/core/styles/colors.dart';
import 'package:bookia/core/styles/text_styles.dart';
import 'package:bookia/core/widgets/shimmer/shimmer_grid_view.dart';
import 'package:bookia/feature/home/data/model/best_seller_response/product.dart';
import 'package:bookia/feature/home/presentation/widgets/book_card.dart';
import 'package:bookia/feature/search/presentation/cubit/search_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SearchCubit(),
      child: Scaffold(
        backgroundColor: AppColors.backgroundColor,
        appBar: AppBar(
          backgroundColor: AppColors.backgroundColor,
          elevation: 0,
          leading: const BackButton(color: AppColors.darkColor),
          title: _SearchField(controller: _controller),
        ),
        body: const _SearchBody(),
      ),
    );
  }
}

class _SearchField extends StatelessWidget {
  const _SearchField({required this.controller});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SearchCubit>();
    return TextField(
      controller: controller,
      autofocus: true,
      onChanged: cubit.onSearchChanged,
      style: TextStyles.body,
      decoration: InputDecoration(
        hintText: 'Search books...',
        hintStyle: TextStyles.body.copyWith(color: AppColors.greyColor),
        filled: true,
        fillColor: AppColors.white,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.borderColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.borderColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.primaryColor),
        ),
      ),
    );
  }
}

class _SearchBody extends StatelessWidget {
  const _SearchBody();

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SearchCubit>();
    return BlocBuilder<SearchCubit, PagingState<int, Product>>(
      builder: (context, pagingState) {
        if (pagingState.isLoading && pagingState.pages == null) {
          return ShimmerGridView(
            itemCount: 6,
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            mainAxisExtent: 290,
          );
        }

        if (pagingState.error != null && pagingState.pages == null) {
          return const _EmptyPrompt(message: 'Something went wrong');
        }

        final items = pagingState.pages?.expand((p) => p).toList() ?? [];
        if (!pagingState.isLoading && items.isEmpty) {
          return const _EmptyPrompt(message: 'No books found');
        }

        return Padding(
          padding: const EdgeInsets.all(16),
          child: PagedGridView<int, Product>(
            state: pagingState,
            fetchNextPage: cubit.fetchNextPage,
            padding: EdgeInsets.zero,

            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 0.62,
            ),
            builderDelegate: PagedChildBuilderDelegate<Product>(
              itemBuilder: (context, item, index) => BookCard(book: item),
              newPageProgressIndicatorBuilder: (_) => const Center(
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: CircularProgressIndicator(),
                ),
              ),
              newPageErrorIndicatorBuilder: (_) => Center(
                child: TextButton(
                  onPressed: cubit.fetchNextPage,
                  child: const Text('Retry'),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _EmptyPrompt extends StatelessWidget {
  const _EmptyPrompt({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.search, size: 64, color: AppColors.greyColor),
          const Gap(12),
          Text(
            message,
            style: TextStyles.body.copyWith(color: AppColors.greyColor),
          ),
        ],
      ),
    );
  }
}
