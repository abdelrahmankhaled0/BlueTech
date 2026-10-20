import 'package:beauty_app/core/service/remote/app_end_points.dart';
import 'package:beauty_app/core/service/remote/dio_helper.dart';
import 'package:beauty_app/features/home/data/models/product_model.dart';

class ProductRepo {
  static Future<List<ProductModel>> getProducts() async {
    final response = await DioHelper.get(
      endPoint: AppEndPoints.products,
      queryParameters: {'limit': 0},
    );
    final data = response.data;

    if (data is! Map<String, dynamic>) {
      throw const FormatException('Invalid products response.');
    }

    final products = data['products'];
    if (products is! List) {
      throw const FormatException('Products list is missing from response.');
    }

    return products.map((product) {
      if (product is! Map<String, dynamic>) {
        throw const FormatException('Invalid product in response.');
      }
      return ProductModel.fromJson(product);
    }).toList();
  }

  static Future<List<ProductModel>> searchProduct({
    required String query,
  }) async {
    var response = await DioHelper.get(
      endPoint: AppEndPoints.search,
      queryParameters: {"q": query},
    );
    final data = response.data;
    final products = data["products"] as List;
    return products.map((product) {
      return ProductModel.fromJson(product);
    }).toList();
  }
}
