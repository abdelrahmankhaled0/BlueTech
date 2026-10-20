import 'package:beauty_app/features/home/data/models/product_model.dart';

abstract class ProductStates {}

class ProductInitialState extends ProductStates {}

class GetProductsLoadingState extends ProductStates {}

class GetProductsSuccessState extends ProductStates {
  final List<ProductModel> products;

  GetProductsSuccessState({required this.products});
}

class GetProductsErrorState extends ProductStates {
  final String error;

  GetProductsErrorState({required this.error});
}

class SearchProductsLoadingState extends ProductStates {}

class SearchProductsSuccessState extends ProductStates {
  final List<ProductModel> searchedProducts;

  SearchProductsSuccessState({required this.searchedProducts});
}

class SearchProductsErrorState extends ProductStates {
  final String error;

  SearchProductsErrorState({required this.error});
}
