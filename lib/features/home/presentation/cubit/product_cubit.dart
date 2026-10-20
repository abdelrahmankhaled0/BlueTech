import 'package:beauty_app/features/home/data/models/product_model.dart';
import 'package:beauty_app/features/home/data/repo/product_repo.dart';
import 'package:beauty_app/features/home/presentation/cubit/product_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductCubit extends Cubit<ProductStates> {
  ProductCubit() : super(ProductInitialState());
  static ProductCubit get(BuildContext context) => BlocProvider.of(context);

  List<ProductModel> products = [];
  List<ProductModel> searchedProducts = [];
  int _searchRequestId = 0;

  Future<void> getProducts() async {
    emit(GetProductsLoadingState());
    try {
      products = await ProductRepo.getProducts();

      emit(GetProductsSuccessState(products: products));
    } on Exception catch (error) {
      emit(GetProductsErrorState(error: error.toString()));
    }
  }

  Future<void> searchProducts({required String query}) async {
    final normalizedQuery = query.trim();
    final requestId = ++_searchRequestId;

    if (normalizedQuery.isEmpty) {
      searchedProducts = [];
      emit(SearchProductsSuccessState(searchedProducts: products));
      return;
    }

    try {
      emit(SearchProductsLoadingState());
      final results = await ProductRepo.searchProduct(query: normalizedQuery);
      if (requestId != _searchRequestId) return;

      searchedProducts = results;
      emit(SearchProductsSuccessState(searchedProducts: searchedProducts));
    } on Exception catch (e) {
      if (requestId != _searchRequestId) return;
      emit(SearchProductsErrorState(error: e.toString()));
    }
  }
}
