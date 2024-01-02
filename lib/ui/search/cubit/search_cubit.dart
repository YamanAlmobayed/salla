// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'package:salla/repository/models/search_model.dart';
import 'package:salla/repository/shop_repository.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit({required this.shopRepository}) : super(SearchInitial());

  final ShopRepository shopRepository;

  void searchProducts(String query) async {
    emit(SearchLoading());
    try {
      final searchResults = await shopRepository.searchProducts(query: query);
      if (searchResults.status!) {
        emit(SearchSuccess(searchResults));
      } else {
        emit(SearchError(searchResults.message!));
      }
    } catch (e) {
      emit(SearchError(e.toString()));
    }
  }
}
