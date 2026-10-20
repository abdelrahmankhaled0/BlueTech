import 'package:beauty_app/features/home/presentation/cubit/product_cubit.dart';
import 'package:beauty_app/features/home/data/models/product_model.dart';
import 'package:beauty_app/features/home/presentation/screens/product_details_screen.dart';
import 'package:beauty_app/features/home/presentation/screens/product_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class AppRoutes {
  static const String product = "/";
  static const String productDetails = "/productDetails";
  static final routes = GoRouter(
    initialLocation: product,
    routes: [
      GoRoute(
        path: product,
        builder: (context, state) => BlocProvider(
          create: (context) => ProductCubit()..getProducts(),
          child: ProductScreen(),
        ),
      ),
      GoRoute(
        path: productDetails,
        builder: (context, state) {
          final product = state.extra;
          if (product is! ProductModel) {
            throw StateError('Product details route requires a product.');
          }
          return ProductDetailsScreen(product: product);
        },
      ),
    ],
  );
}
