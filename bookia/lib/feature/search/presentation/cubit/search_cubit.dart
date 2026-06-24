import 'dart:async';

import 'package:bookia/feature/home/data/model/best_seller_response/product.dart';
import 'package:bookia/feature/search/data/repo/search_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class SearchCubit extends Cubit<PagingState<int, Product>> {
  SearchCubit() : super(PagingState()) {
    fetchNextPage();
  }

  String _currentQuery = '';
  Timer? _debounce;
  int _lastPage = 1;

  void onSearchChanged(String query) {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      search(query.trim());
    });
  }

  void search(String query) {
    _currentQuery = query;
    _lastPage = 1;
    emit(state.reset());
    fetchNextPage();
  }

  Future<void> fetchNextPage() async {
    if (state.isLoading || !state.hasNextPage) return;

    final nextPage = (state.pages?.length ?? 0) + 1;

    emit(state.copyWith(isLoading: true, error: null));

    final response = await SearchRepo.searchProducts(
      _currentQuery,
      page: nextPage,
    );

    if (isClosed) return;

    if (response == null) {
      emit(
        state.copyWith(isLoading: false, error: Exception('Failed to load')),
      );
      return;
    }

    _lastPage = response.data?.meta?.lastPage ?? 1;
    final newProducts = response.data?.products ?? [];
    final updatedPages = [...?state.pages, newProducts];
    final updatedKeys = [...?state.keys, nextPage];

    emit(
      state.copyWith(
        isLoading: false,
        pages: updatedPages,
        keys: updatedKeys,
        hasNextPage: nextPage < _lastPage,
        error: null,
      ),
    );
  }

  @override
  Future<void> close() {
    _debounce?.cancel();
    return super.close();
  }
}
